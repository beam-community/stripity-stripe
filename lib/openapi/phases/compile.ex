defmodule Stripe.OpenApi.Phases.Compile do
  @moduledoc false
  def run(blueprint, _options) do
    modules = Enum.map(blueprint.components, fn {_k, component} -> component.module end)

    for {_name, component} <- blueprint.components do
      funcs_types =
        for operation <- component.operations,
            operation_definition =
              lookup_operation(
                {operation["path"], String.to_atom(operation["operation"])},
                blueprint.operations
              ),
            operation_definition != nil do
          arguments =
            operation_definition.path_parameters
            |> Enum.map(&String.to_atom(&1.name))

          params? =
            match?({:object, _, [_ | _]}, operation_definition.query_parameters) ||
              match?({:object, _, [_ | _]}, operation_definition.body_parameters)

          argument_names =
            arguments
            |> Enum.map(fn
              name ->
                Macro.var(name, __MODULE__)
            end)

          argument_values =
            arguments
            |> Enum.reject(&(&1 == :params))
            |> Enum.map(fn name ->
              Macro.var(name, __MODULE__)
            end)

          argument_specs =
            arguments
            |> Enum.map(fn
              :params ->
                quote do
                  params :: map()
                end

              name ->
                quote do
                  unquote(Macro.var(name, __MODULE__)) :: binary()
                end
            end)

          function_name = String.to_atom(operation["method_name"])

          success_response_spec = return_spec(operation_definition.success_response)

          params =
            cond do
              operation_definition.query_parameters != {:object, [], []} ->
                operation_definition.query_parameters

              operation_definition.body_parameters != {:object, [], []} ->
                operation_definition.body_parameters

              true ->
                []
            end

          {param_specs, object_types} = unnest_object_types(params)

          object_types = MapSet.to_list(object_types)

          ast =
            quote do
              if unquote(operation_definition.deprecated) do
                @deprecated "Stripe has deprecated this operation"
              end

              @operation unquote(Macro.escape(operation_definition))
              @doc unquote(operation_definition.description)

              if unquote(params?) do
                @spec unquote(function_name)(
                        unquote_splicing(argument_specs),
                        params :: unquote(to_inline_spec(param_specs)),
                        opts :: Keyword.t()
                      ) ::
                        {:ok, unquote(success_response_spec)}
                        | {:error, Stripe.ApiErrors.t()}
                        | {:error, term()}
                def unquote(function_name)(
                      unquote_splicing(argument_names),
                      params \\ %{},
                      opts \\ []
                    ) do
                  path =
                    Stripe.OpenApi.Path.replace_path_params(
                      @operation.path,
                      @operation.path_parameters,
                      unquote(argument_names)
                    )

                  Stripe.Request.new_request(opts)
                  |> Stripe.Request.put_endpoint(path)
                  |> Stripe.Request.put_params(params)
                  |> Stripe.Request.put_method(@operation.method)
                  |> Stripe.Request.make_request()
                end
              else
                @spec unquote(function_name)(
                        unquote_splicing(argument_specs),
                        opts :: Keyword.t()
                      ) ::
                        {:ok, unquote(success_response_spec)}
                        | {:error, Stripe.ApiErrors.t()}
                        | {:error, term()}
                def unquote(function_name)(
                      unquote_splicing(argument_names),
                      opts \\ []
                    ) do
                  path =
                    Stripe.OpenApi.Path.replace_path_params(
                      @operation.path,
                      @operation.path_parameters,
                      unquote(argument_values)
                    )

                  Stripe.Request.new_request(opts)
                  |> Stripe.Request.put_endpoint(path)
                  |> Stripe.Request.put_method(@operation.method)
                  |> Stripe.Request.make_request()
                end
              end
            end

          {ast, object_types}
        end

      {funcs, types} = Enum.unzip(funcs_types)
      fields = component.properties |> Map.keys() |> Enum.map(&String.to_atom/1)

      # TODO fix  uniq
      types =
        List.flatten(types)
        |> Enum.uniq_by(fn {_, meta, _} -> meta[:name] end)
        |> Enum.map(&to_type_spec/1)

      specs =
        Enum.map(component.properties, fn {key, value} ->
          {String.to_atom(key), build_spec(value, modules)}
        end)

      typedoc_fields =
        component.properties |> Enum.map_join("\n", fn {key, value} -> typedoc(key, value) end)

      typedoc = """
      The `#{component.name}` type.

      #{typedoc_fields}
      """

      body =
        quote do
          use Stripe.Entity

          @moduledoc unquote(component.description)
          if unquote(fields) != nil do
            defstruct unquote(fields)

            @typedoc unquote(typedoc)
            @type t :: %__MODULE__{
                    unquote_splicing(specs)
                  }
          end

          unquote_splicing(types)

          (unquote_splicing(funcs))
        end

      Module.create(component.module, body, Macro.Env.location(__ENV__))
    end

    {:ok, blueprint}
  end

  defp unnest_object_types(params) do
    Macro.postwalk(params, MapSet.new(), fn
      {:object, meta, children}, acc ->
        if meta[:name] == nil || children == [] do
          {{:object, meta, children}, acc}
        else
          {{:ref, [name: meta[:name]], []}, MapSet.put(acc, {:object, meta, children})}
        end

      other, acc ->
        {other, acc}
    end)
  end

  defp to_type_spec({:object, meta, children}) do
    specs = Enum.map(children, &to_spec_map/1)

    name = type_spec_name(meta[:name])

    quote do
      @typedoc unquote(meta[:description])
      @type unquote(Macro.var(name, __MODULE__)) :: %{
              unquote_splicing(specs)
            }
    end
  end

  defp to_type_spec({:array, meta, [child]} = _ast) do
    name = type_spec_name(meta[:name])

    quote do
      @typedoc unquote(meta[:description])
      @type unquote(Macro.var(name, __MODULE__)) :: unquote(to_type(child))
    end
  end

  defp to_type_spec({_, meta, children}) do
    specs = Enum.map(children, &to_spec_map/1)

    name = type_spec_name(meta[:name])

    quote do
      @typedoc unquote(meta[:description])
      @type unquote(Macro.var(name, __MODULE__)) :: %{
              unquote_splicing(specs)
            }
    end
  end

  defp type_spec_name(name) do
    if name in [:reference] do
      :reference_0
    else
      name
    end
  end

  defp to_inline_spec({_, _meta, children}) do
    specs = Enum.map(children, &to_spec_map/1)

    quote do
      %{
        unquote_splicing(specs)
      }
    end
  end

  defp to_spec_map({:array, meta, [_type]} = ast) do
    {to_name(meta), to_type(ast)}
  end

  defp to_spec_map({:any_of, meta, [type | tail]}) do
    {to_name(meta),
     quote do
       unquote(to_type(type)) | unquote(to_type(tail))
     end}
  end

  defp to_spec_map({:ref, meta, _} = ast) do
    {to_name(meta), to_type(ast)}
  end

  defp to_spec_map({_type, meta, _children} = ast) do
    {to_name(meta), to_type(ast)}
  end

  defp to_name(meta) do
    if meta[:required] do
      meta[:name]
    else
      quote do
        optional(unquote(meta[:name]))
      end
    end
  end

  def to_type([type]) do
    quote do
      unquote(to_type(type))
    end
  end

  def to_type([type | tail]) do
    quote do
      unquote(to_type(type)) | unquote(to_type(tail))
    end
  end

  def to_type({:ref, meta, _}) do
    Macro.var(meta[:name], __MODULE__)
  end

  def to_type({:array, _meta, [type]}) do
    quote do
      list(unquote(to_type(type)))
    end
  end

  def to_type({:any_of, _, [type | tail]}) do
    quote do
      unquote(to_type(type)) | unquote(to_type(tail))
    end
  end

  def to_type({:string, metadata, _}) do
    if metadata[:enum] do
      to_type(metadata[:enum])
    else
      to_type(:string)
    end
  end

  def to_type({:object, metadata, _}) do
    if metadata[:name] == :metadata do
      quote do
        %{optional(binary) => binary}
      end
    else
      quote do
        map()
      end
    end
  end

  def to_type({type, _, _}) do
    to_type(type)
  end

  def to_type(type) when type in [:boolean, :number, :integer, :float] do
    quote do
      unquote(Macro.var(type, __MODULE__))
    end
  end

  def to_type(:string) do
    quote do
      binary
    end
  end

  def to_type(type) do
    type
  end

  defp return_spec(%OpenApiGen.Blueprint.Reference{name: name}) do
    module = module_from_ref(name)

    quote do
      unquote(module).t()
    end
  end

  defp return_spec(%OpenApiGen.Blueprint.ListOf{type_of: type}) do
    quote do
      Stripe.List.t(unquote(return_spec(type)))
    end
  end

  defp return_spec(%OpenApiGen.Blueprint.SearchResult{type_of: type}) do
    quote do
      Stripe.SearchResult.t(unquote(return_spec(type)))
    end
  end

  defp return_spec(%{any_of: [type]} = _type) do
    return_spec(type)
  end

  defp return_spec(%OpenApiGen.Blueprint.AnyOf{any_of: [any_of | tail]} = type) do
    type = Map.put(type, :any_of, tail)
    {:|, [], [return_spec(any_of), return_spec(type)]}
  end

  defp return_spec(_) do
    []
  end

  defp build_spec(%{"nullable" => true} = type, modules) do
    type = Map.delete(type, "nullable")
    {:|, [], [build_spec(type, modules), nil]}
  end

  defp build_spec(%{"anyOf" => [type]} = _type, modules) do
    build_spec(type, modules)
  end

  defp build_spec(%{"anyOf" => [any_of | tail]} = type, modules) do
    type = Map.put(type, "anyOf", tail)
    {:|, [], [build_spec(any_of, modules), build_spec(type, modules)]}
  end

  defp build_spec(%{"type" => "string"}, _) do
    quote do
      binary
    end
  end

  defp build_spec(%{"type" => "boolean"}, _) do
    quote do
      boolean
    end
  end

  defp build_spec(%{"type" => "integer"}, _) do
    quote do
      integer
    end
  end

  defp build_spec(%{"$ref" => ref}, modules) do
    module = module_from_ref(ref)

    if module in modules do
      quote do
        unquote(module).t()
      end
    else
      quote do
        term
      end
    end
  end

  defp build_spec(_, _) do
    quote do
      term
    end
  end

  defp module_from_ref(ref) do
    module =
      ref |> String.split("/") |> List.last() |> String.split(".") |> Enum.map(&Macro.camelize/1)

    Module.concat(["Stripe" | module])
  end

  defp typedoc(field, props) do
    "  * `#{field}` #{props["description"]}"
  end

  defp lookup_operation(path, operations) do
    Map.get(operations, path)
  end
end

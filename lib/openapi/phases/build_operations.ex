defmodule Stripe.OpenApi.Phases.BuildOperations do
  @moduledoc false
  def run(blueprint, _options \\ []) do
    operations =
      for {path, map} <- blueprint.source["paths"],
          {method, map} <- map,
          into: %{} do
        name =
          map["operationId"]
          |> String.replace(["/", "-"], "_")
          |> Macro.underscore()
          |> String.to_atom()

        method = String.to_atom(method)

        parameters = parameters(map["parameters"])

        path_params =
          parameters
          |> Enum.filter(&(&1.in == "path"))

        query_params =
          {:object, [],
           (map["parameters"] || [])
           |> Enum.filter(&(&1["in"] == "query"))
           |> Enum.map(fn param ->
             to_ast(param, name: param["name"], required: param["required"])
           end)}

        # TODO handle file upload
        schema =
          map["requestBody"]["content"]["application/x-www-form-urlencoded"]["schema"] || %{}

        metadata = [function_name: name]

        body_parameters =
          {:object, metadata,
           Enum.map(Map.get(schema, "properties", %{}), fn {key, value} ->
             required = key in (schema["required"] || [])

             to_ast(
               value,
               Keyword.merge(metadata,
                 name: key,
                 required: required,
                 description: schema["description"]
               )
             )
           end)}

        operation = %OpenApiGen.Blueprint.Operation{
          id: map["operationId"],
          description: map["description"],
          deprecated: map["deprecated"] || false,
          method: method,
          name: name,
          parameters: parameters,
          path_parameters: path_params,
          query_parameters: query_params,
          body_parameters: body_parameters,
          path: path,
          success_response:
            response_type(map["responses"]["200"]["content"]["application/json"]["schema"])
        }

        {{operation.path, operation.method}, operation}
      end

    blueprint = Map.put(blueprint, :operations, operations)
    {:ok, blueprint}
  end

  defp to_ast(value, metadata)

  defp to_ast(%{"type" => "array"} = schema, metadata) do
    {
      :array,
      [
        name: build_name(metadata[:name]),
        # type: value["type"] && String.to_atom(value["type"] || :unknown),
        in: "body",
        required: false,
        description: schema["description"]
      ],
      [to_ast(schema["items"], metadata)]
    }
  end

  defp to_ast(%{"type" => "object"} = schema, metadata) do
    {
      :object,
      [
        name: build_name(metadata[:name]),
        description: schema["description"]
      ],
      Enum.map(schema["properties"] || [], fn {key, value} ->
        required = key in (schema["required"] || [])

        to_ast(value, Keyword.merge(metadata, name: key, required: required))
      end)
    }
  end

  defp to_ast(%{"type" => "string", "enum" => enum} = schema, metadata) when enum != [""] do
    {
      :string,
      [
        name: build_name(metadata[:name]),
        description: schema["description"],
        enum: enum |> Enum.reject(&(&1 == "")) |> Enum.map(&String.to_atom/1)
      ],
      []
    }
  end

  defp to_ast(%{"type" => type} = schema, metadata) do
    {
      String.to_atom(type),
      [
        name: build_name(metadata[:name]),
        description: schema["description"]
      ],
      []
    }
  end

  defp to_ast(%{"anyOf" => types} = schema, metadata) do
    {
      :any_of,
      [
        name: build_name(metadata[:name]),
        description: schema["description"]
      ],
      Enum.map(types, &to_ast(&1, metadata))
    }
  end

  defp to_ast(%{"schema" => schema} = _value, metadata) do
    to_ast(schema, Keyword.put(metadata, :description, schema["description"]))
  end

  defp build_name(nil) do
    nil
  end

  defp build_name(name) when is_binary(name) do
    String.to_atom(name)
  end

  defp build_name(name) when is_atom(name) do
    name
  end

  defp response_type(%{"$ref" => ref}), do: %OpenApiGen.Blueprint.Reference{name: ref}

  defp response_type(%{"anyOf" => any_of}),
    do: %OpenApiGen.Blueprint.AnyOf{any_of: Enum.map(any_of, &response_type/1)}

  defp response_type(%{
         "properties" => %{
           "object" => %{
             "enum" => [
               "search_result"
             ]
           },
           "data" => %{"items" => items}
         }
       }) do
    %OpenApiGen.Blueprint.SearchResult{type_of: response_type(items)}
  end

  defp response_type(%{
         "properties" => %{
           "data" => %{"items" => items}
         }
       }),
       do: %OpenApiGen.Blueprint.ListOf{type_of: response_type(items)}

  defp response_type(val), do: val

  defp parameters(nil) do
    []
  end

  defp parameters(params) do
    Enum.map(
      params,
      &%OpenApiGen.Blueprint.Parameter{
        in: &1["in"],
        name: &1["name"],
        required: &1["required"],
        schema: build_schema(&1["schema"], &1["name"])
      }
    )
  end

  defp build_schema(schema, name)

  defp build_schema(%{"type" => type} = schema, name)
       when type in ["string", "integer", "boolean", "number"] do
    %OpenApiGen.Blueprint.Parameter.Schema{
      type: schema["type"],
      name: name
    }
  end

  defp build_schema(%{"type" => "array"} = schema, name) do
    %OpenApiGen.Blueprint.Parameter.Schema{
      type: schema["type"],
      items: build_schema(schema["items"], name),
      name: name
    }
  end

  defp build_schema(%{"type" => "object"} = schema, name) do
    %OpenApiGen.Blueprint.Parameter.Schema{
      type: schema["type"],
      name: name,
      properties:
        (schema["properties"] || []) |> Enum.map(&build_schema(elem(&1, 1), elem(&1, 0)))
    }
  end

  defp build_schema(%{"anyOf" => any_of} = _schema, name) do
    %OpenApiGen.Blueprint.Parameter.Schema{
      type: :any_of,
      any_of: any_of |> Enum.map(&build_schema(&1, name)),
      name: name
    }
  end
end

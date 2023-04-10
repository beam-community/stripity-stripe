defmodule Stripe.Converter do
  @doc """
  Takes a result map or list of maps from a Stripe response and returns a
  struct (e.g. `%Stripe.Card{}`) or list of structs.

  If the result is not a supported Stripe object, it just returns a plain map
  with atomized keys.
  """

  @spec convert_result(%{String.t() => any}) :: struct
  def convert_result(result), do: convert_value(result)

  @no_convert_maps ~w(metadata supported_bank_account_currencies)

  @spec convert_value(any) :: any
  defp convert_value(%{"object" => object_name} = value) when is_binary(object_name) do
    case known_struct?(object_type_to_struct(object_name)) do
      true ->
        convert_stripe_object(value)

      false ->
        warn_unknown_object(value)
        convert_map(value)
    end
  end

  defp convert_value(value) when is_map(value), do: convert_map(value)
  defp convert_value(value) when is_list(value), do: convert_list(value)
  defp convert_value(value), do: value

  @spec convert_map(map) :: map
  defp convert_map(value) do
    Enum.reduce(value, %{}, fn {key, value}, acc ->
      Map.put(acc, String.to_atom(key), convert_value(value))
    end)
  end

  @spec convert_stripe_object(%{String.t() => any}) :: struct
  defp convert_stripe_object(%{"object" => object_name} = value) do
    module = Stripe.Util.object_name_to_module(object_name)
    struct_keys = Map.keys(module.__struct__) |> List.delete(:__struct__)
    check_for_extra_keys(struct_keys, value)

    processed_map =
      struct_keys
      |> Enum.reduce(%{}, fn key, acc ->
        string_key = to_string(key)

        converted_value =
          case string_key do
            string_key when string_key in @no_convert_maps -> Map.get(value, string_key)
            _ -> Map.get(value, string_key) |> convert_value()
          end

        Map.put(acc, key, converted_value)
      end)
      |> module.__from_json__()

    struct(module, processed_map)
  end

  @spec convert_list(list) :: list
  defp convert_list(list), do: list |> Enum.map(&convert_value/1)

  if Mix.env() == :prod do
    defp warn_unknown_object(_), do: :ok
  else
    defp warn_unknown_object(%{"object" => object_name}) do
      require Logger

      Logger.warn("Unknown object received: #{object_name}")
    end
  end

  if Mix.env() == :prod do
    defp check_for_extra_keys(_, _), do: :ok
  else
    defp check_for_extra_keys(struct_keys, map) do
      require Logger

      map_keys =
        map
        |> Map.keys()
        |> Enum.map(&String.to_atom/1)
        |> MapSet.new()

      struct_keys =
        struct_keys
        |> MapSet.new()

      extra_keys =
        map_keys
        |> MapSet.difference(struct_keys)
        |> Enum.to_list()

      unless Enum.empty?(extra_keys) do
        object = Map.get(map, "object")

        module_name =
          object
          |> Stripe.Util.object_name_to_module()
          |> Stripe.Util.module_to_string()

        details = "#{module_name}: #{inspect(extra_keys)}"
        message = "Extra keys were received but ignored when converting #{details}"
        Logger.warn(message)
      end

      :ok
    end
  end

  defp object_type_to_struct(object) do
    module = object |> String.split(".") |> Enum.map(&Macro.camelize/1)
    Module.concat(["Stripe" | module])
  end

  defp known_struct?(struct) do
    Code.ensure_loaded?(struct) && function_exported?(struct, :__struct__, 0)
  end
end

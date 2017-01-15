defmodule Stripe.Converter do

  @doc """
  Takes the module (e.g. `Stripe.Card`) and the response from Stripe and
  returns a struct (e.g. `%Stripe.Card{}`) containing the Stripe response.
  """
  @spec stripe_map_to_struct(module, %{String.t => any}) :: struct
  def stripe_map_to_struct(module, response) do
    [_|struct_keys] = Map.keys(module.__struct__)

    processed_map =
      Enum.reduce(struct_keys, %{}, fn key, acc ->
        value =
          fetch_value(response, key)
          |> convert_value()

        Map.put(acc, key, value)
      end)

    struct(module, processed_map)
  end

  defp fetch_value(response, key) do
    case Map.fetch(response, key) do
      {:ok, value} -> value
      :error -> Map.get(response, convert_key(key))
    end
  end

  defp convert_key(key) when is_atom(key), do: to_string(key)
  defp convert_key(key) when is_binary(key), do: String.to_atom(key)

  # converts list objects
  defp convert_value(%{"object" => "list"} = value), do: convert_map(value)

  # converts maps that are actually Stripe objects
  defp convert_value(%{"object" => object_name} = value) when is_binary(object_name) do
    object_name
    |> Stripe.Util.object_name_to_module
    |> stripe_map_to_struct(value)
  end

  # converts plain maps
  defp convert_value(value) when is_map(value), do: convert_map(value)

  # converts anything else
  defp convert_value(value), do: value

  defp convert_map(value) do
    Enum.reduce(value, %{}, fn({key, value}, acc) ->
      Map.put(acc, String.to_atom(key), convert_value(value))
    end)
  end
end

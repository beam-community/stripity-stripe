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

        value = Map.get(module.relationships, key)
        |> build_struct(value)

        Map.put(acc, key, value)
      end)

    struct(module, processed_map)
  end

  defp build_struct(nil, value), do: value
  defp build_struct(_module, nil), do: nil
  defp build_struct(DateTime, value) do
    {:ok, value} = DateTime.from_unix(value)
    value
  end
  defp build_struct(module, value) when is_map(value) do
    stripe_map_to_struct(module, value)
  end

  defp fetch_value(response, key) do
    case Map.fetch(response, key) do
      {:ok, value} -> value
      :error -> Map.get(response, convert_key(key))
    end
  end

  defp convert_key(key) when is_atom(key), do: to_string(key)
  defp convert_key(key) when is_binary(key), do: String.to_atom(key)

  defp convert_value(value) when is_map(value) do
    Enum.reduce(value, %{}, fn({key, value}, acc) ->
      Map.put(acc, String.to_atom(key), convert_value(value))
    end)
  end
  defp convert_value(value), do: value
end

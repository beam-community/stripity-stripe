defmodule Stripe.Converter do

  @doc """
  Takes the module (e.g. `Stripe.Card`) and the response from Stripe and
  returns a struct (e.g. `%Stripe.Card{}`) containing the Stripe response.
  """
  @spec stripe_map_to_struct(module, %{String.t => any}) :: struct
  def stripe_map_to_struct(module, response) do
    struct_keys = Map.keys(module.__struct__) |> List.delete(:__struct__)

    processed_map =
      Enum.reduce(struct_keys, %{}, fn key, acc ->
        string_key = to_string(key)
        converted_value = Map.get(response, string_key) |> convert_value()
        Map.put(acc, key, converted_value)
      end)

    struct(module, processed_map)
  end

  @supported_objects ~w(account bank_account card customer event external_account file_upload invoice list plan subscription token)

  # converts maps that are actually Stripe objects
  defp convert_value(%{"object" => object_name} = value) when is_binary(object_name) do
    case Enum.member?(@supported_objects, object_name) do
      true -> convert_stripe_object(value)
      false -> convert_map(value)
    end
  end

  # converts plain maps
  defp convert_value(value) when is_map(value), do: convert_map(value)

  # converts lists
  defp convert_value(value) when is_list(value), do: convert_list(value)

  # converts anything else
  defp convert_value(value), do: value

  defp convert_map(value) do
    Enum.reduce(value, %{}, fn({key, value}, acc) ->
      Map.put(acc, String.to_atom(key), convert_value(value))
    end)
  end

  defp convert_stripe_object(%{"object" => object_name} = value) do
    object_name
    |> Stripe.Util.object_name_to_module
    |> stripe_map_to_struct(value)
  end

  defp convert_list(list) do
    list |> Enum.map(&convert_value/1)
  end
end

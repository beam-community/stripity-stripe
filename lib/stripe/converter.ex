defmodule Stripe.Converter do

  @doc """
  Takes a result map or list of maps from a Stripe response and returns a
  struct (e.g. `%Stripe.Card{}`) or list of structs.

  If the result is not a supported Stripe object, it just returns a plain map
  with atomized keys.
  """
  @spec convert_result(%{String.t => any}) :: struct
  def convert_result(result), do: convert_value(result)

  @supported_objects ~w(account bank_account card customer event external_account 
    file_upload invoice list plan subscription token)

  @spec convert_value(any) :: any
  defp convert_value(%{"object" => object_name} = value) when is_binary(object_name) do
    case Enum.member?(@supported_objects, object_name) do
      true -> convert_stripe_object(value)
      false -> convert_map(value)
    end
  end
  defp convert_value(value) when is_map(value), do: convert_map(value)
  defp convert_value(value) when is_list(value), do: convert_list(value)
  defp convert_value(value), do: value

  @spec convert_map(map) :: map
  defp convert_map(value) do
    Enum.reduce(value, %{}, fn({key, value}, acc) ->
      Map.put(acc, String.to_atom(key), convert_value(value))
    end)
  end

  @spec convert_stripe_object(%{String.t => any}) :: struct
  defp convert_stripe_object(%{"object" => object_name} = value) do
    module = Stripe.Util.object_name_to_module(object_name)
    struct_keys = Map.keys(module.__struct__) |> List.delete(:__struct__)

    processed_map =
      Enum.reduce(struct_keys, %{}, fn key, acc ->
        string_key = to_string(key)
        converted_value = Map.get(value, string_key) |> convert_value()
        Map.put(acc, key, converted_value)
      end)

    struct(module, processed_map)
  end

  @spec convert_list(list) :: list
  defp convert_list(list), do: list |> Enum.map(&convert_value/1)
end

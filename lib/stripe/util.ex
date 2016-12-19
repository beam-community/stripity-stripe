defmodule Stripe.Util do
  @moduledoc false

  alias Stripe.Convert

  @doc """
  Takes the module (e.g. `Stripe.Card`) and the response from Stripe and
  returns a struct (e.g. `%Stripe.Card{}`) containing the Stripe response.
  """
  @spec stripe_map_to_struct(module, %{String.t => any}) :: struct
  def stripe_map_to_struct(module, stripe_response) do
    response_mapping = module.response_mapping()
    map = Enum.reduce response_mapping, %{}, fn ({key, format}, acc) ->
      value = key |> to_string() |> convert_value(format, stripe_response)
      Map.put(acc, key, value)
    end
    struct = struct(module, map)
  end

  defp convert_value(key, format, map) when is_map(format) do
    stripe_map_to_struct(format.module, map[key])
  end
  defp convert_value(key, :metadata, map) do
    map
    |> Map.get(key)
  end
  defp convert_value(key, format, map) do
    map
    |> Map.get(key)
    |> Convert.with_format(format)
  end

  def drop_nil_keys(map) do
    Enum.reject(map, fn
      {_, nil} -> true
      _ -> false
    end)
    |> Enum.into(%{})
  end

  @spec get_date(map, atom | String.t) :: DateTime.t | nil
  def get_date(m, k) do
    case Map.get(m, k) do
      nil -> nil
      ts -> datetime_from_timestamp(ts)
    end
  end

  defp datetime_from_timestamp(ts) when is_binary ts do
    ts = case Integer.parse ts do
      :error -> 0
      {i, _r} -> i
    end
    datetime_from_timestamp ts
  end

  defp datetime_from_timestamp(ts) when is_number ts do
    DateTime.from_unix!(ts)
  end

  @doc """
  Performs a root-level conversion of map keys from strings to atoms.

  This function performs the transformation safely using `String.to_existing_atom/1`, but this has a possibility to raise if
  there is not a corresponding atom.

  It is recommended that you pre-filter maps for known values before
  calling this function.

  ## Examples

  iex> map = %{
  ...>   "a"=> %{
  ...>     "b" => %{
  ...>       "c" => 1
  ...>     }
  ...>   }
  ...> }
  iex> Stripe.Util.map_keys_to_atoms(map)
  %{
    a: %{
      "b" => %{
        "c" => 1
      }
    }
  }
  """
  def map_keys_to_atoms(m) do
    Enum.map(m, fn
      {k, v} when is_binary(k)  ->
        a = String.to_existing_atom(k)
        {a, v}
      entry ->
        entry
    end)
    |> Enum.into(%{})
  end

  def string_map_to_atoms([string_key_map]) do
    string_map_to_atoms string_key_map
  end

  def string_map_to_atoms(string_key_map) do
    for {key, val} <- string_key_map, into: %{}, do: {String.to_atom(key), val}
  end
end

defmodule Stripe.Util do

  @spec get_date(map, atom | String.t) :: DateTime.t | nil
  def get_date(m, k) do
    case Map.get(m, k) do
      nil -> nil
      ts -> DateTime.from_unix!(ts)
    end
  end

  def datetime_from_timestamp(ts) when is_binary ts do
    ts = case Integer.parse ts do
      :error -> 0
      {i, _r} -> i
    end
    datetime_from_timestamp ts
  end

  def datetime_from_timestamp(ts) when is_number ts do
    {{year, month, day}, {hour, minutes, seconds}} = :calendar.gregorian_seconds_to_datetime ts
    {{year + 1970, month, day}, {hour, minutes, seconds}}
  end

  def datetime_from_timestamp(nil) do
    datetime_from_timestamp 0
  end

  def string_map_to_atoms([string_key_map]) do
    string_map_to_atoms string_key_map
  end

  def string_map_to_atoms(string_key_map) do
    for {key, val} <- string_key_map, into: %{}, do: {String.to_atom(key), val}
  end
end

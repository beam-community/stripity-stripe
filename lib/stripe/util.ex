defmodule Stripe.Util do
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

  def handle_stripe_response(res) do
    cond do
      res["error"] -> {:error, res["error"]["message"]}
      res["data"] -> {:ok, Enum.map(res["data"], &Stripe.Util.string_map_to_atoms &1)}
      true -> {:ok, Stripe.Util.string_map_to_atoms res}
    end
  end

  # returns the full response in {:ok, response}
  # this is useful to access top-level properties
  def handle_stripe_full_response(res) do
    cond do
      res["error"] -> {:error, res["error"]["message"]}
      true -> {:ok, Stripe.Util.string_map_to_atoms res}
    end
  end

  def list_raw( endpoint, limit \\ 10, startingAfter \\ "") do
    q = "#{endpoint}?limit=#{limit}"

    if String.length(startingAfter) > 0 do
      q = q ++ "&starting_after=#{startingAfter}"
    end

    Stripe.make_request(:get, q )
       |> Stripe.Util.handle_stripe_full_response
  end

  # most stripe listing endpoints allow the total count to be included without any results
  def count(endpoint) do
    case Stripe.make_request(:get, "#{endpoint}?include[]=total_count&limit=0")
            |> Stripe.Util.handle_stripe_full_response do
      {:ok, res} ->
        {:ok, res[:total_count]}
      {:error, err} -> raise err
    end
  end
end

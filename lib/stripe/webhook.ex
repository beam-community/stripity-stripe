defmodule Stripe.Webhook do
  @moduledoc """
  Creates a Stripe Event from webhook's payload if signature is valid.

  Use `construct_event/3` to verify the authenticity of a webhook request and
  convert its payload into a `Stripe.Event` struct.

    case Stripe.Webhook.construct_event(payload, signature, secret) do
      {:ok, %Stripe.Event{} = event} ->
        # Return 200 to Stripe and handle event
      {:error, reason} ->
        # Reject webhook by responding with non-2XX
    end
  """

  @default_tolerance 300
  @expected_scheme "v1"

  def construct_event(payload, signature_header, secret, tolerance \\ @default_tolerance) do
    case verify_header(payload, signature_header, secret, tolerance) do
      :ok ->
        {:ok, convert_to_event!(payload)}

      error ->
        error
    end
  end

  defp verify_header(payload, signature_header, secret, tolerance) do
    case get_timestamp_and_signatures(signature_header, @expected_scheme) do
      {nil, _} ->
        {:error, "Unable to extract timestamp and signatures from header"}

      {_, []} ->
        {:error, "No signatures found with expected scheme #{@expected_scheme}"}

      {timestamp, signatures} ->
        with {:ok, timestamp} <- check_timestamp(timestamp, tolerance),
             {:ok, _signatures} <- check_signatures(signatures, timestamp, payload, secret) do
          :ok
        else
          {:error, error} -> {:error, error}
        end
    end
  end

  defp get_timestamp_and_signatures(signature_header, scheme) do
    signature_header
    |> String.split(",")
    |> Enum.map(&String.split(&1, "="))
    |> Enum.reduce({nil, []}, fn
         ["t", timestamp], {nil, signatures} ->
           {to_integer(timestamp), signatures}

         [^scheme, signature], {timestamp, signatures} ->
           {timestamp, [signature | signatures]}

         _, acc ->
           acc
       end)
  end

  defp to_integer(timestamp) do
    case Integer.parse(timestamp) do
      {timestamp, _} ->
        timestamp

      :error ->
        nil
    end
  end

  defp check_timestamp(timestamp, tolerance) do
    now = System.system_time(:seconds)

    if timestamp < now - tolerance do
      {:error, "Timestamp outside the tolerance zone (#{now})"}
    else
      {:ok, timestamp}
    end
  end

  defp check_signatures(signatures, timestamp, payload, secret) do
    signed_payload = "#{timestamp}.#{payload}"
    expected_signature = compute_signature(signed_payload, secret)

    if Enum.any?(signatures, &secure_equals?(&1, expected_signature)) do
      {:ok, signatures}
    else
      {:error, "No signatures found matching the expected signature for payload"}
    end
  end

  defp compute_signature(payload, secret) do
    :crypto.hmac(:sha256, secret, payload)
    |> Base.encode16(case: :lower)
  end

  defp secure_equals?(input, expected) when byte_size(input) == byte_size(expected) do
    input = String.to_charlist(input)
    expected = String.to_charlist(expected)
    secure_compare(input, expected)
  end

  defp secure_equals?(_, _), do: false

  defp secure_compare(acc \\ 0, input, expected)
  defp secure_compare(acc, [], []), do: acc == 0

  defp secure_compare(acc, [input_codepoint | input], [expected_codepoint | expected]) do
    import Bitwise

    acc
    |> bor(input_codepoint ^^^ expected_codepoint)
    |> secure_compare(input, expected)
  end

  def convert_to_event!(payload) do
    payload
    |> Poison.decode!()
    |> Stripe.Converter.convert_result()
  end
end

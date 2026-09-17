defmodule Stripe.API.IdempotencyKey do
  @moduledoc false

  @header "Idempotency-Key"

  @doc """
  Makes the request safely retryable.

  Adds a request step setting the `#{@header}` header on every method that Stripe accepts one
  for, and sets `:retry` so that only requests carrying the header are retried, on a conflict, a
  rate limit, or a connection failure.

  ## Request Options

    * `:idempotency_key` - the key to send. Defaults to a generated one. A key already present in
      the request headers wins over both.
  """
  @spec attach(Req.Request.t()) :: Req.Request.t()
  def attach(%Req.Request{} = request) do
    request
    |> Req.Request.register_options([:idempotency_key])
    |> Req.Request.merge_options(retry: &retry_request?/2)
    |> Req.Request.append_request_steps(stripe_idempotency_key: &put_idempotency_key/1)
  end

  # only retry if allowed Stripe idempotency method
  defp retry_request?(request, response_or_exception) do
    case Req.Request.get_header(request, @header) do
      [] -> false
      _idempotency_key -> retry_response?(response_or_exception)
    end
  end

  # 409 conflict
  defp retry_response?(%Req.Response{status: 409}), do: true
  # https://github.com/beam-community/stripity_stripe/issues/686
  defp retry_response?(%Req.Response{status: 429}), do: true
  # Destination refused the connection, the connection was reset, or a
  # variety of other connection failures. This could occur from a single
  # saturated server, so retry in case it's intermittent.
  defp retry_response?(%Req.TransportError{reason: :econnrefused}), do: true
  # Retry on timeout-related problems (either on open or read).
  defp retry_response?(%Req.TransportError{reason: :timeout}), do: true
  defp retry_response?(_response_or_exception), do: false

  defp put_idempotency_key(%Req.Request{method: method} = request)
       when method in [:get, :head, :put, :delete] do
    request
  end

  defp put_idempotency_key(request) do
    idempotency_key = Req.Request.get_option(request, :idempotency_key) || generate()

    # By using `put_new_header/3` instead of `put_header/3`, we allow users to
    # provide their own idempotency key.
    Req.Request.put_new_header(request, @header, idempotency_key)
  end

  # https://stripe.com/docs/api/idempotent_requests
  defp generate do
    binary = <<
      System.system_time(:nanosecond)::64,
      :erlang.phash2({node(), self()}, 16_777_216)::24,
      System.unique_integer([:positive])::32
    >>

    Base.hex_encode32(binary, case: :lower, padding: false)
  end
end

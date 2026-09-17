defmodule Stripe.API.ErrorHandler do
  @moduledoc false

  alias Stripe.Error

  @doc """
  Turns failed requests into `Stripe.Error` exceptions.

  Adds a response step mapping any 3xx-5xx response to the error Stripe described in its body, and
  an error step wrapping transport failures. Both are *appended*, so retries still see the
  original response.
  """
  @spec attach(Req.Request.t()) :: Req.Request.t()
  def attach(%Req.Request{} = request) do
    request
    |> Req.Request.append_response_steps(stripe_error: &handle_response/1)
    |> Req.Request.append_error_steps(stripe_error: &handle_error/1)
  end

  defp handle_response({request, %Req.Response{status: status} = response})
       when status >= 300 and status <= 599 do
    request_id = List.first(Req.Response.get_header(response, "request-id"))

    error =
      case response.body do
        %{"error_description" => _} = api_error ->
          Error.from_stripe_error(status, api_error, request_id)

        %{"error" => api_error} ->
          Error.from_stripe_error(status, api_error, request_id)

        _body ->
          # e.g. if the body is empty
          Error.from_stripe_error(status, nil, request_id)
      end

    {request, error}
  end

  defp handle_response({request, response}), do: {request, response}

  defp handle_error({request, %Error{} = error}), do: {request, error}
  defp handle_error({request, exception}), do: {request, Error.from_network_error(exception)}
end

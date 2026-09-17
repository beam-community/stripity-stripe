defmodule Stripe.API.Params do
  @moduledoc false

  @doc """
  Encodes parameters the way Stripe expects them.

  Stripe takes nested maps and lists as `metadata[key]=value` and `expand[0]=value`, which
  `URI.encode_query/1` cannot express, so `:params` and `:form` are flattened with
  `UriQuery.params/1` first: `:params` carries the query string, `:form` the request body.

  The step is *prepended*, so it runs before Req encodes the body and the query string.
  """
  @spec attach(Req.Request.t()) :: Req.Request.t()
  def attach(%Req.Request{} = request) do
    Req.Request.prepend_request_steps(request, stripe_params: &encode_params/1)
  end

  defp encode_params(request) do
    request
    |> update_option(:params, &UriQuery.params/1)
    |> update_option(:form, &UriQuery.params/1)
  end

  defp update_option(request, option, fun) do
    case Req.Request.fetch_option(request, option) do
      {:ok, value} -> Req.Request.put_option(request, option, fun.(value))
      :error -> request
    end
  end
end

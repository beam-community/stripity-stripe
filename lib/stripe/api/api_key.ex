defmodule Stripe.API.APIKey do
  @moduledoc false

  @doc """
  Authenticates the request with a Stripe API key.

  Adds a request step setting the `:auth` option to the bearer token Stripe expects. The step is
  prepended so it runs before Req's own `auth` step, which turns the option into the
  `authorization` header.

  ## Request Options

    * `:api_key` - the key to authenticate with. Defaults to the `:api_key` configuration, itself
      defaulting to `""` so that Stripe answers with an authentication error rather than the
      library raising. Set it to `false` to leave the request unauthenticated, as
      `POST /oauth/token` carries the secret in the body instead.
  """
  @spec attach(Req.Request.t()) :: Req.Request.t()
  def attach(%Req.Request{} = request) do
    request
    |> Req.Request.register_options([:api_key])
    |> Req.Request.prepend_request_steps(stripe_api_key: &put_auth_option/1)
  end

  defp put_auth_option(request) do
    case Req.Request.get_option(request, :api_key) do
      false ->
        request

      api_key ->
        api_key = api_key || Stripe.Config.resolve(:api_key, "")

        Req.Request.put_option(request, :auth, {:bearer, api_key})
    end
  end
end

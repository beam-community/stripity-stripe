defmodule Stripe.API.APIVersion do
  @moduledoc false

  @api_version "2025-11-17.clover"

  @doc """
  Pins the request to a Stripe API version.

  Adds a request step setting the `stripe-version` header, along with the `user-agent` identifying
  the library and the version it speaks.

  ## Request Options

    * `:api_version` - the version to request. Defaults to the `:api_version` configuration,
      itself defaulting to `#{@api_version}`.
  """
  @spec attach(Req.Request.t()) :: Req.Request.t()
  def attach(%Req.Request{} = request) do
    request
    |> Req.Request.register_options([:api_version])
    |> Req.Request.append_request_steps(stripe_api_version: &put_api_version/1)
  end

  defp put_api_version(request) do
    api_version =
      Req.Request.get_option(request, :api_version) ||
        Stripe.Config.resolve(:api_version, @api_version)

    request
    |> Req.Request.put_header("user-agent", "Stripe/v1 stripe-elixir/#{api_version}")
    |> Req.Request.put_header("stripe-version", api_version)
  end
end

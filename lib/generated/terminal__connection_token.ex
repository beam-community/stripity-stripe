defmodule Stripe.Terminal.ConnectionToken do
  use Stripe.Entity

  @moduledoc "A Connection Token is used by the Stripe Terminal SDK to connect to a reader.\n\nRelated guide: [Fleet management](https://stripe.com/docs/terminal/fleet/locations)"
  (
    defstruct [:location, :object, :secret]

    @typedoc "The `terminal.connection_token` type.\n\n  * `location` The id of the location that this connection token is scoped to. Note that location scoping only applies to internet-connected readers. For more details, see [the docs on scoping connection tokens](https://docs.stripe.com/terminal/fleet/locations-and-zones?dashboard-or-api=api#connection-tokens).\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `secret` Your application should pass this token to the Stripe Terminal SDK.\n"
    @type t :: %__MODULE__{location: binary, object: binary, secret: binary}
  )

  (
    nil

    @doc "<p>To connect to a reader the Stripe Terminal SDK needs to retrieve a short-lived connection token from Stripe, proxied through your server. On your backend, add an endpoint that creates and returns a connection token.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/terminal/connection_tokens`\n"
    (
      @spec create(
              params :: %{optional(:expand) => list(binary), optional(:location) => binary},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Terminal.ConnectionToken.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/terminal/connection_tokens", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end
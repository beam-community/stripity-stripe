defmodule Stripe.CustomerSession do
  use Stripe.Entity

  @moduledoc "A customer session allows you to grant client access to Stripe's frontend SDKs (like StripeJs)\ncontrol over a customer."
  (
    defstruct [:client_secret, :components, :created, :customer, :expires_at, :livemode, :object]

    @typedoc "The `customer_session` type.\n\n  * `client_secret` The client secret of this customer session. Used on the client to set up secure access to the given `customer`.\n\nThe client secret can be used to provide access to `customer` from your frontend. It should not be stored, logged, or exposed to anyone other than the relevant customer. Make sure that you have TLS enabled on any page that includes the client secret.\n  * `components` \n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `customer` The customer the customer session was created for.\n  * `expires_at` The timestamp at which this customer session will expire.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n"
    @type t :: %__MODULE__{
            client_secret: binary,
            components: term,
            created: integer,
            customer: binary | Stripe.Customer.t(),
            expires_at: integer,
            livemode: boolean,
            object: binary
          }
  )

  (
    @typedoc "Configuration for buy button."
    @type buy_button :: %{optional(:enabled) => boolean}
  )

  (
    @typedoc "Configuration for each component. 1 component must be enabled."
    @type components :: %{
            optional(:buy_button) => buy_button,
            optional(:pricing_table) => pricing_table
          }
  )

  (
    @typedoc "Configuration for the pricing table."
    @type pricing_table :: %{optional(:enabled) => boolean}
  )

  (
    nil

    @doc "<p>Creates a customer session object that includes a single-use client secret that you can use on your front-end to grant client-side API access for certain customer resources.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/customer_sessions`\n"
    (
      @spec create(
              params :: %{
                optional(:components) => components,
                optional(:customer) => binary,
                optional(:expand) => list(binary)
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.CustomerSession.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/customer_sessions", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end

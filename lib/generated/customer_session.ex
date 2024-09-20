defmodule Stripe.CustomerSession do
  use Stripe.Entity

  @moduledoc "A Customer Session allows you to grant Stripe's frontend SDKs (like Stripe.js) client-side access\ncontrol over a Customer.\n\nRelated guides: [Customer Session with the Payment Element](/payments/accept-a-payment-deferred?platform=web&type=payment#save-payment-methods),\n[Customer Session with the Pricing Table](/payments/checkout/pricing-table#customer-session),\n[Customer Session with the Buy Button](/payment-links/buy-button#pass-an-existing-customer)."
  (
    defstruct [:client_secret, :components, :created, :customer, :expires_at, :livemode, :object]

    @typedoc "The `customer_session` type.\n\n  * `client_secret` The client secret of this Customer Session. Used on the client to set up secure access to the given `customer`.\n\nThe client secret can be used to provide access to `customer` from your frontend. It should not be stored, logged, or exposed to anyone other than the relevant customer. Make sure that you have TLS enabled on any page that includes the client secret.\n  * `components` \n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `customer` The Customer the Customer Session was created for.\n  * `expires_at` The timestamp at which this Customer Session will expire.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n"
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
    @typedoc "Configuration for each component. Exactly 1 component must be enabled."
    @type components :: %{
            optional(:buy_button) => buy_button,
            optional(:payment_element) => payment_element,
            optional(:pricing_table) => pricing_table
          }
  )

  (
    @typedoc "This hash defines whether the Payment Element supports certain features."
    @type features :: %{
            optional(:payment_method_allow_redisplay_filters) =>
              list(:always | :limited | :unspecified),
            optional(:payment_method_redisplay) => :disabled | :enabled,
            optional(:payment_method_redisplay_limit) => integer,
            optional(:payment_method_remove) => :disabled | :enabled,
            optional(:payment_method_save) => :disabled | :enabled,
            optional(:payment_method_save_usage) => :off_session | :on_session
          }
  )

  (
    @typedoc "Configuration for the Payment Element."
    @type payment_element :: %{optional(:enabled) => boolean, optional(:features) => features}
  )

  (
    @typedoc "Configuration for the pricing table."
    @type pricing_table :: %{optional(:enabled) => boolean}
  )

  (
    nil

    @doc "<p>Creates a Customer Session object that includes a single-use client secret that you can use on your front-end to grant client-side API access for certain customer resources.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/customer_sessions`\n"
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
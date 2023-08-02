defmodule Stripe.BillingPortal.Configuration do
  use Stripe.Entity

  @moduledoc "A portal configuration describes the functionality and behavior of a portal session."
  (
    defstruct [
      :active,
      :application,
      :business_profile,
      :created,
      :default_return_url,
      :features,
      :id,
      :is_default,
      :livemode,
      :login_page,
      :metadata,
      :object,
      :updated
    ]

    @typedoc "The `billing_portal.configuration` type.\n\n  * `active` Whether the configuration is active and can be used to create portal sessions.\n  * `application` ID of the Connect Application that created the configuration.\n  * `business_profile` \n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `default_return_url` The default URL to redirect customers to when they click on the portal's link to return to your website. This can be [overriden](https://stripe.com/docs/api/customer_portal/sessions/create#create_portal_session-return_url) when creating the session.\n  * `features` \n  * `id` Unique identifier for the object.\n  * `is_default` Whether the configuration is the default. If `true`, this configuration can be managed in the Dashboard and portal sessions will use this configuration unless it is overriden when creating the session.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `login_page` \n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `updated` Time at which the object was last updated. Measured in seconds since the Unix epoch.\n"
    @type t :: %__MODULE__{
            active: boolean,
            application: (binary | term | term) | nil,
            business_profile: term,
            created: integer,
            default_return_url: binary | nil,
            features: term,
            id: binary,
            is_default: boolean,
            livemode: boolean,
            login_page: term,
            metadata: term | nil,
            object: binary,
            updated: integer
          }
  )

  (
    @typedoc "The business information shown to customers in the portal."
    @type business_profile :: %{
            optional(:headline) => binary | binary,
            optional(:privacy_policy_url) => binary,
            optional(:terms_of_service_url) => binary
          }
  )

  (
    @typedoc "Whether the cancellation reasons will be collected in the portal and which options are exposed to the customer"
    @type cancellation_reason :: %{
            optional(:enabled) => boolean,
            optional(:options) =>
              list(
                :customer_service
                | :low_quality
                | :missing_features
                | :other
                | :switched_service
                | :too_complex
                | :too_expensive
                | :unused
              )
              | binary
          }
  )

  (
    @typedoc "Information about updating the customer details in the portal."
    @type customer_update :: %{
            optional(:allowed_updates) =>
              list(:address | :email | :name | :phone | :shipping | :tax_id) | binary,
            optional(:enabled) => boolean
          }
  )

  (
    @typedoc "Information about the features available in the portal."
    @type features :: %{
            optional(:customer_update) => customer_update,
            optional(:invoice_history) => invoice_history,
            optional(:payment_method_update) => payment_method_update,
            optional(:subscription_cancel) => subscription_cancel,
            optional(:subscription_pause) => subscription_pause,
            optional(:subscription_update) => subscription_update
          }
  )

  (
    @typedoc "Information about showing the billing history in the portal."
    @type invoice_history :: %{optional(:enabled) => boolean}
  )

  (
    @typedoc "The hosted login page for this configuration. Learn more about the portal login page in our [integration docs](https://stripe.com/docs/billing/subscriptions/integrating-customer-portal#share)."
    @type login_page :: %{optional(:enabled) => boolean}
  )

  (
    @typedoc "Information about updating payment methods in the portal."
    @type payment_method_update :: %{optional(:enabled) => boolean}
  )

  (
    @typedoc nil
    @type products :: %{optional(:prices) => list(binary), optional(:product) => binary}
  )

  (
    @typedoc "Information about canceling subscriptions in the portal."
    @type subscription_cancel :: %{
            optional(:cancellation_reason) => cancellation_reason,
            optional(:enabled) => boolean,
            optional(:mode) => :at_period_end | :immediately,
            optional(:proration_behavior) => :always_invoice | :create_prorations | :none
          }
  )

  (
    @typedoc "Information about pausing subscriptions in the portal."
    @type subscription_pause :: %{optional(:enabled) => boolean}
  )

  (
    @typedoc "Information about updating subscriptions in the portal."
    @type subscription_update :: %{
            optional(:default_allowed_updates) =>
              list(:price | :promotion_code | :quantity) | binary,
            optional(:enabled) => boolean,
            optional(:products) => list(products) | binary,
            optional(:proration_behavior) => :always_invoice | :create_prorations | :none
          }
  )

  (
    nil

    @doc "<p>Returns a list of configurations that describe the functionality of the customer portal.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/billing_portal/configurations`\n"
    (
      @spec list(
              params :: %{
                optional(:active) => boolean,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:is_default) => boolean,
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.BillingPortal.Configuration.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params("/v1/billing_portal/configurations", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Creates a configuration that describes the functionality and behavior of a PortalSession</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/billing_portal/configurations`\n"
    (
      @spec create(
              params :: %{
                optional(:business_profile) => business_profile,
                optional(:default_return_url) => binary | binary,
                optional(:expand) => list(binary),
                optional(:features) => features,
                optional(:login_page) => login_page,
                optional(:metadata) => %{optional(binary) => binary}
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.BillingPortal.Configuration.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params("/v1/billing_portal/configurations", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Updates a configuration that describes the functionality of the customer portal.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/billing_portal/configurations/{configuration}`\n"
    (
      @spec update(
              configuration :: binary(),
              params :: %{
                optional(:active) => boolean,
                optional(:business_profile) => business_profile,
                optional(:default_return_url) => binary | binary,
                optional(:expand) => list(binary),
                optional(:features) => features,
                optional(:login_page) => login_page,
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.BillingPortal.Configuration.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(configuration, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/billing_portal/configurations/{configuration}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "configuration",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "configuration",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [configuration]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Retrieves a configuration that describes the functionality of the customer portal.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/billing_portal/configurations/{configuration}`\n"
    (
      @spec retrieve(
              configuration :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.BillingPortal.Configuration.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(configuration, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/billing_portal/configurations/{configuration}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "configuration",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "configuration",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [configuration]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )
end

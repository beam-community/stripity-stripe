defmodule Stripe.BillingPortal.Session do
  use Stripe.Entity

  @moduledoc "The Billing customer portal is a Stripe-hosted UI for subscription and\nbilling management.\n\nA portal configuration describes the functionality and features that you\nwant to provide to your customers through the portal.\n\nA portal session describes the instantiation of the customer portal for\na particular customer. By visiting the session's URL, the customer\ncan manage their subscriptions and billing details. For security reasons,\nsessions are short-lived and will expire if the customer does not visit the URL.\nCreate sessions on-demand when customers intend to manage their subscriptions\nand billing details.\n\nLearn more in the [integration guide](https://stripe.com/docs/billing/subscriptions/integrating-customer-portal)."
  (
    defstruct [
      :configuration,
      :created,
      :customer,
      :flow,
      :id,
      :livemode,
      :locale,
      :object,
      :on_behalf_of,
      :return_url,
      :url
    ]

    @typedoc "The `billing_portal.session` type.\n\n  * `configuration` The configuration used by this session, describing the features available.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `customer` The ID of the customer for this session.\n  * `flow` Information about a specific flow for the customer to go through. See the [docs](https://stripe.com/docs/customer-management/portal-deep-links) to learn more about using customer portal deep links and flows.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `locale` The IETF language tag of the locale Customer Portal is displayed in. If blank or auto, the customer’s `preferred_locales` or browser’s locale is used.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `on_behalf_of` The account for which the session was created on behalf of. When specified, only subscriptions and invoices with this `on_behalf_of` account appear in the portal. For more information, see the [docs](https://stripe.com/docs/connect/separate-charges-and-transfers#on-behalf-of). Use the [Accounts API](https://stripe.com/docs/api/accounts/object#account_object-settings-branding) to modify the `on_behalf_of` account's branding settings, which the portal displays.\n  * `return_url` The URL to redirect customers to when they click on the portal's link to return to your website.\n  * `url` The short-lived URL of the session that gives customers access to the customer portal.\n"
    @type t :: %__MODULE__{
            configuration: binary | Stripe.BillingPortal.Configuration.t(),
            created: integer,
            customer: binary,
            flow: term | nil,
            id: binary,
            livemode: boolean,
            locale: binary | nil,
            object: binary,
            on_behalf_of: binary | nil,
            return_url: binary | nil,
            url: binary
          }
  )

  (
    @typedoc "Behavior after the flow is completed."
    @type after_completion :: %{
            optional(:hosted_confirmation) => hosted_confirmation,
            optional(:redirect) => redirect,
            optional(:type) => :hosted_confirmation | :portal_homepage | :redirect
          }
  )

  (
    @typedoc nil
    @type discounts :: %{optional(:coupon) => binary, optional(:promotion_code) => binary}
  )

  (
    @typedoc "Information about a specific flow for the customer to go through. See the [docs](https://stripe.com/docs/customer-management/portal-deep-links) to learn more about using customer portal deep links and flows."
    @type flow_data :: %{
            optional(:after_completion) => after_completion,
            optional(:subscription_cancel) => subscription_cancel,
            optional(:subscription_update) => subscription_update,
            optional(:subscription_update_confirm) => subscription_update_confirm,
            optional(:type) =>
              :payment_method_update
              | :subscription_cancel
              | :subscription_update
              | :subscription_update_confirm
          }
  )

  (
    @typedoc "Configuration when `after_completion.type=hosted_confirmation`."
    @type hosted_confirmation :: %{optional(:custom_message) => binary}
  )

  (
    @typedoc nil
    @type items :: %{
            optional(:id) => binary,
            optional(:price) => binary,
            optional(:quantity) => integer
          }
  )

  (
    @typedoc "Configuration when `after_completion.type=redirect`."
    @type redirect :: %{optional(:return_url) => binary}
  )

  (
    @typedoc "Configuration when `flow_data.type=subscription_cancel`."
    @type subscription_cancel :: %{optional(:subscription) => binary}
  )

  (
    @typedoc "Configuration when `flow_data.type=subscription_update`."
    @type subscription_update :: %{optional(:subscription) => binary}
  )

  (
    @typedoc "Configuration when `flow_data.type=subscription_update_confirm`."
    @type subscription_update_confirm :: %{
            optional(:discounts) => list(discounts),
            optional(:items) => list(items),
            optional(:subscription) => binary
          }
  )

  (
    nil

    @doc "<p>Creates a session of the customer portal.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/billing_portal/sessions`\n"
    (
      @spec create(
              params :: %{
                optional(:configuration) => binary,
                optional(:customer) => binary,
                optional(:expand) => list(binary),
                optional(:flow_data) => flow_data,
                optional(:locale) =>
                  :auto
                  | :bg
                  | :cs
                  | :da
                  | :de
                  | :el
                  | :en
                  | :"en-AU"
                  | :"en-CA"
                  | :"en-GB"
                  | :"en-IE"
                  | :"en-IN"
                  | :"en-NZ"
                  | :"en-SG"
                  | :es
                  | :"es-419"
                  | :et
                  | :fi
                  | :fil
                  | :fr
                  | :"fr-CA"
                  | :hr
                  | :hu
                  | :id
                  | :it
                  | :ja
                  | :ko
                  | :lt
                  | :lv
                  | :ms
                  | :mt
                  | :nb
                  | :nl
                  | :pl
                  | :pt
                  | :"pt-BR"
                  | :ro
                  | :ru
                  | :sk
                  | :sl
                  | :sv
                  | :th
                  | :tr
                  | :vi
                  | :zh
                  | :"zh-HK"
                  | :"zh-TW",
                optional(:on_behalf_of) => binary,
                optional(:return_url) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.BillingPortal.Session.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/billing_portal/sessions", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end

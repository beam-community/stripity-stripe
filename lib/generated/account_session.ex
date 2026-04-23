defmodule Stripe.AccountSession do
  use Stripe.Entity

  @moduledoc "An AccountSession allows a Connect platform to grant access to a connected account in Connect embedded components.\n\nWe recommend that you create an AccountSession each time you need to display an embedded component\nto your user. Do not save AccountSessions to your database as they expire relatively\nquickly, and cannot be used more than once.\n\nRelated guide: [Connect embedded components](https://stripe.com/docs/connect/get-started-connect-embedded-components)"
  (
    defstruct [:account, :client_secret, :components, :expires_at, :livemode, :object]

    @typedoc "The `account_session` type.\n\n  * `account` The ID of the account the AccountSession was created for\n  * `client_secret` The client secret of this AccountSession. Used on the client to set up secure access to the given `account`.\n\nThe client secret can be used to provide access to `account` from your frontend. It should not be stored, logged, or exposed to anyone other than the connected account. Make sure that you have TLS enabled on any page that includes the client secret.\n\nRefer to our docs to [setup Connect embedded components](https://stripe.com/docs/connect/get-started-connect-embedded-components) and learn about how `client_secret` should be handled.\n  * `components` \n  * `expires_at` The timestamp at which this AccountSession will expire.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n"
    @type t :: %__MODULE__{
            account: binary,
            client_secret: binary,
            components: term,
            expires_at: integer,
            livemode: boolean,
            object: binary
          }
  )

  (
    @typedoc "Configuration for the [account management](/connect/supported-embedded-components/account-management/) embedded component."
    @type account_management :: %{optional(:enabled) => boolean, optional(:features) => features}
  )

  (
    @typedoc "Configuration for the [account onboarding](/connect/supported-embedded-components/account-onboarding/) embedded component."
    @type account_onboarding :: %{optional(:enabled) => boolean, optional(:features) => features}
  )

  (
    @typedoc "Configuration for the [balances](/connect/supported-embedded-components/balances/) embedded component."
    @type balances :: %{optional(:enabled) => boolean, optional(:features) => features}
  )

  (
    @typedoc "Each key of the dictionary represents an embedded component, and each embedded component maps to its configuration (e.g. whether it has been enabled or not)."
    @type components :: %{
            optional(:account_management) => account_management,
            optional(:account_onboarding) => account_onboarding,
            optional(:balances) => balances,
            optional(:disputes_list) => disputes_list,
            optional(:documents) => documents,
            optional(:financial_account) => financial_account,
            optional(:financial_account_transactions) => financial_account_transactions,
            optional(:instant_payouts_promotion) => instant_payouts_promotion,
            optional(:issuing_card) => issuing_card,
            optional(:issuing_cards_list) => issuing_cards_list,
            optional(:notification_banner) => notification_banner,
            optional(:payment_details) => payment_details,
            optional(:payment_disputes) => payment_disputes,
            optional(:payments) => payments,
            optional(:payout_details) => payout_details,
            optional(:payouts) => payouts,
            optional(:payouts_list) => payouts_list,
            optional(:tax_registrations) => tax_registrations,
            optional(:tax_settings) => tax_settings
          }
  )

  (
    @typedoc "Configuration for the [disputes list](/connect/supported-embedded-components/disputes-list/) embedded component."
    @type disputes_list :: %{optional(:enabled) => boolean, optional(:features) => features}
  )

  (
    @typedoc "Configuration for the [documents](/connect/supported-embedded-components/documents/) embedded component."
    @type documents :: %{optional(:enabled) => boolean, optional(:features) => map()}
  )

  (
    @typedoc "The list of features enabled in the embedded component."
    @type features :: %{
            optional(:capture_payments) => boolean,
            optional(:destination_on_behalf_of_charge_management) => boolean,
            optional(:dispute_management) => boolean,
            optional(:refund_management) => boolean
          }
  )

  (
    @typedoc "Configuration for the [financial account](/connect/supported-embedded-components/financial-account/) embedded component."
    @type financial_account :: %{optional(:enabled) => boolean, optional(:features) => features}
  )

  (
    @typedoc "Configuration for the [financial account transactions](/connect/supported-embedded-components/financial-account-transactions/) embedded component."
    @type financial_account_transactions :: %{
            optional(:enabled) => boolean,
            optional(:features) => features
          }
  )

  (
    @typedoc "Configuration for the [instant payouts promotion](/connect/supported-embedded-components/instant-payouts-promotion/) embedded component."
    @type instant_payouts_promotion :: %{
            optional(:enabled) => boolean,
            optional(:features) => features
          }
  )

  (
    @typedoc "Configuration for the [issuing card](/connect/supported-embedded-components/issuing-card/) embedded component."
    @type issuing_card :: %{optional(:enabled) => boolean, optional(:features) => features}
  )

  (
    @typedoc "Configuration for the [issuing cards list](/connect/supported-embedded-components/issuing-cards-list/) embedded component."
    @type issuing_cards_list :: %{optional(:enabled) => boolean, optional(:features) => features}
  )

  (
    @typedoc "Configuration for the [notification banner](/connect/supported-embedded-components/notification-banner/) embedded component."
    @type notification_banner :: %{optional(:enabled) => boolean, optional(:features) => features}
  )

  (
    @typedoc "Configuration for the [payment details](/connect/supported-embedded-components/payment-details/) embedded component."
    @type payment_details :: %{optional(:enabled) => boolean, optional(:features) => features}
  )

  (
    @typedoc "Configuration for the [payment disputes](/connect/supported-embedded-components/payment-disputes/) embedded component."
    @type payment_disputes :: %{optional(:enabled) => boolean, optional(:features) => features}
  )

  (
    @typedoc "Configuration for the [payments](/connect/supported-embedded-components/payments/) embedded component."
    @type payments :: %{optional(:enabled) => boolean, optional(:features) => features}
  )

  (
    @typedoc "Configuration for the [payout details](/connect/supported-embedded-components/payout-details/) embedded component."
    @type payout_details :: %{optional(:enabled) => boolean, optional(:features) => map()}
  )

  (
    @typedoc "Configuration for the [payouts](/connect/supported-embedded-components/payouts/) embedded component."
    @type payouts :: %{optional(:enabled) => boolean, optional(:features) => features}
  )

  (
    @typedoc "Configuration for the [payouts list](/connect/supported-embedded-components/payouts-list/) embedded component."
    @type payouts_list :: %{optional(:enabled) => boolean, optional(:features) => map()}
  )

  (
    @typedoc "Configuration for the [tax registrations](/connect/supported-embedded-components/tax-registrations/) embedded component."
    @type tax_registrations :: %{optional(:enabled) => boolean, optional(:features) => map()}
  )

  (
    @typedoc "Configuration for the [tax settings](/connect/supported-embedded-components/tax-settings/) embedded component."
    @type tax_settings :: %{optional(:enabled) => boolean, optional(:features) => map()}
  )

  (
    nil

    @doc "<p>Creates a AccountSession object that includes a single-use token that the platform can use on their front-end to grant client-side API access.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/account_sessions`\n"
    (
      @spec create(
              params :: %{
                optional(:account) => binary,
                optional(:components) => components,
                optional(:expand) => list(binary)
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.AccountSession.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/account_sessions", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end
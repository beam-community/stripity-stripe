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
    @typedoc "Configuration for the account onboarding embedded component."
    @type account_onboarding :: %{optional(:enabled) => boolean, optional(:features) => map()}
  )

  (
    @typedoc "Each key of the dictionary represents an embedded component, and each embedded component maps to its configuration (e.g. whether it has been enabled or not)."
    @type components :: %{
            optional(:account_onboarding) => account_onboarding,
            optional(:payment_details) => payment_details,
            optional(:payments) => payments,
            optional(:payouts) => payouts
          }
  )

  (
    @typedoc "The list of features enabled in the embedded component."
    @type features :: %{
            optional(:capture_payments) => boolean,
            optional(:dispute_management) => boolean,
            optional(:refund_management) => boolean
          }
  )

  (
    @typedoc "Configuration for the payment details embedded component."
    @type payment_details :: %{optional(:enabled) => boolean, optional(:features) => features}
  )

  (
    @typedoc "Configuration for the payments embedded component."
    @type payments :: %{optional(:enabled) => boolean, optional(:features) => features}
  )

  (
    @typedoc "Configuration for the payouts embedded component."
    @type payouts :: %{optional(:enabled) => boolean, optional(:features) => features}
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

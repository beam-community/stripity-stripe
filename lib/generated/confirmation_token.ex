defmodule Stripe.ConfirmationToken do
  use Stripe.Entity

  @moduledoc "ConfirmationTokens help transport client side data collected by Stripe JS over\nto your server for confirming a PaymentIntent or SetupIntent. If the confirmation\nis successful, values present on the ConfirmationToken are written onto the Intent.\n\nTo learn more about how to use ConfirmationToken, visit the related guides:\n- [Finalize payments on the server](https://stripe.com/docs/payments/finalize-payments-on-the-server)\n- [Build two-step confirmation](https://stripe.com/docs/payments/build-a-two-step-confirmation)."
  (
    defstruct [
      :created,
      :expires_at,
      :id,
      :livemode,
      :mandate_data,
      :object,
      :payment_intent,
      :payment_method_options,
      :payment_method_preview,
      :return_url,
      :setup_future_usage,
      :setup_intent,
      :shipping,
      :use_stripe_sdk
    ]

    @typedoc "The `confirmation_token` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `expires_at` Time at which this ConfirmationToken expires and can no longer be used to confirm a PaymentIntent or SetupIntent.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `mandate_data` Data used for generating a Mandate.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `payment_intent` ID of the PaymentIntent that this ConfirmationToken was used to confirm, or null if this ConfirmationToken has not yet been used.\n  * `payment_method_options` Payment-method-specific configuration for this ConfirmationToken.\n  * `payment_method_preview` Payment details collected by the Payment Element, used to create a PaymentMethod when a PaymentIntent or SetupIntent is confirmed with this ConfirmationToken.\n  * `return_url` Return URL used to confirm the Intent.\n  * `setup_future_usage` Indicates that you intend to make future payments with this ConfirmationToken's payment method.\n\nThe presence of this property will [attach the payment method](https://stripe.com/docs/payments/save-during-payment) to the PaymentIntent's Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete.\n  * `setup_intent` ID of the SetupIntent that this ConfirmationToken was used to confirm, or null if this ConfirmationToken has not yet been used.\n  * `shipping` Shipping information collected on this ConfirmationToken.\n  * `use_stripe_sdk` Indicates whether the Stripe SDK is used to handle confirmation flow. Defaults to `true` on ConfirmationToken.\n"
    @type t :: %__MODULE__{
            created: integer,
            expires_at: integer | nil,
            id: binary,
            livemode: boolean,
            mandate_data: term | nil,
            object: binary,
            payment_intent: binary | nil,
            payment_method_options: term | nil,
            payment_method_preview: term | nil,
            return_url: binary | nil,
            setup_future_usage: binary | nil,
            setup_intent: binary | nil,
            shipping: term | nil,
            use_stripe_sdk: boolean
          }
  )

  (
    @typedoc "If this is an `acss_debit` PaymentMethod, this hash contains details about the ACSS Debit payment method."
    @type acss_debit :: %{
            optional(:account_number) => binary,
            optional(:institution_number) => binary,
            optional(:transit_number) => binary
          }
  )

  (
    @typedoc nil
    @type address :: %{
            optional(:city) => binary,
            optional(:country) => binary,
            optional(:line1) => binary,
            optional(:line2) => binary,
            optional(:postal_code) => binary,
            optional(:state) => binary
          }
  )

  (
    @typedoc "If this is an `au_becs_debit` PaymentMethod, this hash contains details about the bank account."
    @type au_becs_debit :: %{optional(:account_number) => binary, optional(:bsb_number) => binary}
  )

  (
    @typedoc "If this is a `bacs_debit` PaymentMethod, this hash contains details about the Bacs Direct Debit bank account."
    @type bacs_debit :: %{optional(:account_number) => binary, optional(:sort_code) => binary}
  )

  (
    @typedoc "Billing information associated with the PaymentMethod that may be used or required by particular types of payment methods."
    @type billing_details :: %{
            optional(:address) => address | binary,
            optional(:email) => binary | binary,
            optional(:name) => binary | binary,
            optional(:phone) => binary | binary
          }
  )

  (
    @typedoc "If this is a `boleto` PaymentMethod, this hash contains details about the Boleto payment method."
    @type boleto :: %{optional(:tax_id) => binary}
  )

  (
    @typedoc "Customer's date of birth"
    @type dob :: %{
            optional(:day) => integer,
            optional(:month) => integer,
            optional(:year) => integer
          }
  )

  (
    @typedoc "If this is an `eps` PaymentMethod, this hash contains details about the EPS payment method."
    @type eps :: %{
            optional(:bank) =>
              :arzte_und_apotheker_bank
              | :austrian_anadi_bank_ag
              | :bank_austria
              | :bankhaus_carl_spangler
              | :bankhaus_schelhammer_und_schattera_ag
              | :bawag_psk_ag
              | :bks_bank_ag
              | :brull_kallmus_bank_ag
              | :btv_vier_lander_bank
              | :capital_bank_grawe_gruppe_ag
              | :deutsche_bank_ag
              | :dolomitenbank
              | :easybank_ag
              | :erste_bank_und_sparkassen
              | :hypo_alpeadriabank_international_ag
              | :hypo_bank_burgenland_aktiengesellschaft
              | :hypo_noe_lb_fur_niederosterreich_u_wien
              | :hypo_oberosterreich_salzburg_steiermark
              | :hypo_tirol_bank_ag
              | :hypo_vorarlberg_bank_ag
              | :marchfelder_bank
              | :oberbank_ag
              | :raiffeisen_bankengruppe_osterreich
              | :schoellerbank_ag
              | :sparda_bank_wien
              | :volksbank_gruppe
              | :volkskreditbank_ag
              | :vr_bank_braunau
          }
  )

  (
    @typedoc "If this is an `fpx` PaymentMethod, this hash contains details about the FPX payment method."
    @type fpx :: %{
            optional(:account_holder_type) => :company | :individual,
            optional(:bank) =>
              :affin_bank
              | :agrobank
              | :alliance_bank
              | :ambank
              | :bank_islam
              | :bank_muamalat
              | :bank_of_china
              | :bank_rakyat
              | :bsn
              | :cimb
              | :deutsche_bank
              | :hong_leong_bank
              | :hsbc
              | :kfh
              | :maybank2e
              | :maybank2u
              | :ocbc
              | :pb_enterprise
              | :public_bank
              | :rhb
              | :standard_chartered
              | :uob
          }
  )

  (
    @typedoc "If this is an `ideal` PaymentMethod, this hash contains details about the iDEAL payment method."
    @type ideal :: %{
            optional(:bank) =>
              :abn_amro
              | :asn_bank
              | :bunq
              | :handelsbanken
              | :ing
              | :knab
              | :moneyou
              | :n26
              | :nn
              | :rabobank
              | :regiobank
              | :revolut
              | :sns_bank
              | :triodos_bank
              | :van_lanschot
              | :yoursafe
          }
  )

  (
    @typedoc "If this is a `klarna` PaymentMethod, this hash contains details about the Klarna payment method."
    @type klarna :: %{optional(:dob) => dob}
  )

  (
    @typedoc "If this is a `p24` PaymentMethod, this hash contains details about the P24 payment method."
    @type p24 :: %{
            optional(:bank) =>
              :alior_bank
              | :bank_millennium
              | :bank_nowy_bfg_sa
              | :bank_pekao_sa
              | :banki_spbdzielcze
              | :blik
              | :bnp_paribas
              | :boz
              | :citi_handlowy
              | :credit_agricole
              | :envelobank
              | :etransfer_pocztowy24
              | :getin_bank
              | :ideabank
              | :ing
              | :inteligo
              | :mbank_mtransfer
              | :nest_przelew
              | :noble_pay
              | :pbac_z_ipko
              | :plus_bank
              | :santander_przelew24
              | :tmobile_usbugi_bankowe
              | :toyota_bank
              | :velobank
              | :volkswagen_bank
          }
  )

  (
    @typedoc "If provided, this hash will be used to create a PaymentMethod."
    @type payment_method_data :: %{
            optional(:sofort) => sofort,
            optional(:customer_balance) => map(),
            optional(:boleto) => boleto,
            optional(:alipay) => map(),
            optional(:au_becs_debit) => au_becs_debit,
            optional(:amazon_pay) => map(),
            optional(:metadata) => %{optional(binary) => binary},
            optional(:bancontact) => map(),
            optional(:interac_present) => map(),
            optional(:bacs_debit) => bacs_debit,
            optional(:affirm) => map(),
            optional(:billing_details) => billing_details,
            optional(:mobilepay) => map(),
            optional(:grabpay) => map(),
            optional(:eps) => eps,
            optional(:ideal) => ideal,
            optional(:pix) => map(),
            optional(:giropay) => map(),
            optional(:multibanco) => map(),
            optional(:revolut_pay) => map(),
            optional(:klarna) => klarna,
            optional(:twint) => map(),
            optional(:acss_debit) => acss_debit,
            optional(:link) => map(),
            optional(:konbini) => map(),
            optional(:blik) => map(),
            optional(:p24) => p24,
            optional(:paypal) => map(),
            optional(:fpx) => fpx,
            optional(:oxxo) => map(),
            optional(:paynow) => map(),
            optional(:wechat_pay) => map(),
            optional(:promptpay) => map(),
            optional(:type) =>
              :acss_debit
              | :affirm
              | :afterpay_clearpay
              | :alipay
              | :amazon_pay
              | :au_becs_debit
              | :bacs_debit
              | :bancontact
              | :blik
              | :boleto
              | :cashapp
              | :customer_balance
              | :eps
              | :fpx
              | :giropay
              | :grabpay
              | :ideal
              | :klarna
              | :konbini
              | :link
              | :mobilepay
              | :multibanco
              | :oxxo
              | :p24
              | :paynow
              | :paypal
              | :pix
              | :promptpay
              | :revolut_pay
              | :sepa_debit
              | :sofort
              | :swish
              | :twint
              | :us_bank_account
              | :wechat_pay
              | :zip,
            optional(:radar_options) => radar_options,
            optional(:cashapp) => map(),
            optional(:sepa_debit) => sepa_debit,
            optional(:afterpay_clearpay) => map(),
            optional(:allow_redisplay) => :always | :limited | :unspecified,
            optional(:us_bank_account) => us_bank_account,
            optional(:swish) => map(),
            optional(:zip) => map()
          }
  )

  (
    @typedoc "Options to configure Radar. See [Radar Session](https://stripe.com/docs/radar/radar-session) for more information."
    @type radar_options :: %{optional(:session) => binary}
  )

  (
    @typedoc "If this is a `sepa_debit` PaymentMethod, this hash contains details about the SEPA debit bank account."
    @type sepa_debit :: %{optional(:iban) => binary}
  )

  (
    @typedoc "Shipping information for this ConfirmationToken."
    @type shipping :: %{
            optional(:address) => address,
            optional(:name) => binary,
            optional(:phone) => binary | binary
          }
  )

  (
    @typedoc "If this is a `sofort` PaymentMethod, this hash contains details about the SOFORT payment method."
    @type sofort :: %{optional(:country) => :AT | :BE | :DE | :ES | :IT | :NL}
  )

  (
    @typedoc "If this is an `us_bank_account` PaymentMethod, this hash contains details about the US bank account payment method."
    @type us_bank_account :: %{
            optional(:account_holder_type) => :company | :individual,
            optional(:account_number) => binary,
            optional(:account_type) => :checking | :savings,
            optional(:financial_connections_account) => binary,
            optional(:routing_number) => binary
          }
  )

  (
    nil

    @doc "<p>Retrieves an existing ConfirmationToken object</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/confirmation_tokens/{confirmation_token}`\n"
    (
      @spec retrieve(
              confirmation_token :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.ConfirmationToken.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(confirmation_token, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/confirmation_tokens/{confirmation_token}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "confirmation_token",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "confirmation_token",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [confirmation_token]
          )

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

    @doc "<p>Creates a test mode Confirmation Token server side for your integration tests.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/confirmation_tokens`\n"
    (
      @spec create(
              params :: %{
                optional(:expand) => list(binary),
                optional(:payment_method) => binary,
                optional(:payment_method_data) => payment_method_data,
                optional(:return_url) => binary,
                optional(:setup_future_usage) => :off_session | :on_session,
                optional(:shipping) => shipping
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.ConfirmationToken.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params("/v1/test_helpers/confirmation_tokens", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end
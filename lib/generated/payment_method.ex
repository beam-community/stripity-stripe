defmodule Stripe.PaymentMethod do
  use Stripe.Entity

  @moduledoc "PaymentMethod objects represent your customer's payment instruments.\nYou can use them with [PaymentIntents](https://stripe.com/docs/payments/payment-intents) to collect payments or save them to\nCustomer objects to store instrument details for future payments.\n\nRelated guides: [Payment Methods](https://stripe.com/docs/payments/payment-methods) and [More Payment Scenarios](https://stripe.com/docs/payments/more-payment-scenarios)."
  (
    defstruct [
      :eps,
      :id,
      :paynow,
      :klarna,
      :sepa_debit,
      :card_present,
      :customer_balance,
      :au_becs_debit,
      :bancontact,
      :grabpay,
      :type,
      :afterpay_clearpay,
      :created,
      :p24,
      :sofort,
      :wechat_pay,
      :blik,
      :billing_details,
      :konbini,
      :object,
      :boleto,
      :paypal,
      :zip,
      :us_bank_account,
      :customer,
      :interac_present,
      :oxxo,
      :cashapp,
      :promptpay,
      :link,
      :metadata,
      :radar_options,
      :card,
      :ideal,
      :giropay,
      :alipay,
      :bacs_debit,
      :acss_debit,
      :livemode,
      :affirm,
      :fpx,
      :pix
    ]

    @typedoc "The `payment_method` type.\n\n  * `acss_debit` \n  * `affirm` \n  * `afterpay_clearpay` \n  * `alipay` \n  * `au_becs_debit` \n  * `bacs_debit` \n  * `bancontact` \n  * `billing_details` \n  * `blik` \n  * `boleto` \n  * `card` \n  * `card_present` \n  * `cashapp` \n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `customer` The ID of the Customer to which this PaymentMethod is saved. This will not be set when the PaymentMethod has not been saved to a Customer.\n  * `customer_balance` \n  * `eps` \n  * `fpx` \n  * `giropay` \n  * `grabpay` \n  * `id` Unique identifier for the object.\n  * `ideal` \n  * `interac_present` \n  * `klarna` \n  * `konbini` \n  * `link` \n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `oxxo` \n  * `p24` \n  * `paynow` \n  * `paypal` \n  * `pix` \n  * `promptpay` \n  * `radar_options` \n  * `sepa_debit` \n  * `sofort` \n  * `type` The type of the PaymentMethod. An additional hash is included on the PaymentMethod with a name matching this value. It contains additional information specific to the PaymentMethod type.\n  * `us_bank_account` \n  * `wechat_pay` \n  * `zip` \n"
    @type t :: %__MODULE__{
            acss_debit: term,
            affirm: term,
            afterpay_clearpay: term,
            alipay: term,
            au_becs_debit: term,
            bacs_debit: term,
            bancontact: term,
            billing_details: term,
            blik: term,
            boleto: term,
            card: term,
            card_present: term,
            cashapp: term,
            created: integer,
            customer: (binary | Stripe.Customer.t()) | nil,
            customer_balance: term,
            eps: term,
            fpx: term,
            giropay: term,
            grabpay: term,
            id: binary,
            ideal: term,
            interac_present: term,
            klarna: term,
            konbini: term,
            link: term,
            livemode: boolean,
            metadata: term | nil,
            object: binary,
            oxxo: term,
            p24: term,
            paynow: term,
            paypal: term,
            pix: term,
            promptpay: term,
            radar_options: term,
            sepa_debit: term,
            sofort: term,
            type: binary,
            us_bank_account: term,
            wechat_pay: term,
            zip: term
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
            optional(:name) => binary,
            optional(:phone) => binary
          }
  )

  (
    @typedoc "If this is a `boleto` PaymentMethod, this hash contains details about the Boleto payment method."
    @type boleto :: %{optional(:tax_id) => binary}
  )

  (
    @typedoc nil
    @type card :: %{
            optional(:cvc) => binary,
            optional(:exp_month) => integer,
            optional(:exp_year) => integer,
            optional(:number) => binary
          }
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
              | :volkswagen_bank
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

    @doc "<p>Creates a PaymentMethod object. Read the <a href=\"/docs/stripe-js/reference#stripe-create-payment-method\">Stripe.js reference</a> to learn how to create PaymentMethods via Stripe.js.</p>\n\n<p>Instead of creating a PaymentMethod directly, we recommend using the <a href=\"/docs/payments/accept-a-payment\">PaymentIntents</a> API to accept a payment immediately or the <a href=\"/docs/payments/save-and-reuse\">SetupIntent</a> API to collect payment method details ahead of a future payment.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_methods`\n"
    (
      @spec create(
              params :: %{
                optional(:pix) => map(),
                optional(:payment_method) => binary,
                optional(:fpx) => fpx,
                optional(:affirm) => map(),
                optional(:acss_debit) => acss_debit,
                optional(:bacs_debit) => bacs_debit,
                optional(:alipay) => map(),
                optional(:giropay) => map(),
                optional(:ideal) => ideal,
                optional(:expand) => list(binary),
                optional(:card) => card | card,
                optional(:radar_options) => radar_options,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:link) => map(),
                optional(:promptpay) => map(),
                optional(:cashapp) => map(),
                optional(:oxxo) => map(),
                optional(:interac_present) => map(),
                optional(:customer) => binary,
                optional(:us_bank_account) => us_bank_account,
                optional(:zip) => map(),
                optional(:paypal) => map(),
                optional(:boleto) => boleto,
                optional(:konbini) => map(),
                optional(:billing_details) => billing_details,
                optional(:blik) => map(),
                optional(:wechat_pay) => map(),
                optional(:sofort) => sofort,
                optional(:p24) => p24,
                optional(:afterpay_clearpay) => map(),
                optional(:type) =>
                  :acss_debit
                  | :affirm
                  | :afterpay_clearpay
                  | :alipay
                  | :au_becs_debit
                  | :bacs_debit
                  | :bancontact
                  | :blik
                  | :boleto
                  | :card
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
                  | :oxxo
                  | :p24
                  | :paynow
                  | :paypal
                  | :pix
                  | :promptpay
                  | :sepa_debit
                  | :sofort
                  | :us_bank_account
                  | :wechat_pay
                  | :zip,
                optional(:grabpay) => map(),
                optional(:bancontact) => map(),
                optional(:au_becs_debit) => au_becs_debit,
                optional(:customer_balance) => map(),
                optional(:sepa_debit) => sepa_debit,
                optional(:klarna) => klarna,
                optional(:paynow) => map(),
                optional(:eps) => eps
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentMethod.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/payment_methods", [], [])

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

    @doc "<p>Retrieves a PaymentMethod object attached to the StripeAccount. To retrieve a payment method attached to a Customer, you should use <a href=\"/docs/api/payment_methods/customer\">Retrieve a Customer’s PaymentMethods</a></p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/payment_methods/{payment_method}`\n"
    (
      @spec retrieve(
              payment_method :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentMethod.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(payment_method, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_methods/{payment_method}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "payment_method",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "payment_method",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [payment_method]
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

    @doc "<p>Updates a PaymentMethod object. A PaymentMethod must be attached a customer to be updated.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_methods/{payment_method}`\n"
    (
      @spec update(
              payment_method :: binary(),
              params :: %{
                optional(:acss_debit) => map(),
                optional(:affirm) => map(),
                optional(:au_becs_debit) => map(),
                optional(:bacs_debit) => map(),
                optional(:billing_details) => billing_details,
                optional(:blik) => map(),
                optional(:card) => card,
                optional(:cashapp) => map(),
                optional(:expand) => list(binary),
                optional(:link) => map(),
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:sepa_debit) => map(),
                optional(:us_bank_account) => us_bank_account,
                optional(:zip) => map()
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentMethod.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(payment_method, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_methods/{payment_method}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "payment_method",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "payment_method",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [payment_method]
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

    @doc "<p>Returns a list of PaymentMethods for Treasury flows. If you want to list the PaymentMethods attached to a Customer for payments, you should use the <a href=\"/docs/api/payment_methods/customer_list\">List a Customer’s PaymentMethods</a> API instead.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/payment_methods`\n"
    (
      @spec list(
              params :: %{
                optional(:customer) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:type) =>
                  :acss_debit
                  | :affirm
                  | :afterpay_clearpay
                  | :alipay
                  | :au_becs_debit
                  | :bacs_debit
                  | :bancontact
                  | :blik
                  | :boleto
                  | :card
                  | :card_present
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
                  | :oxxo
                  | :p24
                  | :paynow
                  | :paypal
                  | :pix
                  | :promptpay
                  | :sepa_debit
                  | :sofort
                  | :us_bank_account
                  | :wechat_pay
                  | :zip
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.PaymentMethod.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/payment_methods", [], [])

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

    @doc "<p>Attaches a PaymentMethod object to a Customer.</p>\n\n<p>To attach a new PaymentMethod to a customer for future payments, we recommend you use a <a href=\"/docs/api/setup_intents\">SetupIntent</a>\nor a PaymentIntent with <a href=\"/docs/api/payment_intents/create#create_payment_intent-setup_future_usage\">setup_future_usage</a>.\nThese approaches will perform any necessary steps to set up the PaymentMethod for future payments. Using the <code>/v1/payment_methods/:id/attach</code>\nendpoint without first using a SetupIntent or PaymentIntent with <code>setup_future_usage</code> does not optimize the PaymentMethod for\nfuture use, which makes later declines and payment friction more likely.\nSee <a href=\"/docs/payments/payment-intents#future-usage\">Optimizing cards for future payments</a> for more information about setting up\nfuture payments.</p>\n\n<p>To use this PaymentMethod as the default for invoice or subscription payments,\nset <a href=\"/docs/api/customers/update#update_customer-invoice_settings-default_payment_method\"><code>invoice_settings.default_payment_method</code></a>,\non the Customer to the PaymentMethod’s ID.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_methods/{payment_method}/attach`\n"
    (
      @spec attach(
              payment_method :: binary(),
              params :: %{optional(:customer) => binary, optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentMethod.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def attach(payment_method, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_methods/{payment_method}/attach",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "payment_method",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "payment_method",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [payment_method]
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

    @doc "<p>Detaches a PaymentMethod object from a Customer. After a PaymentMethod is detached, it can no longer be used for a payment or re-attached to a Customer.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_methods/{payment_method}/detach`\n"
    (
      @spec detach(
              payment_method :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentMethod.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def detach(payment_method, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_methods/{payment_method}/detach",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "payment_method",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "payment_method",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [payment_method]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end
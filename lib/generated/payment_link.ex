defmodule Stripe.PaymentLink do
  use Stripe.Entity

  @moduledoc "A payment link is a shareable URL that will take your customers to a hosted payment page. A payment link can be shared and used multiple times.\n\nWhen a customer opens a payment link it will open a new [checkout session](https://stripe.com/docs/api/checkout/sessions) to render the payment page. You can use [checkout session events](https://stripe.com/docs/api/events/types#event_types-checkout.session.completed) to track payments through payment links.\n\nRelated guide: [Payment Links API](https://stripe.com/docs/payment-links)"
  (
    defstruct [
      :active,
      :after_completion,
      :allow_promotion_codes,
      :application_fee_amount,
      :application_fee_percent,
      :automatic_tax,
      :billing_address_collection,
      :consent_collection,
      :currency,
      :custom_fields,
      :custom_text,
      :customer_creation,
      :id,
      :invoice_creation,
      :line_items,
      :livemode,
      :metadata,
      :object,
      :on_behalf_of,
      :payment_intent_data,
      :payment_method_collection,
      :payment_method_types,
      :phone_number_collection,
      :shipping_address_collection,
      :shipping_options,
      :submit_type,
      :subscription_data,
      :tax_id_collection,
      :transfer_data,
      :url
    ]

    @typedoc "The `payment_link` type.\n\n  * `active` Whether the payment link's `url` is active. If `false`, customers visiting the URL will be shown a page saying that the link has been deactivated.\n  * `after_completion` \n  * `allow_promotion_codes` Whether user redeemable promotion codes are enabled.\n  * `application_fee_amount` The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the application owner's Stripe account.\n  * `application_fee_percent` This represents the percentage of the subscription invoice total that will be transferred to the application owner's Stripe account.\n  * `automatic_tax` \n  * `billing_address_collection` Configuration for collecting the customer's billing address.\n  * `consent_collection` When set, provides configuration to gather active consent from customers.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `custom_fields` Collect additional information from your customer using custom fields. Up to 2 fields are supported.\n  * `custom_text` \n  * `customer_creation` Configuration for Customer creation during checkout.\n  * `id` Unique identifier for the object.\n  * `invoice_creation` Configuration for creating invoice for payment mode payment links.\n  * `line_items` The line items representing what is being sold.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `on_behalf_of` The account on behalf of which to charge. See the [Connect documentation](https://support.stripe.com/questions/sending-invoices-on-behalf-of-connected-accounts) for details.\n  * `payment_intent_data` Indicates the parameters to be passed to PaymentIntent creation during checkout.\n  * `payment_method_collection` Configuration for collecting a payment method during checkout.\n  * `payment_method_types` The list of payment method types that customers can use. When `null`, Stripe will dynamically show relevant payment methods you've enabled in your [payment method settings](https://dashboard.stripe.com/settings/payment_methods).\n  * `phone_number_collection` \n  * `shipping_address_collection` Configuration for collecting the customer's shipping address.\n  * `shipping_options` The shipping rate options applied to the session.\n  * `submit_type` Indicates the type of transaction being performed which customizes relevant text on the page, such as the submit button.\n  * `subscription_data` When creating a subscription, the specified configuration data will be used. There must be at least one line item with a recurring price to use `subscription_data`.\n  * `tax_id_collection` \n  * `transfer_data` The account (if any) the payments will be attributed to for tax reporting, and where funds from each payment will be transferred to.\n  * `url` The public URL that can be shared with customers.\n"
    @type t :: %__MODULE__{
            active: boolean,
            after_completion: term,
            allow_promotion_codes: boolean,
            application_fee_amount: integer | nil,
            application_fee_percent: term | nil,
            automatic_tax: term,
            billing_address_collection: binary,
            consent_collection: term | nil,
            currency: binary,
            custom_fields: term,
            custom_text: term,
            customer_creation: binary,
            id: binary,
            invoice_creation: term | nil,
            line_items: term,
            livemode: boolean,
            metadata: term,
            object: binary,
            on_behalf_of: (binary | Stripe.Account.t()) | nil,
            payment_intent_data: term | nil,
            payment_method_collection: binary,
            payment_method_types: term | nil,
            phone_number_collection: term,
            shipping_address_collection: term | nil,
            shipping_options: term,
            submit_type: binary,
            subscription_data: term | nil,
            tax_id_collection: term,
            transfer_data: term | nil,
            url: binary
          }
  )

  (
    @typedoc "When set, provides configuration for this item’s quantity to be adjusted by the customer during checkout."
    @type adjustable_quantity :: %{
            optional(:enabled) => boolean,
            optional(:maximum) => integer,
            optional(:minimum) => integer
          }
  )

  (
    @typedoc "Behavior after the purchase is complete."
    @type after_completion :: %{
            optional(:hosted_confirmation) => hosted_confirmation,
            optional(:redirect) => redirect,
            optional(:type) => :hosted_confirmation | :redirect
          }
  )

  (
    @typedoc "Configuration for automatic tax collection."
    @type automatic_tax :: %{optional(:enabled) => boolean}
  )

  (
    @typedoc "Configure fields to gather active consent from customers."
    @type consent_collection :: %{
            optional(:promotions) => :auto | :none,
            optional(:terms_of_service) => :none | :required
          }
  )

  (
    @typedoc nil
    @type custom_fields :: %{
            optional(:dropdown) => dropdown,
            optional(:key) => binary,
            optional(:label) => label,
            optional(:numeric) => numeric,
            optional(:optional) => boolean,
            optional(:text) => text,
            optional(:type) => :dropdown | :numeric | :text
          }
  )

  (
    @typedoc "Display additional text for your customers using custom text."
    @type custom_text :: %{
            optional(:shipping_address) => shipping_address | binary,
            optional(:submit) => submit | binary
          }
  )

  (
    @typedoc "Configuration for `type=dropdown` fields."
    @type dropdown :: %{optional(:options) => list(options)}
  )

  (
    @typedoc "Configuration when `type=hosted_confirmation`."
    @type hosted_confirmation :: %{optional(:custom_message) => binary}
  )

  (
    @typedoc "Generate a post-purchase Invoice for one-time payments."
    @type invoice_creation :: %{
            optional(:enabled) => boolean,
            optional(:invoice_data) => invoice_data
          }
  )

  (
    @typedoc "Invoice PDF configuration."
    @type invoice_data :: %{
            optional(:account_tax_ids) => list(binary) | binary,
            optional(:custom_fields) => list(custom_fields) | binary,
            optional(:description) => binary,
            optional(:footer) => binary,
            optional(:metadata) => %{optional(binary) => binary} | binary,
            optional(:rendering_options) => rendering_options | binary
          }
  )

  (
    @typedoc "The label for the field, displayed to the customer."
    @type label :: %{optional(:custom) => binary, optional(:type) => :custom}
  )

  (
    @typedoc nil
    @type line_items :: %{
            optional(:adjustable_quantity) => adjustable_quantity,
            optional(:price) => binary,
            optional(:quantity) => integer
          }
  )

  (
    @typedoc "Configuration for `type=numeric` fields."
    @type numeric :: %{optional(:maximum_length) => integer, optional(:minimum_length) => integer}
  )

  (
    @typedoc nil
    @type options :: %{optional(:label) => binary, optional(:value) => binary}
  )

  (
    @typedoc "A subset of parameters to be passed to PaymentIntent creation for Checkout Sessions in `payment` mode."
    @type payment_intent_data :: %{
            optional(:capture_method) => :automatic | :automatic_async | :manual,
            optional(:setup_future_usage) => :off_session | :on_session
          }
  )

  (
    @typedoc "Controls phone number collection settings during checkout.\n\nWe recommend that you review your privacy policy and check with your legal contacts."
    @type phone_number_collection :: %{optional(:enabled) => boolean}
  )

  (
    @typedoc "Configuration when `type=redirect`."
    @type redirect :: %{optional(:url) => binary}
  )

  (
    @typedoc nil
    @type rendering_options :: %{
            optional(:amount_tax_display) => :exclude_tax | :include_inclusive_tax
          }
  )

  (
    @typedoc nil
    @type shipping_address :: %{optional(:message) => binary}
  )

  (
    @typedoc "Configuration for collecting the customer's shipping address."
    @type shipping_address_collection :: %{
            optional(:allowed_countries) =>
              list(
                :AC
                | :AD
                | :AE
                | :AF
                | :AG
                | :AI
                | :AL
                | :AM
                | :AO
                | :AQ
                | :AR
                | :AT
                | :AU
                | :AW
                | :AX
                | :AZ
                | :BA
                | :BB
                | :BD
                | :BE
                | :BF
                | :BG
                | :BH
                | :BI
                | :BJ
                | :BL
                | :BM
                | :BN
                | :BO
                | :BQ
                | :BR
                | :BS
                | :BT
                | :BV
                | :BW
                | :BY
                | :BZ
                | :CA
                | :CD
                | :CF
                | :CG
                | :CH
                | :CI
                | :CK
                | :CL
                | :CM
                | :CN
                | :CO
                | :CR
                | :CV
                | :CW
                | :CY
                | :CZ
                | :DE
                | :DJ
                | :DK
                | :DM
                | :DO
                | :DZ
                | :EC
                | :EE
                | :EG
                | :EH
                | :ER
                | :ES
                | :ET
                | :FI
                | :FJ
                | :FK
                | :FO
                | :FR
                | :GA
                | :GB
                | :GD
                | :GE
                | :GF
                | :GG
                | :GH
                | :GI
                | :GL
                | :GM
                | :GN
                | :GP
                | :GQ
                | :GR
                | :GS
                | :GT
                | :GU
                | :GW
                | :GY
                | :HK
                | :HN
                | :HR
                | :HT
                | :HU
                | :ID
                | :IE
                | :IL
                | :IM
                | :IN
                | :IO
                | :IQ
                | :IS
                | :IT
                | :JE
                | :JM
                | :JO
                | :JP
                | :KE
                | :KG
                | :KH
                | :KI
                | :KM
                | :KN
                | :KR
                | :KW
                | :KY
                | :KZ
                | :LA
                | :LB
                | :LC
                | :LI
                | :LK
                | :LR
                | :LS
                | :LT
                | :LU
                | :LV
                | :LY
                | :MA
                | :MC
                | :MD
                | :ME
                | :MF
                | :MG
                | :MK
                | :ML
                | :MM
                | :MN
                | :MO
                | :MQ
                | :MR
                | :MS
                | :MT
                | :MU
                | :MV
                | :MW
                | :MX
                | :MY
                | :MZ
                | :NA
                | :NC
                | :NE
                | :NG
                | :NI
                | :NL
                | :NO
                | :NP
                | :NR
                | :NU
                | :NZ
                | :OM
                | :PA
                | :PE
                | :PF
                | :PG
                | :PH
                | :PK
                | :PL
                | :PM
                | :PN
                | :PR
                | :PS
                | :PT
                | :PY
                | :QA
                | :RE
                | :RO
                | :RS
                | :RU
                | :RW
                | :SA
                | :SB
                | :SC
                | :SE
                | :SG
                | :SH
                | :SI
                | :SJ
                | :SK
                | :SL
                | :SM
                | :SN
                | :SO
                | :SR
                | :SS
                | :ST
                | :SV
                | :SX
                | :SZ
                | :TA
                | :TC
                | :TD
                | :TF
                | :TG
                | :TH
                | :TJ
                | :TK
                | :TL
                | :TM
                | :TN
                | :TO
                | :TR
                | :TT
                | :TV
                | :TW
                | :TZ
                | :UA
                | :UG
                | :US
                | :UY
                | :UZ
                | :VA
                | :VC
                | :VE
                | :VG
                | :VN
                | :VU
                | :WF
                | :WS
                | :XK
                | :YE
                | :YT
                | :ZA
                | :ZM
                | :ZW
                | :ZZ
              )
          }
  )

  (
    @typedoc nil
    @type shipping_options :: %{optional(:shipping_rate) => binary}
  )

  (
    @typedoc nil
    @type submit :: %{optional(:message) => binary}
  )

  (
    @typedoc "When creating a subscription, the specified configuration data will be used. There must be at least one line item with a recurring price to use `subscription_data`."
    @type subscription_data :: %{
            optional(:description) => binary,
            optional(:trial_period_days) => integer
          }
  )

  (
    @typedoc "Controls tax ID collection during checkout."
    @type tax_id_collection :: %{optional(:enabled) => boolean}
  )

  (
    @typedoc "Configuration for `type=text` fields."
    @type text :: %{optional(:maximum_length) => integer, optional(:minimum_length) => integer}
  )

  (
    @typedoc "The account (if any) the payments will be attributed to for tax reporting, and where funds from each payment will be transferred to."
    @type transfer_data :: %{optional(:amount) => integer, optional(:destination) => binary}
  )

  (
    nil

    @doc "<p>Returns a list of your payment links.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/payment_links`\n"
    (
      @spec list(
              params :: %{
                optional(:active) => boolean,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.PaymentLink.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/payment_links", [], [])

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

    @doc "<p>Retrieve a payment link.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/payment_links/{payment_link}`\n"
    (
      @spec retrieve(
              payment_link :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.PaymentLink.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(payment_link, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_links/{payment_link}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "payment_link",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "payment_link",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [payment_link]
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

    @doc "<p>When retrieving a payment link, there is an includable <strong>line_items</strong> property containing the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/payment_links/{payment_link}/line_items`\n"
    (
      @spec list_line_items(
              payment_link :: binary(),
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Item.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list_line_items(payment_link, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_links/{payment_link}/line_items",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "payment_link",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "payment_link",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [payment_link]
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

    @doc "<p>Creates a payment link.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_links`\n"
    (
      @spec create(
              params :: %{
                optional(:after_completion) => after_completion,
                optional(:allow_promotion_codes) => boolean,
                optional(:application_fee_amount) => integer,
                optional(:application_fee_percent) => number,
                optional(:automatic_tax) => automatic_tax,
                optional(:billing_address_collection) => :auto | :required,
                optional(:consent_collection) => consent_collection,
                optional(:currency) => binary,
                optional(:custom_fields) => list(custom_fields),
                optional(:custom_text) => custom_text,
                optional(:customer_creation) => :always | :if_required,
                optional(:expand) => list(binary),
                optional(:invoice_creation) => invoice_creation,
                optional(:line_items) => list(line_items),
                optional(:metadata) => %{optional(binary) => binary},
                optional(:on_behalf_of) => binary,
                optional(:payment_intent_data) => payment_intent_data,
                optional(:payment_method_collection) => :always | :if_required,
                optional(:payment_method_types) =>
                  list(
                    :affirm
                    | :afterpay_clearpay
                    | :alipay
                    | :au_becs_debit
                    | :bacs_debit
                    | :bancontact
                    | :blik
                    | :boleto
                    | :card
                    | :cashapp
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
                  ),
                optional(:phone_number_collection) => phone_number_collection,
                optional(:shipping_address_collection) => shipping_address_collection,
                optional(:shipping_options) => list(shipping_options),
                optional(:submit_type) => :auto | :book | :donate | :pay,
                optional(:subscription_data) => subscription_data,
                optional(:tax_id_collection) => tax_id_collection,
                optional(:transfer_data) => transfer_data
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.PaymentLink.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/payment_links", [], [])

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

    @doc "<p>Updates a payment link.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/payment_links/{payment_link}`\n"
    (
      @spec update(
              payment_link :: binary(),
              params :: %{
                optional(:active) => boolean,
                optional(:after_completion) => after_completion,
                optional(:allow_promotion_codes) => boolean,
                optional(:automatic_tax) => automatic_tax,
                optional(:billing_address_collection) => :auto | :required,
                optional(:custom_fields) => list(custom_fields) | binary,
                optional(:custom_text) => custom_text,
                optional(:customer_creation) => :always | :if_required,
                optional(:expand) => list(binary),
                optional(:invoice_creation) => invoice_creation,
                optional(:line_items) => list(line_items),
                optional(:metadata) => %{optional(binary) => binary},
                optional(:payment_method_collection) => :always | :if_required,
                optional(:payment_method_types) =>
                  list(
                    :affirm
                    | :afterpay_clearpay
                    | :alipay
                    | :au_becs_debit
                    | :bacs_debit
                    | :bancontact
                    | :blik
                    | :boleto
                    | :card
                    | :cashapp
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
                  )
                  | binary,
                optional(:shipping_address_collection) => shipping_address_collection | binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.PaymentLink.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(payment_link, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_links/{payment_link}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "payment_link",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "payment_link",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [payment_link]
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

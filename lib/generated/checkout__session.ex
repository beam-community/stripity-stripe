defmodule Stripe.Checkout.Session do
  use Stripe.Entity

  @moduledoc "A Checkout Session represents your customer's session as they pay for\none-time purchases or subscriptions through [Checkout](https://stripe.com/docs/payments/checkout)\nor [Payment Links](https://stripe.com/docs/payments/payment-links). We recommend creating a\nnew Session each time your customer attempts to pay.\n\nOnce payment is successful, the Checkout Session will contain a reference\nto the [Customer](https://stripe.com/docs/api/customers), and either the successful\n[PaymentIntent](https://stripe.com/docs/api/payment_intents) or an active\n[Subscription](https://stripe.com/docs/api/subscriptions).\n\nYou can create a Checkout Session on your server and redirect to its URL\nto begin Checkout.\n\nRelated guide: [Checkout quickstart](https://stripe.com/docs/checkout/quickstart)"
  (
    defstruct [
      :line_items,
      :success_url,
      :allow_promotion_codes,
      :consent_collection,
      :mode,
      :currency_conversion,
      :ui_mode,
      :shipping_cost,
      :livemode,
      :customer,
      :billing_address_collection,
      :setup_intent,
      :after_expiration,
      :return_url,
      :created,
      :consent,
      :payment_intent,
      :expires_at,
      :customer_creation,
      :customer_details,
      :invoice,
      :status,
      :payment_link,
      :amount_total,
      :id,
      :cancel_url,
      :automatic_tax,
      :phone_number_collection,
      :invoice_creation,
      :payment_method_options,
      :currency,
      :url,
      :object,
      :payment_method_collection,
      :client_secret,
      :shipping_details,
      :payment_method_types,
      :tax_id_collection,
      :saved_payment_method_options,
      :client_reference_id,
      :customer_email,
      :recovered_from,
      :total_details,
      :locale,
      :shipping_options,
      :subscription,
      :redirect_on_completion,
      :amount_subtotal,
      :payment_status,
      :custom_fields,
      :metadata,
      :custom_text,
      :shipping_address_collection,
      :submit_type,
      :payment_method_configuration_details
    ]

    @typedoc "The `checkout.session` type.\n\n  * `after_expiration` When set, provides configuration for actions to take if this Checkout Session expires.\n  * `allow_promotion_codes` Enables user redeemable promotion codes.\n  * `amount_subtotal` Total of all items before discounts or taxes are applied.\n  * `amount_total` Total of all items after discounts and taxes are applied.\n  * `automatic_tax` \n  * `billing_address_collection` Describes whether Checkout should collect the customer's billing address. Defaults to `auto`.\n  * `cancel_url` If set, Checkout displays a back button and customers will be directed to this URL if they decide to cancel payment and return to your website.\n  * `client_reference_id` A unique string to reference the Checkout Session. This can be a\ncustomer ID, a cart ID, or similar, and can be used to reconcile the\nSession with your internal systems.\n  * `client_secret` Client secret to be used when initializing Stripe.js embedded checkout.\n  * `consent` Results of `consent_collection` for this session.\n  * `consent_collection` When set, provides configuration for the Checkout Session to gather active consent from customers.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `currency_conversion` Currency conversion details for [Adaptive Pricing](https://docs.stripe.com/payments/checkout/adaptive-pricing) sessions\n  * `custom_fields` Collect additional information from your customer using custom fields. Up to 3 fields are supported.\n  * `custom_text` \n  * `customer` The ID of the customer for this Session.\nFor Checkout Sessions in `subscription` mode or Checkout Sessions with `customer_creation` set as `always` in `payment` mode, Checkout\nwill create a new customer object based on information provided\nduring the payment flow unless an existing customer was provided when\nthe Session was created.\n  * `customer_creation` Configure whether a Checkout Session creates a Customer when the Checkout Session completes.\n  * `customer_details` The customer details including the customer's tax exempt status and the customer's tax IDs. Customer's address details are not present on Sessions in `setup` mode.\n  * `customer_email` If provided, this value will be used when the Customer object is created.\nIf not provided, customers will be asked to enter their email address.\nUse this parameter to prefill customer data if you already have an email\non file. To access information about the customer once the payment flow is\ncomplete, use the `customer` attribute.\n  * `expires_at` The timestamp at which the Checkout Session will expire.\n  * `id` Unique identifier for the object.\n  * `invoice` ID of the invoice created by the Checkout Session, if it exists.\n  * `invoice_creation` Details on the state of invoice creation for the Checkout Session.\n  * `line_items` The line items purchased by the customer.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `locale` The IETF language tag of the locale Checkout is displayed in. If blank or `auto`, the browser's locale is used.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `mode` The mode of the Checkout Session.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `payment_intent` The ID of the PaymentIntent for Checkout Sessions in `payment` mode. You can't confirm or cancel the PaymentIntent for a Checkout Session. To cancel, [expire the Checkout Session](https://stripe.com/docs/api/checkout/sessions/expire) instead.\n  * `payment_link` The ID of the Payment Link that created this Session.\n  * `payment_method_collection` Configure whether a Checkout Session should collect a payment method. Defaults to `always`.\n  * `payment_method_configuration_details` Information about the payment method configuration used for this Checkout session if using dynamic payment methods.\n  * `payment_method_options` Payment-method-specific configuration for the PaymentIntent or SetupIntent of this CheckoutSession.\n  * `payment_method_types` A list of the types of payment methods (e.g. card) this Checkout\nSession is allowed to accept.\n  * `payment_status` The payment status of the Checkout Session, one of `paid`, `unpaid`, or `no_payment_required`.\nYou can use this value to decide when to fulfill your customer's order.\n  * `phone_number_collection` \n  * `recovered_from` The ID of the original expired Checkout Session that triggered the recovery flow.\n  * `redirect_on_completion` This parameter applies to `ui_mode: embedded`. Learn more about the [redirect behavior](https://stripe.com/docs/payments/checkout/custom-success-page?payment-ui=embedded-form) of embedded sessions. Defaults to `always`.\n  * `return_url` Applies to Checkout Sessions with `ui_mode: embedded`. The URL to redirect your customer back to after they authenticate or cancel their payment on the payment method's app or site.\n  * `saved_payment_method_options` Controls saved payment method settings for the session. Only available in `payment` and `subscription` mode.\n  * `setup_intent` The ID of the SetupIntent for Checkout Sessions in `setup` mode. You can't confirm or cancel the SetupIntent for a Checkout Session. To cancel, [expire the Checkout Session](https://stripe.com/docs/api/checkout/sessions/expire) instead.\n  * `shipping_address_collection` When set, provides configuration for Checkout to collect a shipping address from a customer.\n  * `shipping_cost` The details of the customer cost of shipping, including the customer chosen ShippingRate.\n  * `shipping_details` Shipping information for this Checkout Session.\n  * `shipping_options` The shipping rate options applied to this Session.\n  * `status` The status of the Checkout Session, one of `open`, `complete`, or `expired`.\n  * `submit_type` Describes the type of transaction being performed by Checkout in order to customize\nrelevant text on the page, such as the submit button. `submit_type` can only be\nspecified on Checkout Sessions in `payment` mode. If blank or `auto`, `pay` is used.\n  * `subscription` The ID of the subscription for Checkout Sessions in `subscription` mode.\n  * `success_url` The URL the customer will be directed to after the payment or\nsubscription creation is successful.\n  * `tax_id_collection` \n  * `total_details` Tax and discount details for the computed total amount.\n  * `ui_mode` The UI mode of the Session. Defaults to `hosted`.\n  * `url` The URL to the Checkout Session. Redirect customers to this URL to take them to Checkout. If you’re using [Custom Domains](https://stripe.com/docs/payments/checkout/custom-domains), the URL will use your subdomain. Otherwise, it’ll use `checkout.stripe.com.`\nThis value is only present when the session is active.\n"
    @type t :: %__MODULE__{
            after_expiration: term | nil,
            allow_promotion_codes: boolean | nil,
            amount_subtotal: integer | nil,
            amount_total: integer | nil,
            automatic_tax: term,
            billing_address_collection: binary | nil,
            cancel_url: binary | nil,
            client_reference_id: binary | nil,
            client_secret: binary | nil,
            consent: term | nil,
            consent_collection: term | nil,
            created: integer,
            currency: binary | nil,
            currency_conversion: term | nil,
            custom_fields: term,
            custom_text: term,
            customer: (binary | Stripe.Customer.t() | Stripe.DeletedCustomer.t()) | nil,
            customer_creation: binary | nil,
            customer_details: term | nil,
            customer_email: binary | nil,
            expires_at: integer,
            id: binary,
            invoice: (binary | Stripe.Invoice.t()) | nil,
            invoice_creation: term | nil,
            line_items: term,
            livemode: boolean,
            locale: binary | nil,
            metadata: term | nil,
            mode: binary,
            object: binary,
            payment_intent: (binary | Stripe.PaymentIntent.t()) | nil,
            payment_link: (binary | Stripe.PaymentLink.t()) | nil,
            payment_method_collection: binary | nil,
            payment_method_configuration_details: term | nil,
            payment_method_options: term | nil,
            payment_method_types: term,
            payment_status: binary,
            phone_number_collection: term,
            recovered_from: binary | nil,
            redirect_on_completion: binary,
            return_url: binary,
            saved_payment_method_options: term | nil,
            setup_intent: (binary | Stripe.SetupIntent.t()) | nil,
            shipping_address_collection: term | nil,
            shipping_cost: term | nil,
            shipping_details: term | nil,
            shipping_options: term,
            status: binary | nil,
            submit_type: binary | nil,
            subscription: (binary | Stripe.Subscription.t()) | nil,
            success_url: binary | nil,
            tax_id_collection: term,
            total_details: term | nil,
            ui_mode: binary | nil,
            url: binary | nil
          }
  )

  (
    @typedoc "contains details about the ACSS Debit payment method options."
    @type acss_debit :: %{
            optional(:currency) => :cad | :usd,
            optional(:mandate_options) => mandate_options,
            optional(:setup_future_usage) => :none | :off_session | :on_session,
            optional(:verification_method) => :automatic | :instant | :microdeposits
          }
  )

  (
    @typedoc "Shipping address."
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
    @typedoc "When set, provides configuration for this item’s quantity to be adjusted by the customer during Checkout."
    @type adjustable_quantity :: %{
            optional(:enabled) => boolean,
            optional(:maximum) => integer,
            optional(:minimum) => integer
          }
  )

  (
    @typedoc "contains details about the Affirm payment method options."
    @type affirm :: %{optional(:setup_future_usage) => :none}
  )

  (
    @typedoc "Configure actions after a Checkout Session has expired."
    @type after_expiration :: %{optional(:recovery) => recovery}
  )

  (
    @typedoc nil
    @type after_submit :: %{optional(:message) => binary}
  )

  (
    @typedoc "contains details about the Afterpay Clearpay payment method options."
    @type afterpay_clearpay :: %{optional(:setup_future_usage) => :none}
  )

  (
    @typedoc "contains details about the Alipay payment method options."
    @type alipay :: %{optional(:setup_future_usage) => :none}
  )

  (
    @typedoc "contains details about the AmazonPay payment method options."
    @type amazon_pay :: %{optional(:setup_future_usage) => :none | :off_session}
  )

  (
    @typedoc "contains details about the AU Becs Debit payment method options."
    @type au_becs_debit :: %{optional(:setup_future_usage) => :none}
  )

  (
    @typedoc "Settings for automatic tax lookup for this session and resulting payments, invoices, and subscriptions."
    @type automatic_tax :: %{optional(:enabled) => boolean, optional(:liability) => liability}
  )

  (
    @typedoc "contains details about the Bacs Debit payment method options."
    @type bacs_debit :: %{optional(:setup_future_usage) => :none | :off_session | :on_session}
  )

  (
    @typedoc "contains details about the Bancontact payment method options."
    @type bancontact :: %{optional(:setup_future_usage) => :none}
  )

  (
    @typedoc "Configuration for the bank transfer funding type, if the `funding_type` is set to `bank_transfer`."
    @type bank_transfer :: %{
            optional(:eu_bank_transfer) => eu_bank_transfer,
            optional(:requested_address_types) =>
              list(:aba | :iban | :sepa | :sort_code | :spei | :swift | :zengin),
            optional(:type) =>
              :eu_bank_transfer
              | :gb_bank_transfer
              | :jp_bank_transfer
              | :mx_bank_transfer
              | :us_bank_transfer
          }
  )

  (
    @typedoc "contains details about the Boleto payment method options."
    @type boleto :: %{
            optional(:expires_after_days) => integer,
            optional(:setup_future_usage) => :none | :off_session | :on_session
          }
  )

  (
    @typedoc "contains details about the Card payment method options."
    @type card :: %{
            optional(:installments) => installments,
            optional(:request_three_d_secure) => :any | :automatic | :challenge,
            optional(:setup_future_usage) => :off_session | :on_session,
            optional(:statement_descriptor_suffix_kana) => binary,
            optional(:statement_descriptor_suffix_kanji) => binary
          }
  )

  (
    @typedoc "contains details about the Cashapp Pay payment method options."
    @type cashapp :: %{optional(:setup_future_usage) => :none | :off_session | :on_session}
  )

  (
    @typedoc "Configure fields for the Checkout Session to gather active consent from customers."
    @type consent_collection :: %{
            optional(:payment_method_reuse_agreement) => payment_method_reuse_agreement,
            optional(:promotions) => :auto | :none,
            optional(:terms_of_service) => :none | :required
          }
  )

  (
    @typedoc nil
    @type created :: %{
            optional(:gt) => integer,
            optional(:gte) => integer,
            optional(:lt) => integer,
            optional(:lte) => integer
          }
  )

  (
    @typedoc nil
    @type custom_fields :: %{optional(:name) => binary, optional(:value) => binary}
  )

  (
    @typedoc "Display additional text for your customers using custom text."
    @type custom_text :: %{
            optional(:after_submit) => after_submit | binary,
            optional(:shipping_address) => shipping_address | binary,
            optional(:submit) => submit | binary,
            optional(:terms_of_service_acceptance) => terms_of_service_acceptance | binary
          }
  )

  (
    @typedoc "contains details about the Customer Balance payment method options."
    @type customer_balance :: %{
            optional(:bank_transfer) => bank_transfer,
            optional(:funding_type) => :bank_transfer,
            optional(:setup_future_usage) => :none
          }
  )

  (
    @typedoc nil
    @type customer_details :: %{optional(:email) => binary}
  )

  (
    @typedoc "Controls what fields on Customer can be updated by the Checkout Session. Can only be provided when `customer` is provided."
    @type customer_update :: %{
            optional(:address) => :auto | :never,
            optional(:name) => :auto | :never,
            optional(:shipping) => :auto | :never
          }
  )

  (
    @typedoc "The estimated range for how long shipping will take, meant to be displayable to the customer. This will appear on CheckoutSessions."
    @type delivery_estimate :: %{optional(:maximum) => maximum, optional(:minimum) => minimum}
  )

  (
    @typedoc nil
    @type discounts :: %{optional(:coupon) => binary, optional(:promotion_code) => binary}
  )

  (
    @typedoc "Configuration for `type=dropdown` fields."
    @type dropdown :: %{optional(:default_value) => binary, optional(:options) => list(options)}
  )

  (
    @typedoc "Defines how the subscription should behave when the user's free trial ends."
    @type end_behavior :: %{
            optional(:missing_payment_method) => :cancel | :create_invoice | :pause
          }
  )

  (
    @typedoc "contains details about the EPS payment method options."
    @type eps :: %{optional(:setup_future_usage) => :none}
  )

  (
    @typedoc "Configuration for eu_bank_transfer funding type."
    @type eu_bank_transfer :: %{optional(:country) => binary}
  )

  (
    @typedoc "Additional fields for Financial Connections Session creation"
    @type financial_connections :: %{
            optional(:permissions) =>
              list(:balances | :ownership | :payment_method | :transactions),
            optional(:prefetch) => list(:balances | :ownership | :transactions)
          }
  )

  (
    @typedoc "Describes a fixed amount to charge for shipping. Must be present if type is `fixed_amount`."
    @type fixed_amount :: %{
            optional(:amount) => integer,
            optional(:currency) => binary,
            optional(:currency_options) => map()
          }
  )

  (
    @typedoc "contains details about the FPX payment method options."
    @type fpx :: %{optional(:setup_future_usage) => :none}
  )

  (
    @typedoc "contains details about the Giropay payment method options."
    @type giropay :: %{optional(:setup_future_usage) => :none}
  )

  (
    @typedoc "contains details about the Grabpay payment method options."
    @type grabpay :: %{optional(:setup_future_usage) => :none}
  )

  (
    @typedoc "contains details about the Ideal payment method options."
    @type ideal :: %{optional(:setup_future_usage) => :none}
  )

  (
    @typedoc "Installment options for card payments"
    @type installments :: %{optional(:enabled) => boolean}
  )

  (
    @typedoc "Generate a post-purchase Invoice for one-time payments."
    @type invoice_creation :: %{
            optional(:enabled) => boolean,
            optional(:invoice_data) => invoice_data
          }
  )

  (
    @typedoc "Parameters passed when creating invoices for payment-mode Checkout Sessions."
    @type invoice_data :: %{
            optional(:account_tax_ids) => list(binary) | binary,
            optional(:custom_fields) => list(custom_fields) | binary,
            optional(:description) => binary,
            optional(:footer) => binary,
            optional(:issuer) => issuer,
            optional(:metadata) => %{optional(binary) => binary},
            optional(:rendering_options) => rendering_options | binary
          }
  )

  (
    @typedoc "All invoices will be billed using the specified settings."
    @type invoice_settings :: %{optional(:issuer) => issuer}
  )

  (
    @typedoc "The connected account that issues the invoice. The invoice is presented with the branding and support information of the specified account."
    @type issuer :: %{optional(:account) => binary, optional(:type) => :account | :self}
  )

  (
    @typedoc "contains details about the Klarna payment method options."
    @type klarna :: %{optional(:setup_future_usage) => :none}
  )

  (
    @typedoc "contains details about the Konbini payment method options."
    @type konbini :: %{
            optional(:expires_after_days) => integer,
            optional(:setup_future_usage) => :none
          }
  )

  (
    @typedoc "The label for the field, displayed to the customer."
    @type label :: %{optional(:custom) => binary, optional(:type) => :custom}
  )

  (
    @typedoc "The account that's liable for tax. If set, the business address and tax registrations required to perform the tax calculation are loaded from this account. The tax transaction is returned in the report of the connected account."
    @type liability :: %{optional(:account) => binary, optional(:type) => :account | :self}
  )

  (
    @typedoc nil
    @type line_items :: %{
            optional(:adjustable_quantity) => adjustable_quantity,
            optional(:dynamic_tax_rates) => list(binary),
            optional(:price) => binary,
            optional(:price_data) => price_data,
            optional(:quantity) => integer,
            optional(:tax_rates) => list(binary)
          }
  )

  (
    @typedoc "contains details about the Link payment method options."
    @type link :: %{optional(:setup_future_usage) => :none | :off_session}
  )

  (
    @typedoc "Additional fields for Mandate creation"
    @type mandate_options :: %{
            optional(:custom_mandate_url) => binary | binary,
            optional(:default_for) => list(:invoice | :subscription),
            optional(:interval_description) => binary,
            optional(:payment_schedule) => :combined | :interval | :sporadic,
            optional(:transaction_type) => :business | :personal
          }
  )

  (
    @typedoc "The upper bound of the estimated range. If empty, represents no upper bound i.e., infinite."
    @type maximum :: %{
            optional(:unit) => :business_day | :day | :hour | :month | :week,
            optional(:value) => integer
          }
  )

  (
    @typedoc "The lower bound of the estimated range. If empty, represents no lower bound."
    @type minimum :: %{
            optional(:unit) => :business_day | :day | :hour | :month | :week,
            optional(:value) => integer
          }
  )

  (
    @typedoc "contains details about the Mobilepay payment method options."
    @type mobilepay :: %{optional(:setup_future_usage) => :none}
  )

  (
    @typedoc "contains details about the Multibanco payment method options."
    @type multibanco :: %{optional(:setup_future_usage) => :none}
  )

  (
    @typedoc "Configuration for `type=numeric` fields."
    @type numeric :: %{
            optional(:default_value) => binary,
            optional(:maximum_length) => integer,
            optional(:minimum_length) => integer
          }
  )

  (
    @typedoc nil
    @type options :: %{optional(:label) => binary, optional(:value) => binary}
  )

  (
    @typedoc "contains details about the OXXO payment method options."
    @type oxxo :: %{
            optional(:expires_after_days) => integer,
            optional(:setup_future_usage) => :none
          }
  )

  (
    @typedoc "contains details about the P24 payment method options."
    @type p24 :: %{
            optional(:setup_future_usage) => :none,
            optional(:tos_shown_and_accepted) => boolean
          }
  )

  (
    @typedoc "A subset of parameters to be passed to PaymentIntent creation for Checkout Sessions in `payment` mode."
    @type payment_intent_data :: %{
            optional(:application_fee_amount) => integer,
            optional(:capture_method) => :automatic | :automatic_async | :manual,
            optional(:description) => binary,
            optional(:metadata) => %{optional(binary) => binary},
            optional(:on_behalf_of) => binary,
            optional(:receipt_email) => binary,
            optional(:setup_future_usage) => :off_session | :on_session,
            optional(:shipping) => shipping,
            optional(:statement_descriptor) => binary,
            optional(:statement_descriptor_suffix) => binary,
            optional(:transfer_data) => transfer_data,
            optional(:transfer_group) => binary
          }
  )

  (
    @typedoc "This parameter allows you to set some attributes on the payment method created during a Checkout session."
    @type payment_method_data :: %{
            optional(:allow_redisplay) => :always | :limited | :unspecified
          }
  )

  (
    @typedoc "Payment-method-specific configuration."
    @type payment_method_options :: %{
            optional(:sofort) => sofort,
            optional(:customer_balance) => customer_balance,
            optional(:boleto) => boleto,
            optional(:alipay) => alipay,
            optional(:au_becs_debit) => au_becs_debit,
            optional(:amazon_pay) => amazon_pay,
            optional(:bancontact) => bancontact,
            optional(:bacs_debit) => bacs_debit,
            optional(:affirm) => affirm,
            optional(:mobilepay) => mobilepay,
            optional(:grabpay) => grabpay,
            optional(:eps) => eps,
            optional(:ideal) => ideal,
            optional(:pix) => pix,
            optional(:giropay) => giropay,
            optional(:multibanco) => multibanco,
            optional(:revolut_pay) => revolut_pay,
            optional(:klarna) => klarna,
            optional(:card) => card,
            optional(:acss_debit) => acss_debit,
            optional(:link) => link,
            optional(:konbini) => konbini,
            optional(:p24) => p24,
            optional(:paypal) => paypal,
            optional(:fpx) => fpx,
            optional(:oxxo) => oxxo,
            optional(:paynow) => paynow,
            optional(:wechat_pay) => wechat_pay,
            optional(:cashapp) => cashapp,
            optional(:sepa_debit) => sepa_debit,
            optional(:afterpay_clearpay) => afterpay_clearpay,
            optional(:us_bank_account) => us_bank_account,
            optional(:swish) => swish
          }
  )

  (
    @typedoc "Determines the display of payment method reuse agreement text in the UI. If set to `hidden`, it will hide legal text related to the reuse of a payment method."
    @type payment_method_reuse_agreement :: %{optional(:position) => :auto | :hidden}
  )

  (
    @typedoc "contains details about the PayNow payment method options."
    @type paynow :: %{optional(:setup_future_usage) => :none}
  )

  (
    @typedoc "contains details about the PayPal payment method options."
    @type paypal :: %{
            optional(:capture_method) => :manual,
            optional(:preferred_locale) =>
              :"cs-CZ"
              | :"da-DK"
              | :"de-AT"
              | :"de-DE"
              | :"de-LU"
              | :"el-GR"
              | :"en-GB"
              | :"en-US"
              | :"es-ES"
              | :"fi-FI"
              | :"fr-BE"
              | :"fr-FR"
              | :"fr-LU"
              | :"hu-HU"
              | :"it-IT"
              | :"nl-BE"
              | :"nl-NL"
              | :"pl-PL"
              | :"pt-PT"
              | :"sk-SK"
              | :"sv-SE",
            optional(:reference) => binary,
            optional(:risk_correlation_id) => binary,
            optional(:setup_future_usage) => :none | :off_session
          }
  )

  (
    @typedoc "Controls phone number collection settings for the session.\n\nWe recommend that you review your privacy policy and check with your legal contacts\nbefore using this feature. Learn more about [collecting phone numbers with Checkout](https://stripe.com/docs/payments/checkout/phone-numbers)."
    @type phone_number_collection :: %{optional(:enabled) => boolean}
  )

  (
    @typedoc "contains details about the Pix payment method options."
    @type pix :: %{optional(:expires_after_seconds) => integer}
  )

  (
    @typedoc "Data used to generate a new [Price](https://stripe.com/docs/api/prices) object inline. One of `price` or `price_data` is required."
    @type price_data :: %{
            optional(:currency) => binary,
            optional(:product) => binary,
            optional(:product_data) => product_data,
            optional(:recurring) => recurring,
            optional(:tax_behavior) => :exclusive | :inclusive | :unspecified,
            optional(:unit_amount) => integer,
            optional(:unit_amount_decimal) => binary
          }
  )

  (
    @typedoc "Data used to generate a new product object inline. One of `product` or `product_data` is required."
    @type product_data :: %{
            optional(:description) => binary,
            optional(:images) => list(binary),
            optional(:metadata) => %{optional(binary) => binary},
            optional(:name) => binary,
            optional(:tax_code) => binary
          }
  )

  (
    @typedoc "Configure a Checkout Session that can be used to recover an expired session."
    @type recovery :: %{
            optional(:allow_promotion_codes) => boolean,
            optional(:enabled) => boolean
          }
  )

  (
    @typedoc "The recurring components of a price such as `interval` and `interval_count`."
    @type recurring :: %{
            optional(:interval) => :day | :month | :week | :year,
            optional(:interval_count) => integer
          }
  )

  (
    @typedoc nil
    @type rendering_options :: %{
            optional(:amount_tax_display) => :exclude_tax | :include_inclusive_tax
          }
  )

  (
    @typedoc "contains details about the RevolutPay payment method options."
    @type revolut_pay :: %{optional(:setup_future_usage) => :none | :off_session}
  )

  (
    @typedoc "Controls saved payment method settings for the session. Only available in `payment` and `subscription` mode."
    @type saved_payment_method_options :: %{
            optional(:allow_redisplay_filters) => list(:always | :limited | :unspecified),
            optional(:payment_method_save) => :disabled | :enabled
          }
  )

  (
    @typedoc "contains details about the Sepa Debit payment method options."
    @type sepa_debit :: %{optional(:setup_future_usage) => :none | :off_session | :on_session}
  )

  (
    @typedoc "A subset of parameters to be passed to SetupIntent creation for Checkout Sessions in `setup` mode."
    @type setup_intent_data :: %{
            optional(:description) => binary,
            optional(:metadata) => %{optional(binary) => binary},
            optional(:on_behalf_of) => binary
          }
  )

  (
    @typedoc "Shipping information for this payment."
    @type shipping :: %{
            optional(:address) => address,
            optional(:carrier) => binary,
            optional(:name) => binary,
            optional(:phone) => binary,
            optional(:tracking_number) => binary
          }
  )

  (
    @typedoc nil
    @type shipping_address :: %{optional(:message) => binary}
  )

  (
    @typedoc "When set, provides configuration for Checkout to collect a shipping address from a customer."
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
    @type shipping_options :: %{
            optional(:shipping_rate) => binary,
            optional(:shipping_rate_data) => shipping_rate_data
          }
  )

  (
    @typedoc "Parameters to be passed to Shipping Rate creation for this shipping option."
    @type shipping_rate_data :: %{
            optional(:delivery_estimate) => delivery_estimate,
            optional(:display_name) => binary,
            optional(:fixed_amount) => fixed_amount,
            optional(:metadata) => %{optional(binary) => binary},
            optional(:tax_behavior) => :exclusive | :inclusive | :unspecified,
            optional(:tax_code) => binary,
            optional(:type) => :fixed_amount
          }
  )

  (
    @typedoc "contains details about the Sofort payment method options."
    @type sofort :: %{optional(:setup_future_usage) => :none}
  )

  (
    @typedoc nil
    @type submit :: %{optional(:message) => binary}
  )

  (
    @typedoc "A subset of parameters to be passed to subscription creation for Checkout Sessions in `subscription` mode."
    @type subscription_data :: %{
            optional(:application_fee_percent) => number,
            optional(:billing_cycle_anchor) => integer,
            optional(:default_tax_rates) => list(binary),
            optional(:description) => binary,
            optional(:invoice_settings) => invoice_settings,
            optional(:metadata) => %{optional(binary) => binary},
            optional(:on_behalf_of) => binary,
            optional(:proration_behavior) => :create_prorations | :none,
            optional(:transfer_data) => transfer_data,
            optional(:trial_end) => integer,
            optional(:trial_period_days) => integer,
            optional(:trial_settings) => trial_settings
          }
  )

  (
    @typedoc "contains details about the Swish payment method options."
    @type swish :: %{optional(:reference) => binary}
  )

  (
    @typedoc "Controls tax ID collection during checkout."
    @type tax_id_collection :: %{optional(:enabled) => boolean}
  )

  (
    @typedoc nil
    @type terms_of_service_acceptance :: %{optional(:message) => binary}
  )

  (
    @typedoc "Configuration for `type=text` fields."
    @type text :: %{
            optional(:default_value) => binary,
            optional(:maximum_length) => integer,
            optional(:minimum_length) => integer
          }
  )

  (
    @typedoc "The parameters used to automatically create a Transfer when the payment succeeds.\nFor more information, see the PaymentIntents [use case for connected accounts](https://stripe.com/docs/payments/connected-accounts)."
    @type transfer_data :: %{optional(:amount) => integer, optional(:destination) => binary}
  )

  (
    @typedoc "Settings related to subscription trials."
    @type trial_settings :: %{optional(:end_behavior) => end_behavior}
  )

  (
    @typedoc "contains details about the Us Bank Account payment method options."
    @type us_bank_account :: %{
            optional(:financial_connections) => financial_connections,
            optional(:setup_future_usage) => :none | :off_session | :on_session,
            optional(:verification_method) => :automatic | :instant
          }
  )

  (
    @typedoc "contains details about the WeChat Pay payment method options."
    @type wechat_pay :: %{
            optional(:app_id) => binary,
            optional(:client) => :android | :ios | :web,
            optional(:setup_future_usage) => :none
          }
  )

  (
    nil

    @doc "<p>Returns a list of Checkout Sessions.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/checkout/sessions`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:customer) => binary,
                optional(:customer_details) => customer_details,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:payment_intent) => binary,
                optional(:payment_link) => binary,
                optional(:starting_after) => binary,
                optional(:status) => :complete | :expired | :open,
                optional(:subscription) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Checkout.Session.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/checkout/sessions", [], [])

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

    @doc "<p>Retrieves a Session object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/checkout/sessions/{session}`\n"
    (
      @spec retrieve(
              session :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Checkout.Session.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(session, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/checkout/sessions/{session}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "session",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "session",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [session]
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

    @doc "<p>When retrieving a Checkout Session, there is an includable <strong>line_items</strong> property containing the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/checkout/sessions/{session}/line_items`\n"
    (
      @spec list_line_items(
              session :: binary(),
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
      def list_line_items(session, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/checkout/sessions/{session}/line_items",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "session",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "session",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [session]
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

    @doc "<p>Creates a Session object.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/checkout/sessions`\n"
    (
      @spec create(
              params :: %{
                optional(:submit_type) => :auto | :book | :donate | :pay,
                optional(:shipping_address_collection) => shipping_address_collection,
                optional(:custom_text) => custom_text,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:custom_fields) => list(custom_fields),
                optional(:setup_intent_data) => setup_intent_data,
                optional(:redirect_on_completion) => :always | :if_required | :never,
                optional(:payment_method_configuration) => binary,
                optional(:shipping_options) => list(shipping_options),
                optional(:locale) =>
                  :auto
                  | :bg
                  | :cs
                  | :da
                  | :de
                  | :el
                  | :en
                  | :"en-GB"
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
                optional(:payment_intent_data) => payment_intent_data,
                optional(:customer_email) => binary,
                optional(:client_reference_id) => binary,
                optional(:saved_payment_method_options) => saved_payment_method_options,
                optional(:tax_id_collection) => tax_id_collection,
                optional(:payment_method_types) =>
                  list(
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
                    | :zip
                  ),
                optional(:discounts) => list(discounts),
                optional(:payment_method_collection) => :always | :if_required,
                optional(:currency) => binary,
                optional(:payment_method_options) => payment_method_options,
                optional(:invoice_creation) => invoice_creation,
                optional(:phone_number_collection) => phone_number_collection,
                optional(:automatic_tax) => automatic_tax,
                optional(:cancel_url) => binary,
                optional(:customer_creation) => :always | :if_required,
                optional(:expires_at) => integer,
                optional(:subscription_data) => subscription_data,
                optional(:return_url) => binary,
                optional(:after_expiration) => after_expiration,
                optional(:billing_address_collection) => :auto | :required,
                optional(:customer) => binary,
                optional(:expand) => list(binary),
                optional(:payment_method_data) => payment_method_data,
                optional(:ui_mode) => :embedded | :hosted,
                optional(:mode) => :payment | :setup | :subscription,
                optional(:consent_collection) => consent_collection,
                optional(:allow_promotion_codes) => boolean,
                optional(:success_url) => binary,
                optional(:line_items) => list(line_items),
                optional(:customer_update) => customer_update
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Checkout.Session.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/checkout/sessions", [], [])

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

    @doc "<p>Updates a Session object.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/checkout/sessions/{session}`\n"
    (
      @spec update(
              session :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Checkout.Session.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(session, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/checkout/sessions/{session}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "session",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "session",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [session]
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

    @doc "<p>A Session can be expired when it is in one of these statuses: <code>open</code> </p>\n\n<p>After it expires, a customer can’t complete a Session and customers loading the Session see a message saying the Session is expired.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/checkout/sessions/{session}/expire`\n"
    (
      @spec expire(
              session :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Checkout.Session.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def expire(session, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/checkout/sessions/{session}/expire",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "session",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "session",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [session]
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
defmodule Stripe.Invoice do
  use Stripe.Entity

  @moduledoc "Invoices are statements of amounts owed by a customer, and are either\ngenerated one-off, or generated periodically from a subscription.\n\nThey contain [invoice items](https://stripe.com/docs/api#invoiceitems), and proration adjustments\nthat may be caused by subscription upgrades/downgrades (if necessary).\n\nIf your invoice is configured to be billed through automatic charges,\nStripe automatically finalizes your invoice and attempts payment. Note\nthat finalizing the invoice,\n[when automatic](https://stripe.com/docs/invoicing/integration/automatic-advancement-collection), does\nnot happen immediately as the invoice is created. Stripe waits\nuntil one hour after the last webhook was successfully sent (or the last\nwebhook timed out after failing). If you (and the platforms you may have\nconnected to) have no webhooks configured, Stripe waits one hour after\ncreation to finalize the invoice.\n\nIf your invoice is configured to be billed by sending an email, then based on your\n[email settings](https://dashboard.stripe.com/account/billing/automatic),\nStripe will email the invoice to your customer and await payment. These\nemails can contain a link to a hosted page to pay the invoice.\n\nStripe applies any customer credit on the account before determining the\namount due for the invoice (i.e., the amount that will be actually\ncharged). If the amount due for the invoice is less than Stripe's [minimum allowed charge\nper currency](/docs/currencies#minimum-and-maximum-charge-amounts), the\ninvoice is automatically marked paid, and we add the amount due to the\ncustomer's credit balance which is applied to the next invoice.\n\nMore details on the customer's credit balance are\n[here](https://stripe.com/docs/billing/customer/balance).\n\nRelated guide: [Send invoices to customers](https://stripe.com/docs/billing/invoices/sending)"
  (
    defstruct [
      :lines,
      :default_tax_rates,
      :id,
      :attempted,
      :transfer_data,
      :period_start,
      :tax,
      :application_fee_amount,
      :number,
      :rendering,
      :customer_address,
      :shipping_details,
      :ending_balance,
      :status,
      :from_invoice,
      :total_tax_amounts,
      :webhooks_delivered_at,
      :subscription,
      :next_payment_attempt,
      :period_end,
      :amount_remaining,
      :quote,
      :discounts,
      :created,
      :total_discount_amounts,
      :currency,
      :subtotal_excluding_tax,
      :total_excluding_tax,
      :automatic_tax,
      :test_clock,
      :post_payment_credit_notes_amount,
      :status_transitions,
      :latest_revision,
      :object,
      :billing_reason,
      :receipt_number,
      :default_source,
      :rendering_options,
      :due_date,
      :application,
      :payment_settings,
      :statement_descriptor,
      :hosted_invoice_url,
      :account_tax_ids,
      :amount_paid,
      :shipping_cost,
      :customer,
      :account_name,
      :charge,
      :on_behalf_of,
      :customer_email,
      :discount,
      :threshold_reason,
      :paid_out_of_band,
      :payment_intent,
      :total,
      :customer_shipping,
      :subscription_details,
      :footer,
      :subscription_proration_date,
      :pre_payment_credit_notes_amount,
      :paid,
      :description,
      :metadata,
      :account_country,
      :subtotal,
      :amount_shipping,
      :custom_fields,
      :customer_name,
      :attempt_count,
      :last_finalization_error,
      :amount_due,
      :default_payment_method,
      :collection_method,
      :effective_at,
      :customer_tax_ids,
      :livemode,
      :starting_balance,
      :invoice_pdf,
      :customer_phone,
      :auto_advance,
      :customer_tax_exempt
    ]

    @typedoc "The `invoice` type.\n\n  * `account_country` The country of the business associated with this invoice, most often the business creating the invoice.\n  * `account_name` The public name of the business associated with this invoice, most often the business creating the invoice.\n  * `account_tax_ids` The account tax IDs associated with the invoice. Only editable when the invoice is a draft.\n  * `amount_due` Final amount due at this time for this invoice. If the invoice's total is smaller than the minimum charge amount, for example, or if there is account credit that can be applied to the invoice, the `amount_due` may be 0. If there is a positive `starting_balance` for the invoice (the customer owes money), the `amount_due` will also take that into account. The charge that gets generated for the invoice will be for the amount specified in `amount_due`.\n  * `amount_paid` The amount, in cents (or local equivalent), that was paid.\n  * `amount_remaining` The difference between amount_due and amount_paid, in cents (or local equivalent).\n  * `amount_shipping` This is the sum of all the shipping amounts.\n  * `application` ID of the Connect Application that created the invoice.\n  * `application_fee_amount` The fee in cents (or local equivalent) that will be applied to the invoice and transferred to the application owner's Stripe account when the invoice is paid.\n  * `attempt_count` Number of payment attempts made for this invoice, from the perspective of the payment retry schedule. Any payment attempt counts as the first attempt, and subsequently only automatic retries increment the attempt count. In other words, manual payment attempts after the first attempt do not affect the retry schedule.\n  * `attempted` Whether an attempt has been made to pay the invoice. An invoice is not attempted until 1 hour after the `invoice.created` webhook, for example, so you might not want to display that invoice as unpaid to your users.\n  * `auto_advance` Controls whether Stripe performs [automatic collection](https://stripe.com/docs/invoicing/integration/automatic-advancement-collection) of the invoice. If `false`, the invoice's state doesn't automatically advance without an explicit action.\n  * `automatic_tax` \n  * `billing_reason` Indicates the reason why the invoice was created.\n\n* `manual`: Unrelated to a subscription, for example, created via the invoice editor.\n* `subscription`: No longer in use. Applies to subscriptions from before May 2018 where no distinction was made between updates, cycles, and thresholds.\n* `subscription_create`: A new subscription was created.\n* `subscription_cycle`: A subscription advanced into a new period.\n* `subscription_threshold`: A subscription reached a billing threshold.\n* `subscription_update`: A subscription was updated.\n* `upcoming`: Reserved for simulated invoices, per the upcoming invoice endpoint.\n  * `charge` ID of the latest charge generated for this invoice, if any.\n  * `collection_method` Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay this invoice using the default source attached to the customer. When sending an invoice, Stripe will email this invoice to the customer with payment instructions.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `custom_fields` Custom fields displayed on the invoice.\n  * `customer` The ID of the customer who will be billed.\n  * `customer_address` The customer's address. Until the invoice is finalized, this field will equal `customer.address`. Once the invoice is finalized, this field will no longer be updated.\n  * `customer_email` The customer's email. Until the invoice is finalized, this field will equal `customer.email`. Once the invoice is finalized, this field will no longer be updated.\n  * `customer_name` The customer's name. Until the invoice is finalized, this field will equal `customer.name`. Once the invoice is finalized, this field will no longer be updated.\n  * `customer_phone` The customer's phone number. Until the invoice is finalized, this field will equal `customer.phone`. Once the invoice is finalized, this field will no longer be updated.\n  * `customer_shipping` The customer's shipping information. Until the invoice is finalized, this field will equal `customer.shipping`. Once the invoice is finalized, this field will no longer be updated.\n  * `customer_tax_exempt` The customer's tax exempt status. Until the invoice is finalized, this field will equal `customer.tax_exempt`. Once the invoice is finalized, this field will no longer be updated.\n  * `customer_tax_ids` The customer's tax IDs. Until the invoice is finalized, this field will contain the same tax IDs as `customer.tax_ids`. Once the invoice is finalized, this field will no longer be updated.\n  * `default_payment_method` ID of the default payment method for the invoice. It must belong to the customer associated with the invoice. If not set, defaults to the subscription's default payment method, if any, or to the default payment method in the customer's invoice settings.\n  * `default_source` ID of the default payment source for the invoice. It must belong to the customer associated with the invoice and be in a chargeable state. If not set, defaults to the subscription's default source, if any, or to the customer's default source.\n  * `default_tax_rates` The tax rates applied to this invoice, if any.\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users. Referenced as 'memo' in the Dashboard.\n  * `discount` Describes the current discount applied to this invoice, if there is one. Not populated if there are multiple discounts.\n  * `discounts` The discounts applied to the invoice. Line item discounts are applied before invoice discounts. Use `expand[]=discounts` to expand each discount.\n  * `due_date` The date on which payment for this invoice is due. This value will be `null` for invoices where `collection_method=charge_automatically`.\n  * `effective_at` The date when this invoice is in effect. Same as `finalized_at` unless overwritten. When defined, this value replaces the system-generated 'Date of issue' printed on the invoice PDF and receipt.\n  * `ending_balance` Ending customer balance after the invoice is finalized. Invoices are finalized approximately an hour after successful webhook delivery or when payment collection is attempted for the invoice. If the invoice has not been finalized yet, this will be null.\n  * `footer` Footer displayed on the invoice.\n  * `from_invoice` Details of the invoice that was cloned. See the [revision documentation](https://stripe.com/docs/invoicing/invoice-revisions) for more details.\n  * `hosted_invoice_url` The URL for the hosted invoice page, which allows customers to view and pay an invoice. If the invoice has not been finalized yet, this will be null.\n  * `id` Unique identifier for the object. This property is always present unless the invoice is an upcoming invoice. See [Retrieve an upcoming invoice](https://stripe.com/docs/api/invoices/upcoming) for more details.\n  * `invoice_pdf` The link to download the PDF for the invoice. If the invoice has not been finalized yet, this will be null.\n  * `last_finalization_error` The error encountered during the previous attempt to finalize the invoice. This field is cleared when the invoice is successfully finalized.\n  * `latest_revision` The ID of the most recent non-draft revision of this invoice\n  * `lines` The individual line items that make up the invoice. `lines` is sorted as follows: (1) pending invoice items (including prorations) in reverse chronological order, (2) subscription items in reverse chronological order, and (3) invoice items added after invoice creation in chronological order.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `next_payment_attempt` The time at which payment will next be attempted. This value will be `null` for invoices where `collection_method=send_invoice`.\n  * `number` A unique, identifying string that appears on emails sent to the customer for this invoice. This starts with the customer's unique invoice_prefix if it is specified.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `on_behalf_of` The account (if any) for which the funds of the invoice payment are intended. If set, the invoice will be presented with the branding and support information of the specified account. See the [Invoices with Connect](https://stripe.com/docs/billing/invoices/connect) documentation for details.\n  * `paid` Whether payment was successfully collected for this invoice. An invoice can be paid (most commonly) with a charge or with credit from the customer's account balance.\n  * `paid_out_of_band` Returns true if the invoice was manually marked paid, returns false if the invoice hasn't been paid yet or was paid on Stripe.\n  * `payment_intent` The PaymentIntent associated with this invoice. The PaymentIntent is generated when the invoice is finalized, and can then be used to pay the invoice. Note that voiding an invoice will cancel the PaymentIntent.\n  * `payment_settings` \n  * `period_end` End of the usage period during which invoice items were added to this invoice.\n  * `period_start` Start of the usage period during which invoice items were added to this invoice.\n  * `post_payment_credit_notes_amount` Total amount of all post-payment credit notes issued for this invoice.\n  * `pre_payment_credit_notes_amount` Total amount of all pre-payment credit notes issued for this invoice.\n  * `quote` The quote this invoice was generated from.\n  * `receipt_number` This is the transaction number that appears on email receipts sent for this invoice.\n  * `rendering` The rendering-related settings that control how the invoice is displayed on customer-facing surfaces such as PDF and Hosted Invoice Page.\n  * `rendering_options` This is a legacy field that will be removed soon. For details about `rendering_options`, refer to `rendering` instead. Options for invoice PDF rendering.\n  * `shipping_cost` The details of the cost of shipping, including the ShippingRate applied on the invoice.\n  * `shipping_details` Shipping details for the invoice. The Invoice PDF will use the `shipping_details` value if it is set, otherwise the PDF will render the shipping address from the customer.\n  * `starting_balance` Starting customer balance before the invoice is finalized. If the invoice has not been finalized yet, this will be the current customer balance. For revision invoices, this also includes any customer balance that was applied to the original invoice.\n  * `statement_descriptor` Extra information about an invoice for the customer's credit card statement.\n  * `status` The status of the invoice, one of `draft`, `open`, `paid`, `uncollectible`, or `void`. [Learn more](https://stripe.com/docs/billing/invoices/workflow#workflow-overview)\n  * `status_transitions` \n  * `subscription` The subscription that this invoice was prepared for, if any.\n  * `subscription_details` Details about the subscription that created this invoice.\n  * `subscription_proration_date` Only set for upcoming invoices that preview prorations. The time used to calculate prorations.\n  * `subtotal` Total of all subscriptions, invoice items, and prorations on the invoice before any invoice level discount or exclusive tax is applied. Item discounts are already incorporated\n  * `subtotal_excluding_tax` The integer amount in cents (or local equivalent) representing the subtotal of the invoice before any invoice level discount or tax is applied. Item discounts are already incorporated\n  * `tax` The amount of tax on this invoice. This is the sum of all the tax amounts on this invoice.\n  * `test_clock` ID of the test clock this invoice belongs to.\n  * `threshold_reason` \n  * `total` Total after discounts and taxes.\n  * `total_discount_amounts` The aggregate amounts calculated per discount across all line items.\n  * `total_excluding_tax` The integer amount in cents (or local equivalent) representing the total amount of the invoice including all discounts but excluding all tax.\n  * `total_tax_amounts` The aggregate amounts calculated per tax rate for all line items.\n  * `transfer_data` The account (if any) the payment will be attributed to for tax reporting, and where funds from the payment will be transferred to for the invoice.\n  * `webhooks_delivered_at` Invoices are automatically paid or sent 1 hour after webhooks are delivered, or until all webhook delivery attempts have [been exhausted](https://stripe.com/docs/billing/webhooks#understand). This field tracks the time when webhooks for this invoice were successfully delivered. If the invoice had no webhooks to deliver, this will be set while the invoice is being created.\n"
    @type t :: %__MODULE__{
            account_country: binary | nil,
            account_name: binary | nil,
            account_tax_ids: term | nil,
            amount_due: integer,
            amount_paid: integer,
            amount_remaining: integer,
            amount_shipping: integer,
            application: (binary | term | term) | nil,
            application_fee_amount: integer | nil,
            attempt_count: integer,
            attempted: boolean,
            auto_advance: boolean,
            automatic_tax: term,
            billing_reason: binary | nil,
            charge: (binary | Stripe.Charge.t()) | nil,
            collection_method: binary,
            created: integer,
            currency: binary,
            custom_fields: term | nil,
            customer: (binary | Stripe.Customer.t() | Stripe.DeletedCustomer.t()) | nil,
            customer_address: term | nil,
            customer_email: binary | nil,
            customer_name: binary | nil,
            customer_phone: binary | nil,
            customer_shipping: term | nil,
            customer_tax_exempt: binary | nil,
            customer_tax_ids: term | nil,
            default_payment_method: (binary | Stripe.PaymentMethod.t()) | nil,
            default_source: (binary | Stripe.PaymentSource.t()) | nil,
            default_tax_rates: term,
            description: binary | nil,
            discount: term | nil,
            discounts: term | nil,
            due_date: integer | nil,
            effective_at: integer | nil,
            ending_balance: integer | nil,
            footer: binary | nil,
            from_invoice: term | nil,
            hosted_invoice_url: binary | nil,
            id: binary,
            invoice_pdf: binary | nil,
            last_finalization_error: Stripe.ApiErrors.t() | nil,
            latest_revision: (binary | Stripe.Invoice.t()) | nil,
            lines: term,
            livemode: boolean,
            metadata: term | nil,
            next_payment_attempt: integer | nil,
            number: binary | nil,
            object: binary,
            on_behalf_of: (binary | Stripe.Account.t()) | nil,
            paid: boolean,
            paid_out_of_band: boolean,
            payment_intent: (binary | Stripe.PaymentIntent.t()) | nil,
            payment_settings: term,
            period_end: integer,
            period_start: integer,
            post_payment_credit_notes_amount: integer,
            pre_payment_credit_notes_amount: integer,
            quote: (binary | Stripe.Quote.t()) | nil,
            receipt_number: binary | nil,
            rendering: term | nil,
            rendering_options: term | nil,
            shipping_cost: term | nil,
            shipping_details: term | nil,
            starting_balance: integer,
            statement_descriptor: binary | nil,
            status: binary | nil,
            status_transitions: term,
            subscription: (binary | Stripe.Subscription.t()) | nil,
            subscription_details: term | nil,
            subscription_proration_date: integer,
            subtotal: integer,
            subtotal_excluding_tax: integer | nil,
            tax: integer | nil,
            test_clock: (binary | Stripe.TestHelpers.TestClock.t()) | nil,
            threshold_reason: term,
            total: integer,
            total_discount_amounts: term | nil,
            total_excluding_tax: integer | nil,
            total_tax_amounts: term,
            transfer_data: term | nil,
            webhooks_delivered_at: integer | nil
          }
  )

  (
    @typedoc nil
    @type acss_debit :: %{
            optional(:mandate_options) => mandate_options,
            optional(:verification_method) => :automatic | :instant | :microdeposits
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
    @typedoc nil
    @type automatic_tax :: %{optional(:enabled) => boolean}
  )

  (
    @typedoc nil
    @type bancontact :: %{optional(:preferred_language) => :de | :en | :fr | :nl}
  )

  (
    @typedoc "Configuration for the bank transfer funding type, if the `funding_type` is set to `bank_transfer`."
    @type bank_transfer :: %{
            optional(:eu_bank_transfer) => eu_bank_transfer,
            optional(:type) => binary
          }
  )

  (
    @typedoc nil
    @type billing_thresholds :: %{optional(:usage_gte) => integer}
  )

  (
    @typedoc nil
    @type card :: %{
            optional(:installments) => installments,
            optional(:request_three_d_secure) => :any | :automatic
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
    @typedoc nil
    @type customer_balance :: %{
            optional(:bank_transfer) => bank_transfer,
            optional(:funding_type) => binary
          }
  )

  (
    @typedoc nil
    @type customer_details :: %{
            optional(:address) => address | binary,
            optional(:shipping) => shipping | binary,
            optional(:tax) => tax,
            optional(:tax_exempt) => :exempt | :none | :reverse,
            optional(:tax_ids) => list(tax_ids)
          }
  )

  (
    @typedoc "The estimated range for how long shipping will take, meant to be displayable to the customer. This will appear on CheckoutSessions."
    @type delivery_estimate :: %{optional(:maximum) => maximum, optional(:minimum) => minimum}
  )

  (
    @typedoc nil
    @type discounts :: %{optional(:coupon) => binary, optional(:discount) => binary}
  )

  (
    @typedoc nil
    @type due_date :: %{
            optional(:gt) => integer,
            optional(:gte) => integer,
            optional(:lt) => integer,
            optional(:lte) => integer
          }
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
            optional(:prefetch) => list(:balances | :transactions)
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
    @typedoc "Revise an existing invoice. The new invoice will be created in `status=draft`. See the [revision documentation](https://stripe.com/docs/invoicing/invoice-revisions) for more details."
    @type from_invoice :: %{optional(:action) => :revision, optional(:invoice) => binary}
  )

  (
    @typedoc "Installment configuration for payments attempted on this invoice (Mexico Only).\n\nFor more information, see the [installments integration guide](https://stripe.com/docs/payments/installments)."
    @type installments :: %{optional(:enabled) => boolean, optional(:plan) => plan | binary}
  )

  (
    @typedoc nil
    @type invoice_items :: %{
            optional(:amount) => integer,
            optional(:currency) => binary,
            optional(:description) => binary,
            optional(:discountable) => boolean,
            optional(:discounts) => list(discounts) | binary,
            optional(:invoiceitem) => binary,
            optional(:metadata) => %{optional(binary) => binary} | binary,
            optional(:period) => period,
            optional(:price) => binary,
            optional(:price_data) => price_data,
            optional(:quantity) => integer,
            optional(:tax_behavior) => :exclusive | :inclusive | :unspecified,
            optional(:tax_code) => binary | binary,
            optional(:tax_rates) => list(binary) | binary,
            optional(:unit_amount) => integer,
            optional(:unit_amount_decimal) => binary
          }
  )

  (
    @typedoc "Additional fields for Mandate creation"
    @type mandate_options :: %{optional(:transaction_type) => :business | :personal}
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
    @typedoc "Payment-method-specific configuration to provide to the invoice’s PaymentIntent."
    @type payment_method_options :: %{
            optional(:acss_debit) => acss_debit | binary,
            optional(:bancontact) => bancontact | binary,
            optional(:card) => card | binary,
            optional(:customer_balance) => customer_balance | binary,
            optional(:konbini) => map() | binary,
            optional(:us_bank_account) => us_bank_account | binary
          }
  )

  (
    @typedoc "Configuration settings for the PaymentIntent that is generated when the invoice is finalized."
    @type payment_settings :: %{
            optional(:default_mandate) => binary | binary,
            optional(:payment_method_options) => payment_method_options,
            optional(:payment_method_types) =>
              list(
                :ach_credit_transfer
                | :ach_debit
                | :acss_debit
                | :au_becs_debit
                | :bacs_debit
                | :bancontact
                | :boleto
                | :card
                | :cashapp
                | :customer_balance
                | :fpx
                | :giropay
                | :grabpay
                | :ideal
                | :konbini
                | :link
                | :paynow
                | :paypal
                | :promptpay
                | :sepa_credit_transfer
                | :sepa_debit
                | :sofort
                | :us_bank_account
                | :wechat_pay
              )
              | binary
          }
  )

  (
    @typedoc "Invoice pdf rendering options"
    @type pdf :: %{optional(:page_size) => :a4 | :auto | :letter}
  )

  (
    @typedoc "The period associated with this invoice item. When set to different values, the period will be rendered on the invoice. If you have [Stripe Revenue Recognition](https://stripe.com/docs/revenue-recognition) enabled, the period will be used to recognize and defer revenue. See the [Revenue Recognition documentation](https://stripe.com/docs/revenue-recognition/methodology/subscriptions-and-invoicing) for details."
    @type period :: %{optional(:end) => integer, optional(:start) => integer}
  )

  (
    @typedoc nil
    @type plan :: %{
            optional(:count) => integer,
            optional(:interval) => :month,
            optional(:type) => :fixed_count
          }
  )

  (
    @typedoc "Data used to generate a new [Price](https://stripe.com/docs/api/prices) object inline."
    @type price_data :: %{
            optional(:currency) => binary,
            optional(:product) => binary,
            optional(:recurring) => recurring,
            optional(:tax_behavior) => :exclusive | :inclusive | :unspecified,
            optional(:unit_amount) => integer,
            optional(:unit_amount_decimal) => binary
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
    @typedoc "The rendering-related settings that control how the invoice is displayed on customer-facing surfaces such as PDF and Hosted Invoice Page."
    @type rendering :: %{
            optional(:amount_tax_display) => :exclude_tax | :include_inclusive_tax,
            optional(:pdf) => pdf
          }
  )

  (
    @typedoc nil
    @type rendering_options :: %{
            optional(:amount_tax_display) => :exclude_tax | :include_inclusive_tax
          }
  )

  (
    @typedoc nil
    @type shipping :: %{
            optional(:address) => address,
            optional(:name) => binary,
            optional(:phone) => binary
          }
  )

  (
    @typedoc nil
    @type shipping_cost :: %{
            optional(:shipping_rate) => binary,
            optional(:shipping_rate_data) => shipping_rate_data
          }
  )

  (
    @typedoc nil
    @type shipping_details :: %{
            optional(:address) => address,
            optional(:name) => binary,
            optional(:phone) => binary | binary
          }
  )

  (
    @typedoc "Parameters to create a new ad-hoc shipping rate for this order."
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
    @typedoc nil
    @type subscription_items :: %{
            optional(:billing_thresholds) => billing_thresholds | binary,
            optional(:clear_usage) => boolean,
            optional(:deleted) => boolean,
            optional(:id) => binary,
            optional(:metadata) => %{optional(binary) => binary} | binary,
            optional(:plan) => binary,
            optional(:price) => binary,
            optional(:price_data) => price_data,
            optional(:quantity) => integer,
            optional(:tax_rates) => list(binary) | binary
          }
  )

  (
    @typedoc "Tax details about the customer."
    @type tax :: %{optional(:ip_address) => binary | binary}
  )

  (
    @typedoc nil
    @type tax_ids :: %{
            optional(:type) =>
              :ad_nrt
              | :ae_trn
              | :ar_cuit
              | :au_abn
              | :au_arn
              | :bg_uic
              | :bo_tin
              | :br_cnpj
              | :br_cpf
              | :ca_bn
              | :ca_gst_hst
              | :ca_pst_bc
              | :ca_pst_mb
              | :ca_pst_sk
              | :ca_qst
              | :ch_vat
              | :cl_tin
              | :cn_tin
              | :co_nit
              | :cr_tin
              | :do_rcn
              | :ec_ruc
              | :eg_tin
              | :es_cif
              | :eu_oss_vat
              | :eu_vat
              | :gb_vat
              | :ge_vat
              | :hk_br
              | :hu_tin
              | :id_npwp
              | :il_vat
              | :in_gst
              | :is_vat
              | :jp_cn
              | :jp_rn
              | :jp_trn
              | :ke_pin
              | :kr_brn
              | :li_uid
              | :mx_rfc
              | :my_frp
              | :my_itn
              | :my_sst
              | :no_vat
              | :nz_gst
              | :pe_ruc
              | :ph_tin
              | :ro_tin
              | :rs_pib
              | :ru_inn
              | :ru_kpp
              | :sa_vat
              | :sg_gst
              | :sg_uen
              | :si_tin
              | :sv_nit
              | :th_vat
              | :tr_tin
              | :tw_vat
              | :ua_vat
              | :us_ein
              | :uy_ruc
              | :ve_rif
              | :vn_tin
              | :za_vat,
            optional(:value) => binary
          }
  )

  (
    @typedoc nil
    @type transfer_data :: %{optional(:amount) => integer, optional(:destination) => binary}
  )

  (
    @typedoc nil
    @type us_bank_account :: %{
            optional(:financial_connections) => financial_connections,
            optional(:verification_method) => :automatic | :instant | :microdeposits
          }
  )

  (
    nil

    @doc "<p>Search for invoices you’ve previously created using Stripe’s <a href=\"/docs/search#search-query-language\">Search Query Language</a>.\nDon’t use search in read-after-write flows where strict consistency is necessary. Under normal operating\nconditions, data is searchable in less than a minute. Occasionally, propagation of new or updated data can be up\nto an hour behind during outages. Search functionality is not available to merchants in India.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/invoices/search`\n"
    (
      @spec search(
              params :: %{
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:page) => binary,
                optional(:query) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.SearchResult.t(Stripe.Invoice.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def search(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/invoices/search", [], [])

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

    @doc "<p>At any time, you can preview the upcoming invoice for a customer. This will show you all the charges that are pending, including subscription renewal charges, invoice item charges, etc. It will also show you any discounts that are applicable to the invoice.</p>\n\n<p>Note that when you are viewing an upcoming invoice, you are simply viewing a preview – the invoice has not yet been created. As such, the upcoming invoice will not show up in invoice listing calls, and you cannot use the API to pay or edit the invoice. If you want to change the amount that your customer will be billed, you can add, remove, or update pending invoice items, or update the customer’s discount.</p>\n\n<p>You can preview the effects of updating a subscription, including a preview of what proration will take place. To ensure that the actual proration is calculated exactly the same as the previewed proration, you should pass a <code>proration_date</code> parameter when doing the actual subscription update. The value passed in should be the same as the <code>subscription_proration_date</code> returned on the upcoming invoice resource. The recommended way to get only the prorations being previewed is to consider only proration line items where <code>period[start]</code> is equal to the <code>subscription_proration_date</code> on the upcoming invoice resource.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/invoices/upcoming`\n"
    (
      @spec upcoming(
              params :: %{
                optional(:automatic_tax) => automatic_tax,
                optional(:coupon) => binary,
                optional(:currency) => binary,
                optional(:customer) => binary,
                optional(:customer_details) => customer_details,
                optional(:discounts) => list(discounts) | binary,
                optional(:expand) => list(binary),
                optional(:invoice_items) => list(invoice_items),
                optional(:schedule) => binary,
                optional(:subscription) => binary,
                optional(:subscription_billing_cycle_anchor) => (:now | :unchanged) | integer,
                optional(:subscription_cancel_at) => integer | binary,
                optional(:subscription_cancel_at_period_end) => boolean,
                optional(:subscription_cancel_now) => boolean,
                optional(:subscription_default_tax_rates) => list(binary) | binary,
                optional(:subscription_items) => list(subscription_items),
                optional(:subscription_proration_behavior) =>
                  :always_invoice | :create_prorations | :none,
                optional(:subscription_proration_date) => integer,
                optional(:subscription_resume_at) => :now,
                optional(:subscription_start_date) => integer,
                optional(:subscription_trial_end) => :now | integer,
                optional(:subscription_trial_from_plan) => boolean
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Invoice.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def upcoming(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/invoices/upcoming", [], [])

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

    @doc "<p>Draft invoices are fully editable. Once an invoice is <a href=\"/docs/billing/invoices/workflow#finalized\">finalized</a>,\nmonetary values, as well as <code>collection_method</code>, become uneditable.</p>\n\n<p>If you would like to stop the Stripe Billing engine from automatically finalizing, reattempting payments on,\nsending reminders for, or <a href=\"/docs/billing/invoices/reconciliation\">automatically reconciling</a> invoices, pass\n<code>auto_advance=false</code>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/invoices/{invoice}`\n"
    (
      @spec update(
              invoice :: binary(),
              params :: %{
                optional(:account_tax_ids) => list(binary) | binary,
                optional(:application_fee_amount) => integer,
                optional(:auto_advance) => boolean,
                optional(:automatic_tax) => automatic_tax,
                optional(:collection_method) => :charge_automatically | :send_invoice,
                optional(:custom_fields) => list(custom_fields) | binary,
                optional(:days_until_due) => integer,
                optional(:default_payment_method) => binary,
                optional(:default_source) => binary | binary,
                optional(:default_tax_rates) => list(binary) | binary,
                optional(:description) => binary,
                optional(:discounts) => list(discounts) | binary,
                optional(:due_date) => integer,
                optional(:effective_at) => integer | binary,
                optional(:expand) => list(binary),
                optional(:footer) => binary,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:on_behalf_of) => binary | binary,
                optional(:payment_settings) => payment_settings,
                optional(:rendering) => rendering,
                optional(:rendering_options) => rendering_options | binary,
                optional(:shipping_cost) => shipping_cost | binary,
                optional(:shipping_details) => shipping_details | binary,
                optional(:statement_descriptor) => binary,
                optional(:transfer_data) => transfer_data | binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Invoice.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(invoice, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/invoices/{invoice}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "invoice",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "invoice",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [invoice]
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

    @doc "<p>Stripe automatically creates and then attempts to collect payment on invoices for customers on subscriptions according to your <a href=\"https://dashboard.stripe.com/account/billing/automatic\">subscriptions settings</a>. However, if you’d like to attempt payment on an invoice out of the normal collection schedule or for some other reason, you can do so.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/invoices/{invoice}/pay`\n"
    (
      @spec pay(
              invoice :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:forgive) => boolean,
                optional(:mandate) => binary | binary,
                optional(:off_session) => boolean,
                optional(:paid_out_of_band) => boolean,
                optional(:payment_method) => binary,
                optional(:source) => binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Invoice.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def pay(invoice, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/invoices/{invoice}/pay",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "invoice",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "invoice",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [invoice]
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

    @doc "<p>When retrieving an upcoming invoice, you’ll get a <strong>lines</strong> property containing the total count of line items and the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/invoices/upcoming/lines`\n"
    (
      @spec upcoming_lines(
              params :: %{
                optional(:automatic_tax) => automatic_tax,
                optional(:coupon) => binary,
                optional(:currency) => binary,
                optional(:customer) => binary,
                optional(:customer_details) => customer_details,
                optional(:discounts) => list(discounts) | binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:invoice_items) => list(invoice_items),
                optional(:limit) => integer,
                optional(:schedule) => binary,
                optional(:starting_after) => binary,
                optional(:subscription) => binary,
                optional(:subscription_billing_cycle_anchor) => (:now | :unchanged) | integer,
                optional(:subscription_cancel_at) => integer | binary,
                optional(:subscription_cancel_at_period_end) => boolean,
                optional(:subscription_cancel_now) => boolean,
                optional(:subscription_default_tax_rates) => list(binary) | binary,
                optional(:subscription_items) => list(subscription_items),
                optional(:subscription_proration_behavior) =>
                  :always_invoice | :create_prorations | :none,
                optional(:subscription_proration_date) => integer,
                optional(:subscription_resume_at) => :now,
                optional(:subscription_start_date) => integer,
                optional(:subscription_trial_end) => :now | integer,
                optional(:subscription_trial_from_plan) => boolean
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.LineItem.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def upcoming_lines(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/invoices/upcoming/lines", [], [])

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

    @doc "<p>This endpoint creates a draft invoice for a given customer. The invoice remains a draft until you <a href=\"#finalize_invoice\">finalize</a> the invoice, which allows you to <a href=\"#pay_invoice\">pay</a> or <a href=\"#send_invoice\">send</a> the invoice to your customers.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/invoices`\n"
    (
      @spec create(
              params :: %{
                optional(:account_tax_ids) => list(binary) | binary,
                optional(:application_fee_amount) => integer,
                optional(:auto_advance) => boolean,
                optional(:automatic_tax) => automatic_tax,
                optional(:collection_method) => :charge_automatically | :send_invoice,
                optional(:currency) => binary,
                optional(:custom_fields) => list(custom_fields) | binary,
                optional(:customer) => binary,
                optional(:days_until_due) => integer,
                optional(:default_payment_method) => binary,
                optional(:default_source) => binary,
                optional(:default_tax_rates) => list(binary),
                optional(:description) => binary,
                optional(:discounts) => list(discounts) | binary,
                optional(:due_date) => integer,
                optional(:effective_at) => integer,
                optional(:expand) => list(binary),
                optional(:footer) => binary,
                optional(:from_invoice) => from_invoice,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:on_behalf_of) => binary,
                optional(:payment_settings) => payment_settings,
                optional(:pending_invoice_items_behavior) =>
                  :exclude | :include | :include_and_require,
                optional(:rendering) => rendering,
                optional(:rendering_options) => rendering_options | binary,
                optional(:shipping_cost) => shipping_cost,
                optional(:shipping_details) => shipping_details,
                optional(:statement_descriptor) => binary,
                optional(:subscription) => binary,
                optional(:transfer_data) => transfer_data
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Invoice.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/invoices", [], [])

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

    @doc "<p>You can list all invoices, or list the invoices for a specific customer. The invoices are returned sorted by creation date, with the most recently created invoices appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/invoices`\n"
    (
      @spec list(
              params :: %{
                optional(:collection_method) => :charge_automatically | :send_invoice,
                optional(:created) => created | integer,
                optional(:customer) => binary,
                optional(:due_date) => due_date | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:status) => :draft | :open | :paid | :uncollectible | :void,
                optional(:subscription) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Invoice.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/invoices", [], [])

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

    @doc "<p>Retrieves the invoice with the given ID.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/invoices/{invoice}`\n"
    (
      @spec retrieve(
              invoice :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Invoice.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(invoice, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/invoices/{invoice}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "invoice",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "invoice",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [invoice]
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

    @doc "<p>Permanently deletes a one-off invoice draft. This cannot be undone. Attempts to delete invoices that are no longer in a draft state will fail; once an invoice has been finalized or if an invoice is for a subscription, it must be <a href=\"#void_invoice\">voided</a>.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/invoices/{invoice}`\n"
    (
      @spec delete(invoice :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedInvoice.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def delete(invoice, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/invoices/{invoice}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "invoice",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "invoice",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [invoice]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Stripe automatically finalizes drafts before sending and attempting payment on invoices. However, if you’d like to finalize a draft invoice manually, you can do so using this method.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/invoices/{invoice}/finalize`\n"
    (
      @spec finalize_invoice(
              invoice :: binary(),
              params :: %{optional(:auto_advance) => boolean, optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Invoice.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def finalize_invoice(invoice, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/invoices/{invoice}/finalize",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "invoice",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "invoice",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [invoice]
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

    @doc "<p>Stripe will automatically send invoices to customers according to your <a href=\"https://dashboard.stripe.com/account/billing/automatic\">subscriptions settings</a>. However, if you’d like to manually send an invoice to your customer out of the normal schedule, you can do so. When sending invoices that have already been paid, there will be no reference to the payment in the email.</p>\n\n<p>Requests made in test-mode result in no emails being sent, despite sending an <code>invoice.sent</code> event.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/invoices/{invoice}/send`\n"
    (
      @spec send_invoice(
              invoice :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Invoice.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def send_invoice(invoice, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/invoices/{invoice}/send",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "invoice",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "invoice",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [invoice]
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

    @doc "<p>Marking an invoice as uncollectible is useful for keeping track of bad debts that can be written off for accounting purposes.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/invoices/{invoice}/mark_uncollectible`\n"
    (
      @spec mark_uncollectible(
              invoice :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Invoice.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def mark_uncollectible(invoice, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/invoices/{invoice}/mark_uncollectible",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "invoice",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "invoice",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [invoice]
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

    @doc "<p>Mark a finalized invoice as void. This cannot be undone. Voiding an invoice is similar to <a href=\"#delete_invoice\">deletion</a>, however it only applies to finalized invoices and maintains a papertrail where the invoice can still be found.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/invoices/{invoice}/void`\n"
    (
      @spec void_invoice(
              invoice :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Invoice.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def void_invoice(invoice, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/invoices/{invoice}/void",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "invoice",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "invoice",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [invoice]
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

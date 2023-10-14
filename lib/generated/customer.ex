defmodule Stripe.Customer do
  use Stripe.Entity

  @moduledoc "This object represents a customer of your business. Use it to create recurring charges and track payments that belong to the same customer.\n\nRelated guide: [Save a card during payment](https://stripe.com/docs/payments/save-during-payment)"
  (
    defstruct [
      :address,
      :balance,
      :cash_balance,
      :created,
      :currency,
      :default_source,
      :delinquent,
      :description,
      :discount,
      :email,
      :id,
      :invoice_credit_balance,
      :invoice_prefix,
      :invoice_settings,
      :livemode,
      :metadata,
      :name,
      :next_invoice_sequence,
      :object,
      :phone,
      :preferred_locales,
      :shipping,
      :sources,
      :subscriptions,
      :tax,
      :tax_exempt,
      :tax_ids,
      :test_clock
    ]

    @typedoc "The `customer` type.\n\n  * `address` The customer's address.\n  * `balance` The current balance, if any, that's stored on the customer. If negative, the customer has credit to apply to their next invoice. If positive, the customer has an amount owed that's added to their next invoice. The balance only considers amounts that Stripe hasn't successfully applied to any invoice. It doesn't reflect unpaid invoices. This balance is only taken into account after invoices finalize.\n  * `cash_balance` The current funds being held by Stripe on behalf of the customer. You can apply these funds towards payment intents when the source is \"cash_balance\". The `settings[reconciliation_mode]` field describes if these funds apply to these payment intents manually or automatically.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO code for the currency](https://stripe.com/docs/currencies) the customer can be charged in for recurring billing purposes.\n  * `default_source` ID of the default payment source for the customer.\n\nIf you use payment methods created through the PaymentMethods API, see the [invoice_settings.default_payment_method](https://stripe.com/docs/api/customers/object#customer_object-invoice_settings-default_payment_method) field instead.\n  * `delinquent` Tracks the most recent state change on any invoice belonging to the customer. Paying an invoice or marking it uncollectible via the API will set this field to false. An automatic payment failure or passing the `invoice.due_date` will set this field to `true`.\n\nIf an invoice becomes uncollectible by [dunning](https://stripe.com/docs/billing/automatic-collection), `delinquent` doesn't reset to `false`.\n\nIf you care whether the customer has paid their most recent subscription invoice, use `subscription.status` instead. Paying or marking uncollectible any customer invoice regardless of whether it is the latest invoice for a subscription will always set this field to `false`.\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users.\n  * `discount` Describes the current discount active on the customer, if there is one.\n  * `email` The customer's email address.\n  * `id` Unique identifier for the object.\n  * `invoice_credit_balance` The current multi-currency balances, if any, that's stored on the customer. If positive in a currency, the customer has a credit to apply to their next invoice denominated in that currency. If negative, the customer has an amount owed that's added to their next invoice denominated in that currency. These balances don't apply to unpaid invoices. They solely track amounts that Stripe hasn't successfully applied to any invoice. Stripe only applies a balance in a specific currency to an invoice after that invoice (which is in the same currency) finalizes.\n  * `invoice_prefix` The prefix for the customer used to generate unique invoice numbers.\n  * `invoice_settings` \n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `name` The customer's full name or business name.\n  * `next_invoice_sequence` The suffix of the customer's next invoice number (for example, 0001).\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `phone` The customer's phone number.\n  * `preferred_locales` The customer's preferred locales (languages), ordered by preference.\n  * `shipping` Mailing and shipping address for the customer. Appears on invoices emailed to this customer.\n  * `sources` The customer's payment sources, if any.\n  * `subscriptions` The customer's current subscriptions, if any.\n  * `tax` \n  * `tax_exempt` Describes the customer's tax exemption status, which is `none`, `exempt`, or `reverse`. When set to `reverse`, invoice and receipt PDFs include the following text: **\"Reverse charge\"**.\n  * `tax_ids` The customer's tax IDs.\n  * `test_clock` ID of the test clock that this customer belongs to.\n"
    @type t :: %__MODULE__{
            address: term | nil,
            balance: integer,
            cash_balance: Stripe.CashBalance.t() | nil,
            created: integer,
            currency: binary | nil,
            default_source: (binary | Stripe.PaymentSource.t()) | nil,
            delinquent: boolean | nil,
            description: binary | nil,
            discount: term | nil,
            email: binary | nil,
            id: binary,
            invoice_credit_balance: term,
            invoice_prefix: binary | nil,
            invoice_settings: term,
            livemode: boolean,
            metadata: term,
            name: binary | nil,
            next_invoice_sequence: integer,
            object: binary,
            phone: binary | nil,
            preferred_locales: term | nil,
            shipping: term | nil,
            sources: term,
            subscriptions: term,
            tax: term,
            tax_exempt: binary | nil,
            tax_ids: term,
            test_clock: (binary | Stripe.TestHelpers.TestClock.t()) | nil
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
    @typedoc "Additional parameters for `bank_transfer` funding types"
    @type bank_transfer :: %{
            optional(:eu_bank_transfer) => eu_bank_transfer,
            optional(:requested_address_types) => list(:iban | :sort_code | :spei | :zengin),
            optional(:type) =>
              :eu_bank_transfer
              | :gb_bank_transfer
              | :jp_bank_transfer
              | :mx_bank_transfer
              | :us_bank_transfer
          }
  )

  (
    @typedoc "Balance information and default balance settings for this customer."
    @type cash_balance :: %{optional(:settings) => settings}
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
    @typedoc "Configuration for eu_bank_transfer funding type."
    @type eu_bank_transfer :: %{optional(:country) => binary}
  )

  (
    @typedoc "Default invoice settings for this customer."
    @type invoice_settings :: %{
            optional(:custom_fields) => list(custom_fields) | binary,
            optional(:default_payment_method) => binary,
            optional(:footer) => binary,
            optional(:rendering_options) => rendering_options | binary
          }
  )

  (
    @typedoc nil
    @type rendering_options :: %{
            optional(:amount_tax_display) => :exclude_tax | :include_inclusive_tax
          }
  )

  (
    @typedoc "Settings controlling the behavior of the customer's cash balance,\nsuch as reconciliation of funds received."
    @type settings :: %{
            optional(:reconciliation_mode) => :automatic | :manual | :merchant_default
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
    @typedoc "Tax details about the customer."
    @type tax :: %{optional(:ip_address) => binary | binary}
  )

  (
    @typedoc nil
    @type tax_id_data :: %{
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
    nil

    @doc "<p>Search for customers you’ve previously created using Stripe’s <a href=\"/docs/search#search-query-language\">Search Query Language</a>.\nDon’t use search in read-after-write flows where strict consistency is necessary. Under normal operating\nconditions, data is searchable in less than a minute. Occasionally, propagation of new or updated data can be up\nto an hour behind during outages. Search functionality is not available to merchants in India.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/customers/search`\n"
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
              {:ok, Stripe.SearchResult.t(Stripe.Customer.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def search(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/customers/search", [], [])

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

    @doc "<p>Returns a list of your customers. The customers are returned sorted by creation date, with the most recent customers appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/customers`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:email) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:test_clock) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Customer.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/customers", [], [])

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

    @doc "<p>Creates a new customer object.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/customers`\n"
    (
      @spec create(
              params :: %{
                optional(:address) => address | binary,
                optional(:balance) => integer,
                optional(:cash_balance) => cash_balance,
                optional(:coupon) => binary,
                optional(:description) => binary,
                optional(:email) => binary,
                optional(:expand) => list(binary),
                optional(:invoice_prefix) => binary,
                optional(:invoice_settings) => invoice_settings,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:name) => binary,
                optional(:next_invoice_sequence) => integer,
                optional(:payment_method) => binary,
                optional(:phone) => binary,
                optional(:preferred_locales) => list(binary),
                optional(:promotion_code) => binary,
                optional(:shipping) => shipping | binary,
                optional(:source) => binary,
                optional(:tax) => tax,
                optional(:tax_exempt) => :exempt | :none | :reverse,
                optional(:tax_id_data) => list(tax_id_data),
                optional(:test_clock) => binary,
                optional(:validate) => boolean
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Customer.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/customers", [], [])

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

    @doc "<p>Retrieves a Customer object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/customers/{customer}`\n"
    (
      @spec retrieve(
              customer :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Customer.t() | Stripe.DeletedCustomer.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(customer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [customer]
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

    @doc "<p>Updates the specified customer by setting the values of the parameters passed. Any parameters not provided will be left unchanged. For example, if you pass the <strong>source</strong> parameter, that becomes the customer’s active source (e.g., a card) to be used for all charges in the future. When you update a customer to a new valid card source by passing the <strong>source</strong> parameter: for each of the customer’s current subscriptions, if the subscription bills automatically and is in the <code>past_due</code> state, then the latest open invoice for the subscription with automatic collection enabled will be retried. This retry will not count as an automatic retry, and will not affect the next regularly scheduled payment for the invoice. Changing the <strong>default_source</strong> for a customer will not trigger this behavior.</p>\n\n<p>This request accepts mostly the same arguments as the customer creation call.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/customers/{customer}`\n"
    (
      @spec update(
              customer :: binary(),
              params :: %{
                optional(:address) => address | binary,
                optional(:balance) => integer,
                optional(:cash_balance) => cash_balance,
                optional(:coupon) => binary,
                optional(:default_source) => binary,
                optional(:description) => binary,
                optional(:email) => binary,
                optional(:expand) => list(binary),
                optional(:invoice_prefix) => binary,
                optional(:invoice_settings) => invoice_settings,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:name) => binary,
                optional(:next_invoice_sequence) => integer,
                optional(:phone) => binary,
                optional(:preferred_locales) => list(binary),
                optional(:promotion_code) => binary,
                optional(:shipping) => shipping | binary,
                optional(:source) => binary,
                optional(:tax) => tax,
                optional(:tax_exempt) => :exempt | :none | :reverse,
                optional(:validate) => boolean
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Customer.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(customer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [customer]
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

    @doc "<p>Permanently deletes a customer. It cannot be undone. Also immediately cancels any active subscriptions on the customer.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/customers/{customer}`\n"
    (
      @spec delete(customer :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedCustomer.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def delete(customer, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [customer]
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

    @doc "<p>Returns a list of PaymentMethods for a given Customer</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/customers/{customer}/payment_methods`\n"
    (
      @spec list_payment_methods(
              customer :: binary(),
              params :: %{
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
      def list_payment_methods(customer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/payment_methods",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [customer]
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

    @doc "<p>Retrieves a PaymentMethod object for a given Customer.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/customers/{customer}/payment_methods/{payment_method}`\n"
    (
      @spec retrieve_payment_method(
              customer :: binary(),
              payment_method :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PaymentMethod.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve_payment_method(customer, payment_method, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/payment_methods/{payment_method}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              },
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
            [customer, payment_method]
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

    @doc "<p>Returns a list of transactions that updated the customer’s <a href=\"/docs/billing/customer/balance\">balances</a>.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/customers/{customer}/balance_transactions`\n"
    (
      @spec balance_transactions(
              customer :: binary(),
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.CustomerBalanceTransaction.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def balance_transactions(customer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/balance_transactions",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [customer]
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

    @doc "<p>Create an incoming testmode bank transfer</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/customers/{customer}/fund_cash_balance`\n"
    (
      @spec fund_cash_balance(
              customer :: binary(),
              params :: %{
                optional(:amount) => integer,
                optional(:currency) => binary,
                optional(:expand) => list(binary),
                optional(:reference) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.CustomerCashBalanceTransaction.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def fund_cash_balance(customer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/customers/{customer}/fund_cash_balance",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [customer]
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

    @doc "<p>Retrieve funding instructions for a customer cash balance. If funding instructions do not yet exist for the customer, new\nfunding instructions will be created. If funding instructions have already been created for a given customer, the same\nfunding instructions will be retrieved. In other words, we will return the same funding instructions each time.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/customers/{customer}/funding_instructions`\n"
    (
      @spec create_funding_instructions(
              customer :: binary(),
              params :: %{
                optional(:bank_transfer) => bank_transfer,
                optional(:currency) => binary,
                optional(:expand) => list(binary),
                optional(:funding_type) => :bank_transfer
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.FundingInstructions.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create_funding_instructions(customer, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/funding_instructions",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [customer]
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

    @doc "<p>Removes the currently applied discount on a customer.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/customers/{customer}/discount`\n"
    (
      @spec delete_discount(customer :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedDiscount.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def delete_discount(customer, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/customers/{customer}/discount",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "customer",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "customer",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [customer]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )
end

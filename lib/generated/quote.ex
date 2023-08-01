defmodule Stripe.Quote do
  use Stripe.Entity

  @moduledoc "A Quote is a way to model prices that you'd like to provide to a customer.\nOnce accepted, it will automatically create an invoice, subscription or subscription schedule."
  (
    defstruct [
      :default_tax_rates,
      :id,
      :transfer_data,
      :application_fee_amount,
      :number,
      :from_quote,
      :status,
      :subscription,
      :amount_total,
      :amount_subtotal,
      :discounts,
      :created,
      :currency,
      :automatic_tax,
      :test_clock,
      :status_transitions,
      :expires_at,
      :total_details,
      :invoice_settings,
      :object,
      :application,
      :invoice,
      :customer,
      :on_behalf_of,
      :subscription_schedule,
      :header,
      :footer,
      :description,
      :subscription_data,
      :metadata,
      :line_items,
      :collection_method,
      :livemode,
      :computed,
      :application_fee_percent
    ]

    @typedoc "The `quote` type.\n\n  * `amount_subtotal` Total before any discounts or taxes are applied.\n  * `amount_total` Total after discounts and taxes are applied.\n  * `application` ID of the Connect Application that created the quote.\n  * `application_fee_amount` The amount of the application fee (if any) that will be requested to be applied to the payment and transferred to the application owner's Stripe account. Only applicable if there are no line items with recurring prices on the quote.\n  * `application_fee_percent` A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice total that will be transferred to the application owner's Stripe account. Only applicable if there are line items with recurring prices on the quote.\n  * `automatic_tax` \n  * `collection_method` Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay invoices at the end of the subscription cycle or on finalization using the default payment method attached to the subscription or customer. When sending an invoice, Stripe will email your customer an invoice with payment instructions and mark the subscription as `active`. Defaults to `charge_automatically`.\n  * `computed` \n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `customer` The customer which this quote belongs to. A customer is required before finalizing the quote. Once specified, it cannot be changed.\n  * `default_tax_rates` The tax rates applied to this quote.\n  * `description` A description that will be displayed on the quote PDF.\n  * `discounts` The discounts applied to this quote.\n  * `expires_at` The date on which the quote will be canceled if in `open` or `draft` status. Measured in seconds since the Unix epoch.\n  * `footer` A footer that will be displayed on the quote PDF.\n  * `from_quote` Details of the quote that was cloned. See the [cloning documentation](https://stripe.com/docs/quotes/clone) for more details.\n  * `header` A header that will be displayed on the quote PDF.\n  * `id` Unique identifier for the object.\n  * `invoice` The invoice that was created from this quote.\n  * `invoice_settings` All invoices will be billed using the specified settings.\n  * `line_items` A list of items the customer is being quoted for.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `number` A unique number that identifies this particular quote. This number is assigned once the quote is [finalized](https://stripe.com/docs/quotes/overview#finalize).\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `on_behalf_of` The account on behalf of which to charge. See the [Connect documentation](https://support.stripe.com/questions/sending-invoices-on-behalf-of-connected-accounts) for details.\n  * `status` The status of the quote.\n  * `status_transitions` \n  * `subscription` The subscription that was created or updated from this quote.\n  * `subscription_data` \n  * `subscription_schedule` The subscription schedule that was created or updated from this quote.\n  * `test_clock` ID of the test clock this quote belongs to.\n  * `total_details` \n  * `transfer_data` The account (if any) the payments will be attributed to for tax reporting, and where funds from each payment will be transferred to for each of the invoices.\n"
    @type t :: %__MODULE__{
            amount_subtotal: integer,
            amount_total: integer,
            application: (binary | term | term) | nil,
            application_fee_amount: integer | nil,
            application_fee_percent: term | nil,
            automatic_tax: term,
            collection_method: binary,
            computed: term,
            created: integer,
            currency: binary | nil,
            customer: (binary | Stripe.Customer.t() | Stripe.DeletedCustomer.t()) | nil,
            default_tax_rates: term,
            description: binary | nil,
            discounts: term,
            expires_at: integer,
            footer: binary | nil,
            from_quote: term | nil,
            header: binary | nil,
            id: binary,
            invoice: (binary | Stripe.Invoice.t() | Stripe.DeletedInvoice.t()) | nil,
            invoice_settings: term | nil,
            line_items: term,
            livemode: boolean,
            metadata: term,
            number: binary | nil,
            object: binary,
            on_behalf_of: (binary | Stripe.Account.t()) | nil,
            status: binary,
            status_transitions: term,
            subscription: (binary | Stripe.Subscription.t()) | nil,
            subscription_data: term,
            subscription_schedule: (binary | Stripe.SubscriptionSchedule.t()) | nil,
            test_clock: (binary | Stripe.TestHelpers.TestClock.t()) | nil,
            total_details: term,
            transfer_data: term | nil
          }
  )

  (
    @typedoc "Settings for automatic tax lookup for this quote and resulting invoices and subscriptions."
    @type automatic_tax :: %{optional(:enabled) => boolean}
  )

  (
    @typedoc nil
    @type discounts :: %{optional(:coupon) => binary, optional(:discount) => binary}
  )

  (
    @typedoc "Clone an existing quote. The new quote will be created in `status=draft`. When using this parameter, you cannot specify any other parameters except for `expires_at`."
    @type from_quote :: %{optional(:is_revision) => boolean, optional(:quote) => binary}
  )

  (
    @typedoc "All invoices will be billed using the specified settings."
    @type invoice_settings :: %{optional(:days_until_due) => integer}
  )

  (
    @typedoc nil
    @type line_items :: %{
            optional(:price) => binary,
            optional(:price_data) => price_data,
            optional(:quantity) => integer,
            optional(:tax_rates) => list(binary) | binary
          }
  )

  (
    @typedoc "Data used to generate a new [Price](https://stripe.com/docs/api/prices) object inline. One of `price` or `price_data` is required."
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
    @typedoc "When creating a subscription or subscription schedule, the specified configuration data will be used. There must be at least one line item with a recurring price for a subscription or subscription schedule to be created. A subscription schedule is created if `subscription_data[effective_date]` is present and in the future, otherwise a subscription is created."
    @type subscription_data :: %{
            optional(:description) => binary,
            optional(:effective_date) => :current_period_end | integer | binary,
            optional(:trial_period_days) => integer | binary
          }
  )

  (
    @typedoc nil
    @type transfer_data :: %{
            optional(:amount) => integer,
            optional(:amount_percent) => number,
            optional(:destination) => binary
          }
  )

  (
    nil

    @doc "<p>Retrieves the quote with the given ID.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/quotes/{quote}`\n"
    (
      @spec retrieve(
              quote :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Quote.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(quote, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/quotes/{quote}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "quote",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "quote",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [quote]
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

    @doc "<p>A quote models prices and services for a customer. Default options for <code>header</code>, <code>description</code>, <code>footer</code>, and <code>expires_at</code> can be set in the dashboard via the <a href=\"https://dashboard.stripe.com/settings/billing/quote\">quote template</a>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/quotes`\n"
    (
      @spec create(
              params :: %{
                optional(:application_fee_amount) => integer | binary,
                optional(:application_fee_percent) => number | binary,
                optional(:automatic_tax) => automatic_tax,
                optional(:collection_method) => :charge_automatically | :send_invoice,
                optional(:customer) => binary,
                optional(:default_tax_rates) => list(binary) | binary,
                optional(:description) => binary,
                optional(:discounts) => list(discounts) | binary,
                optional(:expand) => list(binary),
                optional(:expires_at) => integer,
                optional(:footer) => binary,
                optional(:from_quote) => from_quote,
                optional(:header) => binary,
                optional(:invoice_settings) => invoice_settings,
                optional(:line_items) => list(line_items),
                optional(:metadata) => %{optional(binary) => binary},
                optional(:on_behalf_of) => binary | binary,
                optional(:subscription_data) => subscription_data,
                optional(:test_clock) => binary,
                optional(:transfer_data) => transfer_data | binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Quote.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/quotes", [], [])

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

    @doc "<p>A quote models prices and services for a customer.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/quotes/{quote}`\n"
    (
      @spec update(
              quote :: binary(),
              params :: %{
                optional(:application_fee_amount) => integer | binary,
                optional(:application_fee_percent) => number | binary,
                optional(:automatic_tax) => automatic_tax,
                optional(:collection_method) => :charge_automatically | :send_invoice,
                optional(:customer) => binary,
                optional(:default_tax_rates) => list(binary) | binary,
                optional(:description) => binary,
                optional(:discounts) => list(discounts) | binary,
                optional(:expand) => list(binary),
                optional(:expires_at) => integer,
                optional(:footer) => binary,
                optional(:header) => binary,
                optional(:invoice_settings) => invoice_settings,
                optional(:line_items) => list(line_items),
                optional(:metadata) => %{optional(binary) => binary},
                optional(:on_behalf_of) => binary | binary,
                optional(:subscription_data) => subscription_data,
                optional(:transfer_data) => transfer_data | binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Quote.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(quote, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/quotes/{quote}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "quote",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "quote",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [quote]
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

    @doc "<p>Cancels the quote.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/quotes/{quote}/cancel`\n"
    (
      @spec cancel(
              quote :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Quote.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def cancel(quote, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/quotes/{quote}/cancel",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "quote",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "quote",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [quote]
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

    @doc "<p>Finalizes the quote.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/quotes/{quote}/finalize`\n"
    (
      @spec finalize_quote(
              quote :: binary(),
              params :: %{optional(:expand) => list(binary), optional(:expires_at) => integer},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Quote.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def finalize_quote(quote, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/quotes/{quote}/finalize",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "quote",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "quote",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [quote]
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

    @doc "<p>Accepts the specified quote.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/quotes/{quote}/accept`\n"
    (
      @spec accept(
              quote :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Quote.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def accept(quote, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/quotes/{quote}/accept",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "quote",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "quote",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [quote]
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

    @doc "<p>Returns a list of your quotes.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/quotes`\n"
    (
      @spec list(
              params :: %{
                optional(:customer) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:status) => :accepted | :canceled | :draft | :open,
                optional(:test_clock) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Quote.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/quotes", [], [])

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

    @doc "<p>When retrieving a quote, there is an includable <strong>line_items</strong> property containing the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/quotes/{quote}/line_items`\n"
    (
      @spec list_line_items(
              quote :: binary(),
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
      def list_line_items(quote, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/quotes/{quote}/line_items",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "quote",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "quote",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [quote]
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

    @doc "<p>When retrieving a quote, there is an includable <a href=\"https://stripe.com/docs/api/quotes/object#quote_object-computed-upfront-line_items\"><strong>computed.upfront.line_items</strong></a> property containing the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of upfront line items.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/quotes/{quote}/computed_upfront_line_items`\n"
    (
      @spec list_computed_upfront_line_items(
              quote :: binary(),
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
      def list_computed_upfront_line_items(quote, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/quotes/{quote}/computed_upfront_line_items",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "quote",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "quote",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [quote]
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

    @doc "<p>Download the PDF for a finalized quote</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/quotes/{quote}/pdf`\n"
    (
      @spec pdf(
              quote :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, []} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def pdf(quote, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/quotes/{quote}/pdf",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "quote",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "quote",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [quote]
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

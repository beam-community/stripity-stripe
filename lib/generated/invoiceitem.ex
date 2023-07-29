defmodule Stripe.Invoiceitem do
  use Stripe.Entity

  @moduledoc "Invoice Items represent the component lines of an [invoice](https://stripe.com/docs/api/invoices). An invoice item is added to an\ninvoice by creating or updating it with an `invoice` field, at which point it will be included as\n[an invoice line item](https://stripe.com/docs/api/invoices/line_item) within\n[invoice.lines](https://stripe.com/docs/api/invoices/object#invoice_object-lines).\n\nInvoice Items can be created before you are ready to actually send the invoice. This can be particularly useful when combined\nwith a [subscription](https://stripe.com/docs/api/subscriptions). Sometimes you want to add a charge or credit to a customer, but actually charge\nor credit the customer’s card only at the end of a regular billing cycle. This is useful for combining several charges\n(to minimize per-transaction fees), or for having Stripe tabulate your usage-based billing totals.\n\nRelated guides: [Integrate with the Invoicing API](https://stripe.com/docs/invoicing/integration), [Subscription Invoices](https://stripe.com/docs/billing/invoices/subscription#adding-upcoming-invoice-items)."
  (
    defstruct [
      :amount,
      :currency,
      :customer,
      :date,
      :description,
      :discountable,
      :discounts,
      :id,
      :invoice,
      :livemode,
      :metadata,
      :object,
      :period,
      :plan,
      :price,
      :proration,
      :quantity,
      :subscription,
      :subscription_item,
      :tax_rates,
      :test_clock,
      :unit_amount,
      :unit_amount_decimal
    ]

    @typedoc "The `invoiceitem` type.\n\n  * `amount` Amount (in the `currency` specified) of the invoice item. This should always be equal to `unit_amount * quantity`.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `customer` The ID of the customer who will be billed when this invoice item is billed.\n  * `date` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users.\n  * `discountable` If true, discounts will apply to this invoice item. Always false for prorations.\n  * `discounts` The discounts which apply to the invoice item. Item discounts are applied before invoice discounts. Use `expand[]=discounts` to expand each discount.\n  * `id` Unique identifier for the object.\n  * `invoice` The ID of the invoice this invoice item belongs to.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `period` \n  * `plan` If the invoice item is a proration, the plan of the subscription that the proration was computed for.\n  * `price` The price of the invoice item.\n  * `proration` Whether the invoice item was created automatically as a proration adjustment when the customer switched plans.\n  * `quantity` Quantity of units for the invoice item. If the invoice item is a proration, the quantity of the subscription that the proration was computed for.\n  * `subscription` The subscription that this invoice item has been created for, if any.\n  * `subscription_item` The subscription item that this invoice item has been created for, if any.\n  * `tax_rates` The tax rates which apply to the invoice item. When set, the `default_tax_rates` on the invoice do not apply to this invoice item.\n  * `test_clock` ID of the test clock this invoice item belongs to.\n  * `unit_amount` Unit amount (in the `currency` specified) of the invoice item.\n  * `unit_amount_decimal` Same as `unit_amount`, but contains a decimal value with at most 12 decimal places.\n"
    @type t :: %__MODULE__{
            amount: integer,
            currency: binary,
            customer: binary | Stripe.Customer.t() | Stripe.DeletedCustomer.t(),
            date: integer,
            description: binary | nil,
            discountable: boolean,
            discounts: term | nil,
            id: binary,
            invoice: (binary | Stripe.Invoice.t()) | nil,
            livemode: boolean,
            metadata: term | nil,
            object: binary,
            period: term,
            plan: Stripe.Plan.t() | nil,
            price: Stripe.Price.t() | nil,
            proration: boolean,
            quantity: integer,
            subscription: (binary | Stripe.Subscription.t()) | nil,
            subscription_item: binary,
            tax_rates: term | nil,
            test_clock: (binary | Stripe.TestHelpers.TestClock.t()) | nil,
            unit_amount: integer | nil,
            unit_amount_decimal: binary | nil
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
    @type discounts :: %{optional(:coupon) => binary, optional(:discount) => binary}
  )

  (
    @typedoc "The period associated with this invoice item. When set to different values, the period will be rendered on the invoice. If you have [Stripe Revenue Recognition](https://stripe.com/docs/revenue-recognition) enabled, the period will be used to recognize and defer revenue. See the [Revenue Recognition documentation](https://stripe.com/docs/revenue-recognition/methodology/subscriptions-and-invoicing) for details."
    @type period :: %{optional(:end) => integer, optional(:start) => integer}
  )

  (
    @typedoc "Data used to generate a new [Price](https://stripe.com/docs/api/prices) object inline."
    @type price_data :: %{
            optional(:currency) => binary,
            optional(:product) => binary,
            optional(:tax_behavior) => :exclusive | :inclusive | :unspecified,
            optional(:unit_amount) => integer,
            optional(:unit_amount_decimal) => binary
          }
  )

  (
    nil

    @doc "<p>Returns a list of your invoice items. Invoice items are returned sorted by creation date, with the most recently created invoice items appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/invoiceitems`\n"
    (
      @spec list(
              params :: %{
                optional(:created) => created | integer,
                optional(:customer) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:invoice) => binary,
                optional(:limit) => integer,
                optional(:pending) => boolean,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Invoiceitem.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/invoiceitems", [], [])

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

    @doc "<p>Creates an item to be added to a draft invoice (up to 250 items per invoice). If no invoice is specified, the item will be on the next invoice created for the customer specified.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/invoiceitems`\n"
    (
      @spec create(
              params :: %{
                optional(:amount) => integer,
                optional(:currency) => binary,
                optional(:customer) => binary,
                optional(:description) => binary,
                optional(:discountable) => boolean,
                optional(:discounts) => list(discounts) | binary,
                optional(:expand) => list(binary),
                optional(:invoice) => binary,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:period) => period,
                optional(:price) => binary,
                optional(:price_data) => price_data,
                optional(:quantity) => integer,
                optional(:subscription) => binary,
                optional(:tax_behavior) => :exclusive | :inclusive | :unspecified,
                optional(:tax_code) => binary | binary,
                optional(:tax_rates) => list(binary),
                optional(:unit_amount) => integer,
                optional(:unit_amount_decimal) => binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Invoiceitem.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/invoiceitems", [], [])

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

    @doc "<p>Retrieves the invoice item with the given ID.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/invoiceitems/{invoiceitem}`\n"
    (
      @spec retrieve(
              invoiceitem :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Invoiceitem.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(invoiceitem, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/invoiceitems/{invoiceitem}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "invoiceitem",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "invoiceitem",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [invoiceitem]
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

    @doc "<p>Updates the amount or description of an invoice item on an upcoming invoice. Updating an invoice item is only possible before the invoice it’s attached to is closed.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/invoiceitems/{invoiceitem}`\n"
    (
      @spec update(
              invoiceitem :: binary(),
              params :: %{
                optional(:amount) => integer,
                optional(:description) => binary,
                optional(:discountable) => boolean,
                optional(:discounts) => list(discounts) | binary,
                optional(:expand) => list(binary),
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
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Invoiceitem.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(invoiceitem, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/invoiceitems/{invoiceitem}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "invoiceitem",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "invoiceitem",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [invoiceitem]
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

    @doc "<p>Deletes an invoice item, removing it from an invoice. Deleting invoice items is only possible when they’re not attached to invoices, or if it’s attached to a draft invoice.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/invoiceitems/{invoiceitem}`\n"
    (
      @spec delete(invoiceitem :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedInvoiceitem.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def delete(invoiceitem, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/invoiceitems/{invoiceitem}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "invoiceitem",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "invoiceitem",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [invoiceitem]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )
end

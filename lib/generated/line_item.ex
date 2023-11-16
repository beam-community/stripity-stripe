defmodule Stripe.LineItem do
  use Stripe.Entity
  @moduledoc ""
  (
    defstruct [
      :amount,
      :amount_excluding_tax,
      :currency,
      :description,
      :discount_amounts,
      :discountable,
      :discounts,
      :id,
      :invoice_item,
      :livemode,
      :metadata,
      :object,
      :period,
      :plan,
      :price,
      :proration,
      :proration_details,
      :quantity,
      :subscription,
      :subscription_item,
      :tax_amounts,
      :tax_rates,
      :type,
      :unit_amount_excluding_tax
    ]

    @typedoc "The `line_item` type.\n\n  * `amount` The amount, in cents (or local equivalent).\n  * `amount_excluding_tax` The integer amount in cents (or local equivalent) representing the amount for this line item, excluding all tax and discounts.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users.\n  * `discount_amounts` The amount of discount calculated per discount for this line item.\n  * `discountable` If true, discounts will apply to this line item. Always false for prorations.\n  * `discounts` The discounts applied to the invoice line item. Line item discounts are applied before invoice discounts. Use `expand[]=discounts` to expand each discount.\n  * `id` Unique identifier for the object.\n  * `invoice_item` The ID of the [invoice item](https://stripe.com/docs/api/invoiceitems) associated with this line item if any.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Note that for line items with `type=subscription` this will reflect the metadata of the subscription that caused the line item to be created.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `period` \n  * `plan` The plan of the subscription, if the line item is a subscription or a proration.\n  * `price` The price of the line item.\n  * `proration` Whether this is a proration.\n  * `proration_details` Additional details for proration line items\n  * `quantity` The quantity of the subscription, if the line item is a subscription or a proration.\n  * `subscription` The subscription that the invoice item pertains to, if any.\n  * `subscription_item` The subscription item that generated this line item. Left empty if the line item is not an explicit result of a subscription.\n  * `tax_amounts` The amount of tax calculated per tax rate for this line item\n  * `tax_rates` The tax rates which apply to the line item.\n  * `type` A string identifying the type of the source of this line item, either an `invoiceitem` or a `subscription`.\n  * `unit_amount_excluding_tax` The amount in cents (or local equivalent) representing the unit amount for this line item, excluding all tax and discounts.\n"
    @type t :: %__MODULE__{
            amount: integer,
            amount_excluding_tax: integer | nil,
            currency: binary,
            description: binary | nil,
            discount_amounts: term | nil,
            discountable: boolean,
            discounts: term | nil,
            id: binary,
            invoice_item: binary | Stripe.Invoiceitem.t(),
            livemode: boolean,
            metadata: term,
            object: binary,
            period: term,
            plan: Stripe.Plan.t() | nil,
            price: Stripe.Price.t() | nil,
            proration: boolean,
            proration_details: term | nil,
            quantity: integer | nil,
            subscription: (binary | Stripe.Subscription.t()) | nil,
            subscription_item: binary | Stripe.SubscriptionItem.t(),
            tax_amounts: term,
            tax_rates: term,
            type: binary,
            unit_amount_excluding_tax: binary | nil
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
            optional(:product_data) => product_data,
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
    @typedoc nil
    @type tax_amounts :: %{
            optional(:amount) => integer,
            optional(:tax_rate_data) => tax_rate_data,
            optional(:taxable_amount) => integer
          }
  )

  (
    @typedoc "Data to find or create a TaxRate object.\n\nStripe automatically creates or reuses a TaxRate object for each tax amount. If the `tax_rate_data` exactly matches a previous value, Stripe will reuse the TaxRate object. TaxRate objects created automatically by Stripe are immediately archived, do not appear in the line item’s `tax_rates`, and cannot be directly added to invoices, payments, or line items."
    @type tax_rate_data :: %{
            optional(:country) => binary,
            optional(:description) => binary,
            optional(:display_name) => binary,
            optional(:inclusive) => boolean,
            optional(:jurisdiction) => binary,
            optional(:percentage) => number,
            optional(:state) => binary,
            optional(:tax_type) =>
              :amusement_tax
              | :communications_tax
              | :gst
              | :hst
              | :igst
              | :jct
              | :lease_tax
              | :pst
              | :qst
              | :rst
              | :sales_tax
              | :service_tax
              | :vat
          }
  )

  (
    nil

    @doc "<p>When retrieving an invoice, you’ll get a <strong>lines</strong> property containing the total count of line items and the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/invoices/{invoice}/lines`\n"
    (
      @spec list(
              invoice :: binary(),
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.LineItem.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(invoice, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/invoices/{invoice}/lines",
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

    @doc "<p>Updates an invoice’s line item. Some fields, such as <code>tax_amounts</code>, only live on the invoice line item,\nso they can only be updated through this endpoint. Other fields, such as <code>amount</code>, live on both the invoice\nitem and the invoice line item, so updates on this endpoint will propagate to the invoice item as well.\nUpdating an invoice’s line item is only possible before the invoice is finalized.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/invoices/{invoice}/lines/{line_item_id}`\n"
    (
      @spec update(
              invoice :: binary(),
              line_item_id :: binary(),
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
                optional(:tax_amounts) => list(tax_amounts) | binary,
                optional(:tax_rates) => list(binary) | binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.LineItem.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(invoice, line_item_id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/invoices/{invoice}/lines/{line_item_id}",
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
              },
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "line_item_id",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "line_item_id",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [invoice, line_item_id]
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

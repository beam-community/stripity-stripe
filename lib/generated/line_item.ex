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

    @typedoc "The `line_item` type.\n\n  * `amount` The amount, in %s.\n  * `amount_excluding_tax` The integer amount in %s representing the amount for this line item, excluding all tax and discounts.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users.\n  * `discount_amounts` The amount of discount calculated per discount for this line item.\n  * `discountable` If true, discounts will apply to this line item. Always false for prorations.\n  * `discounts` The discounts applied to the invoice line item. Line item discounts are applied before invoice discounts. Use `expand[]=discounts` to expand each discount.\n  * `id` Unique identifier for the object.\n  * `invoice_item` The ID of the [invoice item](https://stripe.com/docs/api/invoiceitems) associated with this line item if any.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Note that for line items with `type=subscription` this will reflect the metadata of the subscription that caused the line item to be created.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `period` \n  * `plan` The plan of the subscription, if the line item is a subscription or a proration.\n  * `price` The price of the line item.\n  * `proration` Whether this is a proration.\n  * `proration_details` Additional details for proration line items\n  * `quantity` The quantity of the subscription, if the line item is a subscription or a proration.\n  * `subscription` The subscription that the invoice item pertains to, if any.\n  * `subscription_item` The subscription item that generated this line item. Left empty if the line item is not an explicit result of a subscription.\n  * `tax_amounts` The amount of tax calculated per tax rate for this line item\n  * `tax_rates` The tax rates which apply to the line item.\n  * `type` A string identifying the type of the source of this line item, either an `invoiceitem` or a `subscription`.\n  * `unit_amount_excluding_tax` The amount in %s representing the unit amount for this line item, excluding all tax and discounts.\n"
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
end
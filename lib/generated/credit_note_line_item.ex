defmodule Stripe.CreditNoteLineItem do
  use Stripe.Entity
  @moduledoc ""
  (
    defstruct [
      :amount,
      :amount_excluding_tax,
      :description,
      :discount_amount,
      :discount_amounts,
      :id,
      :invoice_line_item,
      :livemode,
      :object,
      :quantity,
      :tax_amounts,
      :tax_rates,
      :type,
      :unit_amount,
      :unit_amount_decimal,
      :unit_amount_excluding_tax
    ]

    @typedoc "The `credit_note_line_item` type.\n\n  * `amount` The integer amount in cents (or local equivalent) representing the gross amount being credited for this line item, excluding (exclusive) tax and discounts.\n  * `amount_excluding_tax` The integer amount in cents (or local equivalent) representing the amount being credited for this line item, excluding all tax and discounts.\n  * `description` Description of the item being credited.\n  * `discount_amount` The integer amount in cents (or local equivalent) representing the discount being credited for this line item.\n  * `discount_amounts` The amount of discount calculated per discount for this line item\n  * `id` Unique identifier for the object.\n  * `invoice_line_item` ID of the invoice line item being credited\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `quantity` The number of units of product being credited.\n  * `tax_amounts` The amount of tax calculated per tax rate for this line item\n  * `tax_rates` The tax rates which apply to the line item.\n  * `type` The type of the credit note line item, one of `invoice_line_item` or `custom_line_item`. When the type is `invoice_line_item` there is an additional `invoice_line_item` property on the resource the value of which is the id of the credited line item on the invoice.\n  * `unit_amount` The cost of each unit of product being credited.\n  * `unit_amount_decimal` Same as `unit_amount`, but contains a decimal value with at most 12 decimal places.\n  * `unit_amount_excluding_tax` The amount in cents (or local equivalent) representing the unit amount being credited for this line item, excluding all tax and discounts.\n"
    @type t :: %__MODULE__{
            amount: integer,
            amount_excluding_tax: integer | nil,
            description: binary | nil,
            discount_amount: integer,
            discount_amounts: term,
            id: binary,
            invoice_line_item: binary,
            livemode: boolean,
            object: binary,
            quantity: integer | nil,
            tax_amounts: term,
            tax_rates: term,
            type: binary,
            unit_amount: integer | nil,
            unit_amount_decimal: binary | nil,
            unit_amount_excluding_tax: binary | nil
          }
  )

  (
    nil

    @doc "<p>When retrieving a credit note, you’ll get a <strong>lines</strong> property containing the the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of line items.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/credit_notes/{credit_note}/lines`\n"
    (
      @spec list(
              credit_note :: binary(),
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.CreditNoteLineItem.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(credit_note, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/credit_notes/{credit_note}/lines",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "credit_note",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "credit_note",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [credit_note]
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

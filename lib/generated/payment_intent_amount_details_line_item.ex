# credo:disable-for-this-file
defmodule Stripe.PaymentIntentAmountDetailsLineItem do
  use Stripe.Entity
  @moduledoc ""
  (
    defstruct [
      :discount_amount,
      :id,
      :object,
      :payment_method_options,
      :product_code,
      :product_name,
      :quantity,
      :tax,
      :unit_cost,
      :unit_of_measure
    ]

    @typedoc "The `payment_intent_amount_details_line_item` type.\n\n  * `discount_amount` The discount applied on this line item represented in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal). An integer greater than 0.\n\nThis field is mutually exclusive with the `amount_details[discount_amount]` field.\n  * `id` Unique identifier for the object.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `payment_method_options` Payment method-specific information for line items.\n  * `product_code` The product code of the line item, such as an SKU. Required for L3 rates. At most 12 characters long.\n  * `product_name` The product name of the line item. Required for L3 rates. At most 1024 characters long.\n\nFor Cards, this field is truncated to 26 alphanumeric characters before being sent to the card networks. For Paypal, this field is truncated to 127 characters.\n  * `quantity` The quantity of items. Required for L3 rates. An integer greater than 0.\n  * `tax` Contains information about the tax on the item.\n  * `unit_cost` The unit cost of the line item represented in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal). Required for L3 rates. An integer greater than or equal to 0.\n  * `unit_of_measure` A unit of measure for the line item, such as gallons, feet, meters, etc. Required for L3 rates. At most 12 alphanumeric characters long.\n"
    @type t :: %__MODULE__{
            discount_amount: integer | nil,
            id: binary,
            object: binary,
            payment_method_options: term | nil,
            product_code: binary | nil,
            product_name: binary,
            quantity: integer,
            tax: term | nil,
            unit_cost: integer,
            unit_of_measure: binary | nil
          }
  )

  (
    nil

    @doc "<p>Lists all LineItems of a given PaymentIntent.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/payment_intents/{intent}/amount_details_line_items`\n"
    (
      @spec list(
              intent :: binary(),
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.PaymentIntentAmountDetailsLineItem.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(intent, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/payment_intents/{intent}/amount_details_line_items",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "intent",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "intent",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [intent]
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

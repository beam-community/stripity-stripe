defmodule Stripe.Item do
  use Stripe.Entity
  @moduledoc "A line item."
  (
    defstruct [
      :amount_discount,
      :amount_subtotal,
      :amount_tax,
      :amount_total,
      :currency,
      :description,
      :discounts,
      :id,
      :object,
      :price,
      :quantity,
      :taxes
    ]

    @typedoc "The `item` type.\n\n  * `amount_discount` Total discount amount applied. If no discounts were applied, defaults to 0.\n  * `amount_subtotal` Total before any discounts or taxes are applied.\n  * `amount_tax` Total tax amount applied. If no tax was applied, defaults to 0.\n  * `amount_total` Total after discounts and taxes.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `description` An arbitrary string attached to the object. Often useful for displaying to users. Defaults to product name.\n  * `discounts` The discounts applied to the line item.\n  * `id` Unique identifier for the object.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `price` The price used to generate the line item.\n  * `quantity` The quantity of products being purchased.\n  * `taxes` The taxes applied to the line item.\n"
    @type t :: %__MODULE__{
            amount_discount: integer,
            amount_subtotal: integer,
            amount_tax: integer,
            amount_total: integer,
            currency: binary,
            description: binary,
            discounts: term,
            id: binary,
            object: binary,
            price: Stripe.Price.t() | nil,
            quantity: integer | nil,
            taxes: term
          }
  )
end
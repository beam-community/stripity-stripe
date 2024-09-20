defmodule Stripe.Tax.CalculationLineItem do
  use Stripe.Entity
  @moduledoc ""
  (
    defstruct [
      :amount,
      :amount_tax,
      :id,
      :livemode,
      :object,
      :product,
      :quantity,
      :reference,
      :tax_behavior,
      :tax_breakdown,
      :tax_code
    ]

    @typedoc "The `tax.calculation_line_item` type.\n\n  * `amount` The line item amount in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal). If `tax_behavior=inclusive`, then this amount includes taxes. Otherwise, taxes were calculated on top of this amount.\n  * `amount_tax` The amount of tax calculated for this line item, in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal).\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `product` The ID of an existing [Product](https://stripe.com/docs/api/products/object).\n  * `quantity` The number of units of the item being purchased. For reversals, this is the quantity reversed.\n  * `reference` A custom identifier for this line item.\n  * `tax_behavior` Specifies whether the `amount` includes taxes. If `tax_behavior=inclusive`, then the amount includes taxes.\n  * `tax_breakdown` Detailed account of taxes relevant to this line item.\n  * `tax_code` The [tax code](https://stripe.com/docs/tax/tax-categories) ID used for this resource.\n"
    @type t :: %__MODULE__{
            amount: integer,
            amount_tax: integer,
            id: binary,
            livemode: boolean,
            object: binary,
            product: binary | nil,
            quantity: integer,
            reference: binary | nil,
            tax_behavior: binary,
            tax_breakdown: term | nil,
            tax_code: binary
          }
  )
end

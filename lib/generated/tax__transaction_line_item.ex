defmodule Stripe.Tax.TransactionLineItem do
  use Stripe.Entity
  @moduledoc ""
  (
    defstruct [
      :amount,
      :amount_tax,
      :id,
      :livemode,
      :metadata,
      :object,
      :product,
      :quantity,
      :reference,
      :reversal,
      :tax_behavior,
      :tax_code,
      :type
    ]

    @typedoc "The `tax.transaction_line_item` type.\n\n  * `amount` The line item amount in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal). If `tax_behavior=inclusive`, then this amount includes taxes. Otherwise, taxes were calculated on top of this amount.\n  * `amount_tax` The amount of tax calculated for this line item, in the [smallest currency unit](https://stripe.com/docs/currencies#zero-decimal).\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `product` The ID of an existing [Product](https://stripe.com/docs/api/products/object).\n  * `quantity` The number of units of the item being purchased. For reversals, this is the quantity reversed.\n  * `reference` A custom identifier for this line item in the transaction.\n  * `reversal` If `type=reversal`, contains information about what was reversed.\n  * `tax_behavior` Specifies whether the `amount` includes taxes. If `tax_behavior=inclusive`, then the amount includes taxes.\n  * `tax_code` The [tax code](https://stripe.com/docs/tax/tax-categories) ID used for this resource.\n  * `type` If `reversal`, this line item reverses an earlier transaction.\n"
    @type t :: %__MODULE__{
            amount: integer,
            amount_tax: integer,
            id: binary,
            livemode: boolean,
            metadata: term | nil,
            object: binary,
            product: binary | nil,
            quantity: integer,
            reference: binary,
            reversal: term | nil,
            tax_behavior: binary,
            tax_code: binary,
            type: binary
          }
  )
end
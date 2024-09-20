defmodule Stripe.FundingInstructions do
  use Stripe.Entity

  @moduledoc "Each customer has a [`balance`](https://stripe.com/docs/api/customers/object#customer_object-balance) that is\nautomatically applied to future invoices and payments using the `customer_balance` payment method.\nCustomers can fund this balance by initiating a bank transfer to any account in the\n`financial_addresses` field.\nRelated guide: [Customer balance funding instructions](https://stripe.com/docs/payments/customer-balance/funding-instructions)"
  (
    defstruct [:bank_transfer, :currency, :funding_type, :livemode, :object]

    @typedoc "The `funding_instructions` type.\n\n  * `bank_transfer` \n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `funding_type` The `funding_type` of the returned instructions\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n"
    @type t :: %__MODULE__{
            bank_transfer: term,
            currency: binary,
            funding_type: binary,
            livemode: boolean,
            object: binary
          }
  )
end

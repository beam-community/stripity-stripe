defmodule Stripe.SourceTransaction do
  use Stripe.Entity

  @moduledoc "Some payment methods have no required amount that a customer must send.\nCustomers can be instructed to send any amount, and it can be made up of\nmultiple transactions. As such, sources can have multiple associated\ntransactions."
  (
    defstruct [
      :ach_credit_transfer,
      :amount,
      :chf_credit_transfer,
      :created,
      :currency,
      :gbp_credit_transfer,
      :id,
      :livemode,
      :object,
      :paper_check,
      :sepa_credit_transfer,
      :source,
      :status,
      :type
    ]

    @typedoc "The `source_transaction` type.\n\n  * `ach_credit_transfer` \n  * `amount` A positive integer in the smallest currency unit (that is, 100 cents for $1.00, or 1 for ¥1, Japanese Yen being a zero-decimal currency) representing the amount your customer has pushed to the receiver.\n  * `chf_credit_transfer` \n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `gbp_credit_transfer` \n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `paper_check` \n  * `sepa_credit_transfer` \n  * `source` The ID of the source this transaction is attached to.\n  * `status` The status of the transaction, one of `succeeded`, `pending`, or `failed`.\n  * `type` The type of source this transaction is attached to.\n"
    @type t :: %__MODULE__{
            ach_credit_transfer: term,
            amount: integer,
            chf_credit_transfer: term,
            created: integer,
            currency: binary,
            gbp_credit_transfer: term,
            id: binary,
            livemode: boolean,
            object: binary,
            paper_check: term,
            sepa_credit_transfer: term,
            source: binary,
            status: binary,
            type: binary
          }
  )
end
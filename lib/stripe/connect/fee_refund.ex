defmodule Stripe.FeeRefund do
  @moduledoc """
  Work with Stripe Connect application fee refunds.

  Stripe API reference: https://stripe.com/docs/api#fee_refunds

  """
  use Stripe.Entity

  @type t :: %__MODULE__{
               id: Stripe.id,
               object: String.t,
               amount: integer,
               balance_transaction: Stripe.id | Stripe.BalanceTransaction.t,
               created: Stripe.timestamp,
               currency: String.t,
               fee: Stripe.id | Stripe.ApplicationFee.t,
               metadata: %{
                 optional(String.t) => String.t
               }
             }

  defstruct [
    :id,
    :object,
    :amount,
    :balance_transaction,
    :created,
    :currency,
    :fee,
    :metadata
  ]
end

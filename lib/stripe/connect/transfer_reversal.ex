defmodule Stripe.TransferReversal do
  @moduledoc """
  Work with Stripe transfer_reversal objects.

  Stripe API reference: https://stripe.com/docs/api#transfer_reversal_object
  """

  use Stripe.Entity

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          amount: integer,
          balance_transaction: String.t() | Stripe.BalanceTransaction.t(),
          created: Stripe.timestamp(),
          currency: String.t(),
          description: boolean,
          metadata: Stripe.Types.metadata(),
          transfer: Stripe.id() | Stripe.Transfer.t()
        }

  defstruct [
    :id,
    :object,
    :amount,
    :balance_transaction,
    :created,
    :currency,
    :description,
    :metadata,
    :transfer
  ]
end

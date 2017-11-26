defmodule Stripe.Transfer do
  @moduledoc """
  Work with Stripe transfer objects.

  Stripe API reference: https://stripe.com/docs/api#transfers
  """

  use Stripe.Entity

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          amount: integer,
          amount_reversed: integer,
          balance_transaction: Stripe.id() | Stripe.BalanceTransaction.t(),
          created: Stripe.timestamp(),
          currency: String.t(),
          description: String.t(),
          destination: Stripe.id() | Stripe.Account.t(),
          destination_payment: String.t(),
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          reversals: Stripe.List.t(Stripe.TransferReversal.t()),
          reversed: boolean,
          source_transaction: Stripe.id() | Stripe.Charge.t(),
          source_type: String.t(),
          transfer_group: String.t()
        }

  defstruct [
    :id,
    :object,
    :amount,
    :amount_reversed,
    :balance_transaction,
    :created,
    :currency,
    :description,
    :destination,
    :destination_payment,
    :livemode,
    :metadata,
    :reversals,
    :reversed,
    :source_transaction,
    :source_type,
    :transfer_group
  ]
end

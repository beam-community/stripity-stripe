defmodule Stripe.ApplicationFee do
  @moduledoc """
  Work with Stripe Connect application fees.

  Stripe API reference: https://stripe.com/docs/api#application_fees
  """

  use Stripe.Entity

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          account: Stripe.id() | Stripe.Account.t(),
          amount: integer,
          amount_refunded: integer,
          application: Stripe.id(),
          balance_transaction: Stripe.id() | Stripe.BalanceTransaction.t(),
          charge: Stripe.id() | Stripe.Charge.t(),
          created: Stripe.timestamp(),
          currency: String.t(),
          livemode: boolean,
          originating_transaction: Stripe.id() | Stripe.Charge.t(),
          refunded: boolean,
          refunds: Stripe.List.of(Stripe.FeeRefund.t())
        }

  defstruct [
    :id,
    :object,
    :account,
    :amount,
    :amount_refunded,
    :application,
    :balance_transaction,
    :charge,
    :created,
    :currency,
    :livemode,
    :originating_transaction,
    :refunded,
    :refunds
  ]
end

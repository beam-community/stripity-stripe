defmodule Stripe.Payout do
  @moduledoc """
  Work with Stripe payouts.

  Stripe API reference: https://stripe.com/docs/api#payouts
  """

  use Stripe.Entity

  @type t :: %__MODULE__{
    id: Stripe.id,
    object: String.t,
    amount: integer,
    arrival_date: Stripe.timestamp,
    balance_transaction: Stripe.id | Stripe.BalanceTransaction.t | nil,
    created: Stripe.timestamp,
    currency: String.t,
    description: String.t | nil,
    destination: Stripe.id | Stripe.Card.t | Stripe.BankAccount.t | nil,
    failure_balance_transaction: Stripe.id | Stripe.BalanceTransaction.t | nil,
    failure_code: String.t | nil,
    failure_message: String.t | nil,
    livemode: boolean,
    method: String.t,
    source_type: String.t,
    statement_descriptor: String.t | nil,
    status: String.t,
    type: String.t
  }

  defstruct [
    :id,
    :object,
    :amount,
    :arrival_date,
    :balance_transaction,
    :created,
    :currency,
    :description,
    :destination,
    :failure_balance_transaction,
    :failure_code,
    :failure_message,
    :livemode,
    :method,
    :source_type,
    :statement_descriptor,
    :status,
    :type
  ]
end

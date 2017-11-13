defmodule Stripe.Payout do
  @moduledoc """
  Work with Stripe payouts.

  Stripe API reference: https://stripe.com/docs/api#payouts
  """
  use Stripe.Entity

  @type failure_code :: :account_closed | :account_frozen |
                        :bank_account_restricted | :bank_ownership_changed |
                        :could_not_process | :debit_not_authorized |
                        :insufficient_funds | :invalid_account_number |
                        :invalid_currency | :no_account | :unsupported_card |
                        atom

  @type t :: %__MODULE__{
               id: Stripe.id,
               object: String.t,
               amount: integer,
               arrival_date: Stripe.timestamp,
               balance_transaction: Stripe.id | Stripe.BalanceTransaction.t,
               created: Stripe.timestamp,
               currency: String.t,
               description: String.t,
               destination: Stripe.id | Stripe.Card.t | Stripe.BankAccount.t,
               failure_balance_transaction: Stripe.id | Stripe.BalanceTransaction.t,
               failure_code: failure_code,
               failure_message: String.t,
               livemode: boolean,
               method: :standard | :instant,
               source_type: :card | :bank_account | :bitcoin_receiver | :alipay_account,
               statement_descriptor: String.t,
               status: :paid | :pending | :in_transit | :canceled | :failed,
               type: :bank_account | :card
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

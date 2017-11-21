defmodule Stripe.BankAccount do
  @moduledoc """
  Work with Stripe bank account objects.

  Stripe API reference: https://stripe.com/docs/api#bank_accounts
  """

  use Stripe.Entity

  @type t :: %__MODULE__{
    id: Stripe.id,
    object: String.t,
    account: Stripe.id | Stripe.Account.t | nil,
    account_holder_name: String.t | nil,
    account_holder_type: String.t | nil,
    bank_name: String.t | nil,
    country: String.t,
    currency: String.t,
    customer: Stripe.id | Stripe.Customer.t | nil,
    default_for_currency: boolean | nil,
    fingerprint: String.t | nil,
    last4: String.t,
    metadata: Stripe.Types.metadata | nil,
    routing_number: String.t | nil,
    status: String.t
  }

  defstruct [
    :id,
    :object,
    :account,
    :account_holder_name,
    :account_holder_type,
    :bank_name,
    :country,
    :currency,
    :customer,
    :default_for_currency,
    :fingerprint,
    :last4,
    :metadata,
    :routing_number,
    :status
  ]
end

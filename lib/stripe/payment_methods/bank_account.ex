defmodule Stripe.BankAccount do
  @moduledoc """
  Work with Stripe bank account objects.

  Stripe API reference: https://stripe.com/docs/api#bank_accounts
  """
  use Stripe.Entity

  @type t :: %__MODULE__{
               id: Stripe.id,
               object: String.t,
               account: Stripe.id | Stripe.Account.t,
               account_holder_name: String.t,
               account_holder_type: :individual | :company,
               bank_name: String.t,
               country: String.t,
               currency: String.t,
               customer: Stripe.id | Stripe.Customer.t,
               default_for_currency: boolean,
               fingerprint: String.t,
               last4: String.t,
               metadata: %{
                 optional(String.t) => String.t
               },
               routing_number: String.t,
               status: :new | :validated | :verified | :verification_failed | :errored
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

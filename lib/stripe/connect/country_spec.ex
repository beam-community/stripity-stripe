defmodule Stripe.CountrySpec do
  @moduledoc """
  Work with the Stripe country specs API.

  Stripe API reference: https://stripe.com/docs/api#country_specs
  """
  use Stripe.Entity

  @type t :: %__MODULE__{
               id: Stripe.id,
               object: String.t,
               default_currency: String.t,
               supported_bank_account_currencies: %{
                 String.t => [String.t]
               },
               supported_payment_currencies: [String.t],
               supported_payment_methods: [Stripe.Source.source_type | :stripe],
               verification_fields: %{
                 individual: %{
                   minimum: [String.t],
                   additional: [String.t]
                 },
                 company: %{
                   minimum: [String.t],
                   additional: [String.t]
                 }
               }
             }

  defstruct [
    :id,
    :object,
    :default_currency,
    :supported_bank_account_currencies,
    :supported_payment_currencies,
    :supported_payment_methods,
    :verification_fields
  ]
end

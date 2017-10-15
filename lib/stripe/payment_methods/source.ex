defmodule Stripe.Source do
  @moduledoc """
  Work with Stripe source objects.

  Stripe API reference: https://stripe.com/docs/api#sources
  """
  use Stripe.Entity

  @type source_type :: :card | :three_d_secure | :giropay | :sepa_debit | :ideal | :sofort
  | :bancontact | :alipay | :bitcoin

  @type address :: %{
                     city: String.t,
                     country: String.t,
                     line1: String.t,
                     line2: String.t,
                     postal_code: String.t,
                     state: String.t
                   }

  @type t :: %__MODULE__{
               id: Stripe.id,
               object: String.t,
               amount: integer,
               client_secret: String.t,
               code_verification: %{
                 attempts_remaining: integer,
                 status: :pending | :succeeded | :failed
               },
               created: Stripe.timestamp,
               currency: String.t,
               flow: :redirect | :receiver | :code_verification | :none,
               livemode: boolean,
               metadata: %{
                 optional(String.t) => String.t
               },
               owner: %{
                 address: address,
                 email: String.t,
                 name: String.t,
                 phone: String.t,
                 verifired_address: address,
                 verified_email: String.t,
                 verified_name: String.t,
                 verified_phone: String.t
               },
               receiver: %{
                 address: String.t,
                 amount_charged: integer,
                 amount_received: integer,
                 amount_returned: integer
               },
               redirect: %{
                 failure_reason: :user_abort | :declined | :processing_error,
                 return_url: String.t,
                 status: :prending | :succeeded | :not_required | :failed,
                 url: String.t
               },
               statement_descriptor: String.t,
               status: :canceled | :chargeable | :consumed | :failed | :pending,
               type: source_type,
               usage: :reusable | :single_use,
               card: map | nil,
               three_d_secure: map | nil,
               giropay: map | nil,
               sepa_debit: map | nil,
               ideal: map | nil,
               sofort: map | nil,
               bancontact: map | nil,
               alipay: map | nil,
               bitcoin: map | nil
             }
  # TODO: find out the inner structure of the type-specific fields

  defstruct [
    :id,
    :object,
    :amount,
    :client_secret,
    :code_verification,
    :created,
    :currency,
    :flow,
    :livemode,
    :metadata,
    :owner,
    :receiver,
    :redirect,
    :statement_descriptor,
    :status,
    :type,
    :usage,
    :card,
    :three_d_secure,
    :giropay,
    :sepa_debit,
    :ideal,
    :sofort,
    :bancontact,
    :alipay,
    :bitcoin
  ]
end

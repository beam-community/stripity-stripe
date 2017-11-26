defmodule Stripe.Recipient do
  @moduledoc """
  Work with Stripe recipient objects.

  Stripe API reference: https://stripe.com/docs/api#recipients
  """

  use Stripe.Entity

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          active_account:
            %{
              id: Stripe.id(),
              object: String.t(),
              account: Stripe.id(),
              account_holder_name: String.t(),
              account_holder_type: String.t(),
              bank_name: String.t(),
              country: String.t(),
              currency: String.t(),
              customer: Stripe.id(),
              default_for_currency: boolean,
              fingerprint: String.t(),
              last4: String.t(),
              metadata: Stripe.Types.metadata(),
              routing_number: String.t(),
              status: String.t()
            }
            | nil,
          cards: Stripe.List.t(Stripe.Card.t()),
          created: Stripe.timestamp(),
          default_card: Stripe.id() | Stripe.Card.t(),
          description: String.t(),
          email: String.t(),
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          migrated_to: Stripe.id() | Stripe.Account.t(),
          name: String.t(),
          rolled_back_from: String.t(),
          type: String.t()
        }

  defstruct [
    :id,
    :object,
    :active_account,
    :cards,
    :created,
    :default_card,
    :description,
    :email,
    :livemode,
    :metadata,
    :migrated_to,
    :name,
    :rolled_back_from,
    :type
  ]
end

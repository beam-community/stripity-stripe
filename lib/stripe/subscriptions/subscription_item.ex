defmodule Stripe.SubscriptionItem do
  @moduledoc """
  Work with Stripe subscription item objects.

  Stripe API reference: https://stripe.com/docs/api#subscription_items
  """

  use Stripe.Entity

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          created: Stripe.timestamp(),
          metadata: Stripe.Types.metadata(),
          plan: Stripe.Plan.t(),
          quantity: non_neg_integer
        }

  defstruct [
    :id,
    :object,
    :created,
    :metadata,
    :plan,
    :quantity
  ]
end

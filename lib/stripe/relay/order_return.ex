defmodule Stripe.OrderReturn do
  @moduledoc """
  Work with Stripe order returns.

  Stripe API reference: https://stripe.com/docs/api#order_return_object
  """

  use Stripe.Entity

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          amount: pos_integer,
          created: Stripe.timestamp(),
          currency: String.t(),
          items: Stripe.List.of(Stripe.OrderItem.t()),
          livemode: boolean,
          order: Stripe.id() | Stripe.Order.t(),
          refund: Stripe.id() | Stripe.Refund.t()
        }

  defstruct [
    :id,
    :object,
    :amount,
    :created,
    :currency,
    :items,
    :livemode,
    :order,
    :refund
  ]
end

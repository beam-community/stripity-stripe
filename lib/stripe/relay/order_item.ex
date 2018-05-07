defmodule Stripe.OrderItem do
  @moduledoc """
  Work with Stripe order items.

  Stripe API reference: https://stripe.com/docs/api#order_items
  """

  use Stripe.Entity

  @type t :: %__MODULE__{
          object: String.t(),
          amount: pos_integer,
          currency: String.t(),
          description: String.t(),
          parent: nil | Stripe.id() | Stripe.Sku.t(),
          quantity: nil | pos_integer,
          type: String.t()
        }

  defstruct [
    :object,
    :amount,
    :currency,
    :description,
    :parent,
    :quantity,
    :type
  ]
end

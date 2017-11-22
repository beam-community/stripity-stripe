defmodule Stripe.LineItem do
  @moduledoc """
  Work with Stripe (invoice) line item objects.

  Stripe API reference: https://stripe.com/docs/api/ruby#invoice_line_item_object
  """

  use Stripe.Entity

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          amount: integer,
          currency: String.t(),
          description: String.t(),
          discountable: boolean,
          livemode: boolean,
          metadata: %{
            optional(String.t()) => String.t()
          },
          period: %{
            start: Stripe.timestamp(),
            end: Stripe.timestamp()
          },
          plan: Stripe.Plan.t() | nil,
          proration: boolean,
          quantity: integer,
          subscription: Stripe.id() | nil,
          subscription_item: Stripe.id() | nil,
          type: String.t()
        }

  defstruct [
    :id,
    :object,
    :amount,
    :currency,
    :description,
    :discountable,
    :livemode,
    :metadata,
    :period,
    :plan,
    :proration,
    :quantity,
    :subscription,
    :subscription_item,
    :type
  ]
end

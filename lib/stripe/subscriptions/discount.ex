defmodule Stripe.Discount do
  @moduledoc """
  Work with Stripe discounts.

  Stripe API reference: https://stripe.com/docs/api#discounts
  """

  use Stripe.Entity

  @type t :: %__MODULE__{
          object: String.t(),
          coupon: Stripe.Coupon.t(),
          customer: Stripe.id() | Stripe.Customer.t() | nil,
          deleted: boolean | nil,
          end: Stripe.timestamp() | nil,
          start: Stripe.timestamp(),
          subscription: Stripe.id() | nil
        }

  defstruct [
    :object,
    :coupon,
    :customer,
    :deleted,
    :end,
    :start,
    :subscription
  ]
end

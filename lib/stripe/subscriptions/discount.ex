defmodule Stripe.Discount do
  @moduledoc """
  Work with Stripe discounts.

  Stripe API reference: https://stripe.com/docs/api#discounts
  """

  use Stripe.Entity

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          coupon: Stripe.Coupon.t(),
          customer: Stripe.id() | Stripe.Customer.t() | nil,
          deleted: boolean | nil,
          end: Stripe.timestamp() | nil,
          start: Stripe.timestamp(),
          subscription: Stripe.id() | nil,
          promotion_code: Stripe.id() | nil
        }

  defstruct [
    :id,
    :object,
    :coupon,
    :customer,
    :deleted,
    :end,
    :start,
    :subscription,
    :promotion_code
  ]
end

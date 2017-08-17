defmodule Stripe.LineItem do
  @moduledoc """
  Work with Stripe (invoice) line item objects.

  Stripe API reference: https://stripe.com/docs/api/ruby#invoice_line_item_object
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object,
    :amount, :currency, :description, :discountable, :livemode, :metadata,
    :period, :plan, :proration, :quantity, :subscription, :subscription_item,
    :type
  ]
end

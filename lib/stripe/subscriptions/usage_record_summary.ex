defmodule Stripe.SubscriptionItem.UsageRecordSummary do
  @moduledoc """
  Defines the Usage Record Summary Struct returned by the
  /subscription_items/:id/usage_record_summaries endpoint.

  Stripe API reference: https://stripe.com/docs/api/usage_records
  """

  use Stripe.Entity

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          invoice: Stripe.id(),
          livemode: boolean,
          period: %{
            end: Stripe.timestamp(),
            start: Stripe.timestamp()
          },
          subscription_item: Stripe.id() | Stripe.SubscriptionItem.t(),
          total_usage: integer
        }

  defstruct [
    :id,
    :object,
    :invoice,
    :livemode,
    :period,
    :subscription_item,
    :total_usage
  ]
end

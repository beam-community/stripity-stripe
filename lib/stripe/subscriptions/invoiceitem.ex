defmodule Stripe.Invoiceitem do
  @moduledoc """
  Work with Stripe invoiceitem objects.

  Stripe API reference: https://stripe.com/docs/api#invoiceitems

  Note: this module is named `Invoiceitem` and not `InvoiceItem` on purpose, to
  match the Stripe terminology of `invoiceitem`.
  """

  use Stripe.Entity

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          amount: integer,
          currency: String.t(),
          customer: Stripe.id() | Stripe.Customer.t(),
          date: Stripe.timestamp(),
          description: String.t(),
          discountable: boolean,
          invoice: Stripe.id() | Stripe.Invoice.t(),
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          period: %{
            start: Stripe.timestamp(),
            end: Stripe.timestamp()
          },
          plan: Stripe.Plan.t() | nil,
          proration: boolean,
          quantity: integer,
          subscription: Stripe.id() | Stripe.Subscription.t() | nil,
          subscription_item: Stripe.id() | Stripe.SubscriptionItem.t() | nil
        }

  defstruct [
    :id,
    :object,
    :amount,
    :currency,
    :customer,
    :date,
    :description,
    :discountable,
    :invoice,
    :livemode,
    :metadata,
    :period,
    :plan,
    :proration,
    :quantity,
    :subscription,
    :subscription_item
  ]
end

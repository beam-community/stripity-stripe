defmodule Stripe.Order do
  @moduledoc """
  Work with Stripe orders.

  Stripe API reference: https://stripe.com/docs/api#orders
  """

  use Stripe.Entity

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          amount: pos_integer,
          amount_returned: non_neg_integer,
          application: Stripe.id(),
          application_fee: non_neg_integer,
          charge: Stripe.id() | Stripe.Charge.t(),
          currency: String.t(),
          customer: Stripe.id() | Stripe.Customer.t(),
          email: String.t(),
          external_coupon_code: String.t(),
          items: Stripe.List.t(Stripe.OrderItem.t()),
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          returns: Stripe.List.t(Stripe.OrderReturn.t()),
          selected_shipping_method: String.t(),
          shipping: %{
            address: %{
              city: String.t(),
              country: String.t(),
              line1: String.t(),
              line2: String.t(),
              postal_code: String.t(),
              state: String.t()
            },
            carrier: String.t(),
            name: String.t(),
            phone: String.t(),
            tracking_number: String.t()
          },
          shipping_methods: [
            %{
              id: String.t(),
              amount: pos_integer,
              currency: String.t(),
              delivery_estimate: %{
                date: String.t(),
                earliest: String.t(),
                latest: String.t(),
                type: String.t()
              },
              description: String.t()
            }
          ],
          status: String.t(),
          status_transitions: %{
            canceled: Stripe.timestamp(),
            fulfiled: Stripe.timestamp(),
            paid: Stripe.timestamp(),
            returned: Stripe.timestamp()
          },
          updated: Stripe.timestamp(),
          upstream_id: String.t()
        }

  defstruct [
    :id,
    :object,
    :amount,
    :amount_returned,
    :application,
    :application_fee,
    :charge,
    :currency,
    :customer,
    :email,
    :external_coupon_code,
    :items,
    :livemode,
    :metadata,
    :returns,
    :selected_shipping_method,
    :shipping,
    :shipping_methods,
    :status,
    :status_transitions,
    :updated,
    :upstream_id
  ]
end

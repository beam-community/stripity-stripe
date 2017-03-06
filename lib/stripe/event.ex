defmodule Stripe.Event do
  @moduledoc """
  Work with Stripe event objects.

  You can:

  - Retrieve an event

  Does not yet render the `data` object.

  Stripe API reference: https://stripe.com/docs/api#event

  Example:

  ```
  {
    "id": "evt_19l8PQ2eZvKYlo2CQ3DppILo",
    "object": "event",
    "api_version": "2017-01-27",
    "created": 1486610148,
    "data": {
      "object": {
        "id": "in_19l6C52eZvKYlo2CpZ9qGpDQ",
        "object": "invoice",
        "amount_due": 2000,
        "application_fee": null,
        "attempt_count": 1,
        "attempted": true,
        "charge": "ch_19l8PP2eZvKYlo2CJo3S4Ka5",
        "closed": true,
        "currency": "usd",
        "customer": "cus_4YUnnAzzvuqjSD",
        "date": 1486601633,
        "description": null,
        "discount": null,
        "ending_balance": 0,
        "forgiven": false,
        "lines": {
          "object": "list",
          "data": [
            {
              "id": "sub_4YV71U6zbBC5ST",
              "object": "line_item",
              "amount": 2000,
              "currency": "usd",
              "description": null,
              "discountable": true,
              "livemode": false,
              "metadata": {
              },
              "period": {
                "start": 1486601607,
                "end": 1489020807
              },
              "plan": {
                "id": "basic",
                "object": "plan",
                "amount": 2000,
                "created": 1406589456,
                "currency": "usd",
                "interval": "month",
                "interval_count": 1,
                "livemode": false,
                "metadata": {
                },
                "name": "Amazing Gold Plan",
                "statement_descriptor": null,
                "trial_period_days": null
              },
              "proration": false,
              "quantity": 1,
              "subscription": null,
              "subscription_item": "si_18UFFz2eZvKYlo2CswZj1WNM",
              "type": "subscription"
            }
          ],
          "has_more": false,
          "total_count": 1,
          "url": "/v1/invoices/in_19l6C52eZvKYlo2CpZ9qGpDQ/lines"
        },
        "livemode": false,
        "metadata": {
        },
        "next_payment_attempt": null,
        "paid": true,
        "period_end": 1486601607,
        "period_start": 1483923207,
        "receipt_number": null,
        "starting_balance": 0,
        "statement_descriptor": null,
        "subscription": "sub_4YV71U6zbBC5ST",
        "subtotal": 2000,
        "tax": null,
        "tax_percent": null,
        "total": 2000,
        "webhooks_delivered_at": 1486606544
      },
      "previous_attributes": {
        "attempted": false,
        "charge": null,
        "closed": false,
        "ending_balance": null,
        "next_payment_attempt": 1486605233,
        "paid": false
      }
    },
    "livemode": false,
    "pending_webhooks": 0,
    "request": null,
    "type": "invoice.updated"
  }
  ```
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object,
    :api_version, :created, :data, :livemode, :pending_webhooks,
    :request, :type, :user_id
  ]

  @plural_endpoint "events"

  @doc """
  Retrieve an event.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end
end

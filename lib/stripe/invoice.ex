defmodule Stripe.Invoice do
  @moduledoc """
  Work with Stripe invoice objects.

  You can:

  - Create an invoice
  - Retrieve an invoice
  - Update an invoice

  Does not yet implement `lines`.

  Does not yet render lists or take options.

  Stripe API reference: https://stripe.com/docs/api#invoice

  Example:

  ```
  {
    "id": "in_19l8Cj2eZvKYlo2CHe6wtpmh",
    "object": "invoice",
    "amount_due": 999,
    "application_fee": null,
    "attempt_count": 0,
    "attempted": false,
    "charge": null,
    "closed": false,
    "currency": "usd",
    "customer": "cus_A5IzRTlo2DcV1J",
    "date": 1486609361,
    "description": null,
    "discount": null,
    "ending_balance": null,
    "forgiven": false,
    "lines": {
      "data": [
        {
          "id": "sub_A5GH4y0tqOZorL",
          "object": "line_item",
          "amount": 5000,
          "currency": "usd",
          "description": null,
          "discountable": true,
          "livemode": true,
          "metadata": {
          },
          "period": {
            "start": 1489019125,
            "end": 1491697525
          },
          "plan": {
            "id": "quartz-enterprise",
            "object": "plan",
            "amount": 5000,
            "created": 1486598337,
            "currency": "usd",
            "interval": "month",
            "interval_count": 1,
            "livemode": false,
            "metadata": {
            },
            "name": "Quartz enterprise",
            "statement_descriptor": null,
            "trial_period_days": null
          },
          "proration": false,
          "quantity": 1,
          "subscription": null,
          "subscription_item": "si_19l5kX2eZvKYlo2COV9VLK3B",
          "type": "subscription"
        }
      ],
      "total_count": 1,
      "object": "list",
      "url": "/v1/invoices/in_19l8Cj2eZvKYlo2CHe6wtpmh/lines"
    },
    "livemode": false,
    "metadata": {
    },
    "next_payment_attempt": 1486612961,
    "paid": false,
    "period_end": 1486609361,
    "period_start": 1483930961,
    "receipt_number": null,
    "starting_balance": 0,
    "statement_descriptor": null,
    "subscription": "sub_8yNGK3DbUFj5cI",
    "subtotal": 999,
    "tax": null,
    "tax_percent": null,
    "total": 999,
    "webhooks_delivered_at": 1486609373
  }
  ```
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object,
    :amount_due, :application_fee, :attempt_count, :attempted,
    :charge, :closed, :currency, :customer, :date, :description, :discount,
    :ending_balance, :forgiven, :livemode, :metadata,
    :next_payment_attempt, :paid, :period_end, :period_start,
    :receipt_number, :starting_balance, :statement_descriptor,
    :subscription, :subscription_proration_date, :subtotal, :tax,
    :tax_percent, :total, :webhooks_delivered_at
  ]

  @plural_endpoint "invoices"

  @doc """
  Create an invoice.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, opts)
  end

  @doc """
  Retrieve an invoice.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end

  @doc """
  Update an invoice.

  Takes the `id` and a map of changes.
  """
  @spec update(binary, map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, opts)
  end
end

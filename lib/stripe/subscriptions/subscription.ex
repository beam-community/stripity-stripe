defmodule Stripe.Subscription do
  @moduledoc """
  Work with Stripe subscription objects.

  You can:

  - Create a subscription
  - Retrieve a subscription
  - Update a subscription
  - Delete a subscription

  Does not yet render lists or take options.

  Stripe API reference: https://stripe.com/docs/api#subscription

  ```
  {
    "id": "sub_A5GH4y0tqOZorL",
    "object": "subscription",
    "application_fee_percent": null,
    "cancel_at_period_end": false,
    "canceled_at": 1486599980,
    "created": 1486599925,
    "current_period_end": 1489019125,
    "current_period_start": 1486599925,
    "customer": "cus_A5GEGcroKA82CE",
    "discount": null,
    "ended_at": 1486599980,
    "items": {
      "object": "list",
      "data": [
        {
          "id": "si_19l5kX2eZvKYlo2COV9VLK3B",
          "object": "subscription_item",
          "created": 1486599925,
          "plan": {
            "id": "gold-extended-3221748186322061931",
            "object": "plan",
            "amount": 5000,
            "created": 1486599923,
            "currency": "usd",
            "interval": "month",
            "interval_count": 1,
            "livemode": false,
            "metadata": {
            },
            "name": "Bronze complete",
            "statement_descriptor": null,
            "trial_period_days": null
          },
          "quantity": 1
        }
      ],
      "has_more": false,
      "total_count": 1,
      "url": "/v1/subscription_items?subscription=sub_A5GH4y0tqOZorL"
    },
    "livemode": false,
    "metadata": {
    },
    "plan": {
      "id": "gold-extended-3221748186322061931",
      "object": "plan",
      "amount": 5000,
      "created": 1486599923,
      "currency": "usd",
      "interval": "month",
      "interval_count": 1,
      "livemode": false,
      "metadata": {
      },
      "name": "Bronze complete",
      "statement_descriptor": null,
      "trial_period_days": null
    },
    "quantity": 1,
    "start": 1486599925,
    "status": "canceled",
    "tax_percent": null,
    "trial_end": null,
    "trial_start": null
  }
  ```
  """
  use Stripe.Entity
  import Stripe.Request
  alias Stripe.Util

  @type t :: %__MODULE__{
               id: Stripe.id,
               object: String.t,
               application_fee_percent: float | nil,
               cancel_at_period_end: boolean,
               canceled_at: Stripe.timestamp | nil,
               created: Stripe.timestamp,
               current_period_end: Stripe.timestamp,
               current_period_start: Stripe.timestamp,
               customer: Stripe.id | Stripe.Customer.t,
               discount: Stripe.Discount.t,
               ended_at: Stripe.timestamp | nil,
               items: Stripe.List.of(Stripe.SubscriptionItem.t),
               livemode: boolean,
               metadata: %{
                 optional(String.t) => String.t
               },
               plan: Stripe.Plan.t,
               quantity: integer,
               start: Stripe.timestamp,
               status: :trialing | :active | :past_due | :canceled | :unpaid,
               tax_percent: float | nil,
               trial_end: Stripe.timestamp,
               trial_start: Stripe.timestamp
             }

  defstruct [
    :id,
    :object,
    :application_fee_percent,
    :cancel_at_period_end,
    :canceled_at,
    :created,
    :current_period_end,
    :current_period_start,
    :customer,
    :discount,
    :ended_at,
    :items,
    :livemode,
    :metadata,
    :plan,
    :quantity,
    :start,
    :status,
    :tax_percent,
    :trial_end,
    :trial_start
  ]

  @plural_endpoint "subscriptions"

  @doc """
  Create a subscription.
  """
  @spec create(params, Stripe.options) :: {:ok, t} | {:error, Stripe.Error.t}
        when params: %{
               application_fee_percent: float,
               coupon: Stripe.id | Stripe.Coupon.t,
               items: [
                 %{
                   :plan => Stripe.id | Stripe.Plan.t,
                   optional(:quantity) => non_neg_integer
                 }
               ],
               metadata: %{
                 optional(String.t) => String.t
               },
               tax_percent: float,
               trial_end: Stripe.timestamp,
               trial_period_days: non_neg_integer
             }
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> cast_to_id([:coupon])
    |> make_request()
  end

  @doc """
  Retrieve a subscription.
  """
  @spec retrieve(Stripe.id | t, Stripe.options) :: {:ok, t} | {:error, Stripe.Error.t}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a subscription.

  Takes the `id` and a map of changes.
  """
  @spec update(Stripe.id | t, params, Stripe.options) :: {:ok, t} | {:error, Stripe.Error.t}
        when params: %{
               application_fee_percent: float,
               coupon: Stripe.id | Stripe.Coupon.t,
               items: [
                 %{
                   :plan => Stripe.id | Stripe.Plan.t,
                   optional(:quantity) => non_neg_integer
                 }
               ],
               metadata: %{
                 optional(String.t) => String.t
               },
               prorate: boolean,
               proration_date: Stripe.timestamp,
               source: Stripe.id | Stripe.Source.t,
               tax_percent: float,
               trial_end: Stripe.timestamp
             }
  def update(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> cast_to_id([:coupon, :source])
    |> make_request()
  end

  @doc """
  Delete a subscription.

  Takes the `id` and an optional map of `params`.
  """
  @spec delete(Stripe.id | t, Stripe.options) :: {:ok, t} | {:error, Stripe.Error.t}
  def delete(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:delete)
    |> make_request()
  end

  @doc """
  List all subscriptions.
  """
  @spec list(params, Stripe.options) :: {:ok, Stripe.List.of(t)} | {:error, Stripe.Error.t}
        when params: %{
               created: Stripe.date_query,
               customer: Stripe.Customer.t | Stripe.id,
               ending_before: t | Stripe.id,
               limit: 1..100,
               plan: Stripe.Plan.t | Stripe.id,
               starting_after: t | Stripe.id,
               status: :trialing | :active | :past_due | :canceled | :unpaid | :all
             }
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:customer, :ending_before, :plan, :starting_after])
    |> make_request()
  end

  @doc """
  Deletes the discount on a subscription.
  """
  @spec delete_discount(Stripe.id | t, Stripe.options) :: {:ok, t} | {:error, Stripe.Error.t}
  def delete_discount(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}/discount")
    |> put_method(:delete)
    |> make_request()
  end
end

defmodule Stripe.Subscription do
  @moduledoc """
  Work with Stripe subscription objects.

  You can:

  - Create a subscription
  - Retrieve a subscription
  - Update a subscription
  - Delete a subscription

  Stripe API reference: https://stripe.com/docs/api#subscription
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
    id: Stripe.id,
    object: String.t,
    application_fee_percent: float | nil,
    cancel_at_period_end: boolean,
    canceled_at: Stripe.timestamp | nil,
    created: Stripe.timestamp,
    current_period_end: Stripe.timestamp | nil,
    current_period_start: Stripe.timestamp | nil,
    customer: Stripe.id | Stripe.Customer.t,
    discount: Stripe.Discount.t | nil,
    ended_at: Stripe.timestamp | nil,
    items: Stripe.List.of(Stripe.SubscriptionItem.t),
    livemode: boolean,
    metadata: Stripe.Types.metadata,
    plan: Stripe.Plan.t | nil,
    quantity: integer | nil,
    start: Stripe.timestamp,
    status: String.t,
    tax_percent: float | nil,
    trial_end: Stripe.timestamp | nil,
    trial_start: Stripe.timestamp | nil
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
               metadata: Stripe.Types.metadata,
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
               metadata: Stripe.Types.metadata,
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
               status: String.t
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

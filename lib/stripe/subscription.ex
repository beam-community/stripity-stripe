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
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object,
    :application_fee_percent, :cancel_at_period_end, :canceled_at,
    :created, :current_period_end, :current_period_start, :customer,
    :ended_at, :livemode, :metadata, :plan, :prorate, :quantity, :source,
    :start, :status, :tax_percent, :trial_end, :trial_start
  ]

  @plural_endpoint "subscriptions"

  @schema %{
    application_fee_percent: [:create, :retrieve, :update],
    cancel_at_period_end: [:retrieve],
    canceled_at: [:retrieve],
    coupon: [:create, :update],
    created: [:retrieve],
    current_period_end: [:retrieve],
    current_period_start: [:retrieve],
    customer: [:create, :retrieve],
    discount: [:retrieve],
    ended_at: [:retrieve],
    id: [:retrieve],
    livemode: [:retrieve],
    metadata: [:create, :retrieve, :update],
    object: [:retrieve],
    plan: [:create, :retrieve, :update],
    prorate: [:create, :update],
    quantity: [:create, :retrieve, :update],
    source: [:create, :update],
    start: [:retrieve],
    status: [:retrieve],
    tax_percent: [:create, :retrieve, :update],
    trial_end: [:create, :retrieve, :update],
    trial_period_days: [:create],
    trial_start: [:create, :retrieve]
  }

  @nullable_keys [
    :metadata
  ]

  @doc """
  Create a subscription.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, @schema, opts)
  end

  @doc """
  Retrieve a subscription.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end

  @doc """
  Update a subscription.

  Takes the `id` and a map of changes.
  """
  @spec update(binary, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, @schema, @nullable_keys, opts)
  end

  @doc """
  Delete a subscription.

  Takes the `id` and an optional map of `params`.
  """
  @spec delete(binary, map, list) :: :ok | {:error, Stripe.api_error_struct}
  def delete(id, params \\ %{}, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.delete(endpoint, params, opts)
  end

  @doc """
  List all subscriptions.
  """
  @spec list(map, Keyword.t) :: {:ok, Stripe.List.t} | {:error, Stripe.api_error_struct}
  def list(params \\ %{}, opts \\ []) do
    endpoint = @plural_endpoint
    Stripe.Request.retrieve(params, endpoint, opts)
  end
end

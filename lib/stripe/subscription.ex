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
    :id, :application_fee_percent, :cancel_at_period_end, :canceled_at,
    :created, :current_period_end, :current_period_start, :customer,
    :ended_at, :livemode, :metadata, :plan, :quantity, :source,
    :start, :status, :tax_percent, :trial_end, :trial_start
  ]

  @relationships %{
    created: DateTime,
    current_period_end: DateTime,
    current_period_start: DateTime,
    ended_at: DateTime,
    plan: Stripe.Plan,
    start: DateTime,
    trial_end: DateTime,
    trial_start: DateTime
  }

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
    prorate: [:create],
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
  Returns a map of relationship keys and their Struct name.
  Relationships must be specified for the relationship to
  be returned as a struct.
  """
  @spec relationships :: Keyword.t
  def relationships, do: @relationships

  @doc """
  Create a subscription.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, @schema, __MODULE__, opts)
  end

  @doc """
  Retrieve a subscription.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, __MODULE__, opts)
  end

  @doc """
  Update a subscription.

  Takes the `id` and a map of changes.
  """
  @spec update(t, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, @schema, __MODULE__, @nullable_keys, opts)
  end

  @doc """
  Delete a subscription.
  """
  @spec delete(binary, list) :: :ok | {:error, Stripe.api_error_struct}
  def delete(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.delete(endpoint, opts)
  end
end

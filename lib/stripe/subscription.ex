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
    plan: Stripe.Plan,
    start: DateTime,
    trial_end: DateTime,
    trial_start: DateTime
  }

  @plural_endpoint "subscriptions"

  @valid_create_keys [
    :application_fee_percent, :coupon, :customer, :metadata, :plan, :quantity,
    :source, :tax_percent, :trial_end
  ]

  @valid_update_keys [
    :application_fee_percent, :coupon, :metadata, :plan, :prorate,
    :proration_date, :quantity, :source, :tax_percent, :trial_end
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
  @spec create(t, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(subscription, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, subscription, @valid_create_keys, __MODULE__, opts)
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
    Stripe.Request.update(endpoint, changes, @valid_update_keys, __MODULE__, opts)
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

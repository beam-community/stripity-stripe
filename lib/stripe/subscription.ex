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

  alias Stripe.Util

  @type t :: %__MODULE__{}
  @type stripe_response :: {:ok, t} | {:error, Exception.t}
  @type stripe_delete_response :: :ok | {:error, Exception.t}

  defstruct [
    :id, :application_fee_percent, :cancel_at_period_end, :canceled_at,
    :created, :current_period_end, :current_period_start, :customer,
    :discount, :ended_at, :livemode, :metadata, :plan, :quantity, :source,
    :start, :status, :tax_percent, :trial_end, :trial_start
  ]

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
  Create a subscription.
  """
  @spec create(t, Keyword.t) :: stripe_response
  def create(subscription, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, subscription, @valid_create_keys, %__MODULE__{}, opts)
  end

  @doc """
  Retrieve a subscription.
  """
  @spec retrieve(binary, Keyword.t) :: stripe_response
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, %__MODULE__{}, opts)
  end

  @doc """
  Update a subscription.

  Takes the `id` and a map of changes.
  """
  @spec update(t, map, list) :: stripe_response
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, @valid_update_keys, %__MODULE__{}, opts)
  end

  @doc """
  Delete a subscription.
  """
  @spec delete(binary, list) :: stripe_delete_response
  def delete(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.delete(endpoint, opts)
  end
end

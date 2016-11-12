defmodule Stripe.Customer do
  @moduledoc """
  Work with Stripe customer objects.

  You can:

  - Create a customer
  - Retrieve a customer
  - Update a customer
  - Delete a customer

  Stripe API reference: https://stripe.com/docs/api#customer
  """

  alias Stripe.Util

  @type t :: %__MODULE__{}

  defstruct [
    :id, :account_balance, :business_vat_id, :created, :currency,
    :default_source, :delinquent, :description, :discount, :email, :livemode,
    :metadata, :shipping, :sources, :subscriptions
  ]

  @plural_endpoint "customers"

  @valid_create_keys [
    :account_balance, :business_vat_id, :coupon, :description, :email,
    :metadata, :plan, :quantity, :shipping, :source, :tax_percent, :trial_end
  ]

  @valid_update_keys [
    :account_balance, :business_vat_id, :coupon, :default_source, :description,
    :email, :metadata, :shipping, :source
  ]

  @doc """
  Create a customer.
  """
  @spec create(t, Keyword.t) :: {:ok, t} | {:error, Exception.t}
  def create(customer, opts \\ []) do
    endpoint = @plural_endpoint
    Stripe.Request.create(endpoint, customer, @valid_create_keys, %__MODULE__{}, opts)
  end

  @doc """
  Retrieve a customer.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Exception.t}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, %__MODULE__{}, opts)
  end

  @doc """
  Update a customer.

  Takes the `id` and a map of changes.
  """
  @spec update(t, map, list) :: {:ok, t} | {:error, Exception.t}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, @valid_update_keys, %__MODULE__{}, opts)
  end

  @doc """
  Delete a customer.
  """
  @spec delete(binary, list) :: :ok | {:error, Exception.t}
  def delete(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.delete(endpoint, opts)
  end
end

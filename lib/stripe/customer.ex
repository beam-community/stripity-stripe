defmodule Stripe.Customer do
  @moduledoc """
  Work with Stripe customer objects.

  You can:

  - Create a customer
  - Retrieve a customer
  - Update a customer
  - Delete a customer

  Does not yet render lists or take options.

  Stripe API reference: https://stripe.com/docs/api#customer
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :account_balance, :business_vat_id, :created, :currency,
    :default_source, :delinquent, :description, :email, :livemode,
    :metadata
  ]

  @relationships %{
    created: DateTime
  }

  @plural_endpoint "customers"

  @valid_create_keys [
    :account_balance, :business_vat_id, :coupon, :description, :email,
    :metadata, :plan, :quantity, :tax_percent, :trial_end, :source
  ]

  @valid_update_keys [
    :account_balance, :business_vat_id, :coupon, :default_source, :description,
    :email, :metadata, :source
  ]

  @doc """
  Returns a map of relationship keys and their Struct name.
  Relationships must be specified for the relationship to
  be returned as a struct.
  """
  @spec relationships :: Keyword.t
  def relationships, do: @relationships

  @doc """
  Create a customer.
  """
  @spec create(t, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(customer, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, customer, @valid_create_keys, __MODULE__, opts)
  end

  @doc """
  Retrieve a customer.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, __MODULE__, opts)
  end

  @doc """
  Update a customer.

  Takes the `id` and a map of changes.
  """
  @spec update(t, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, @valid_update_keys, __MODULE__, opts)
  end

  @doc """
  Delete a customer.
  """
  @spec delete(binary, list) :: :ok | {:error, Stripe.api_error_struct}
  def delete(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.delete(endpoint, opts)
  end
end

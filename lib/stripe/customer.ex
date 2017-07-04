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
    :id, :object,
    :account_balance, :business_vat_id, :created, :currency,
    :default_source, :delinquent, :description, :discount, :email,
    :livemode, :metadata, :shipping, :sources, :subscriptions
  ]

  @plural_endpoint "customers"

  @address_map %{
    city: [:create, :retrieve, :update], #required
    country: [:create, :retrieve, :update],
    line1: [:create, :retrieve, :update],
    line2: [:create, :retrieve, :update],
    postal_code: [:create, :retrieve, :update],
    state: [:create, :retrieve, :update]
  }

  @schema %{
    account_balance: [:retrieve, :update],
    business_vat_id: [:create, :retrieve, :update],
    created: [:retrieve],
    coupon: [:create, :retrieve, :update],
    currency: [:retrieve],
    default_source: [:retrieve, :update],
    delinquent: [:retrieve],
    description: [:create, :retrieve, :update],
    discount: [:retrieve],
    email: [:create, :retrieve, :update],
    livemode: [:retrieve],
    metadata: [:create, :retrieve, :update],
    plan: [:create, :update],
    quantity: [:create, :update],
    shipping: %{
      address: @address_map
    },
    source: [:create, :retrieve, :update],
    sources: [:retrieve],
    subscriptions: [:retrieve],
    tax_percent: [:create],
    trial_end: [:create]
  }

  @nullable_keys [
    :business_vat_id, :description, :email, :metadata
  ]

  @doc """
  Create a customer.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, @schema, opts)
  end

  @doc """
  Retrieve a customer.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end

  @doc """
  Update a customer.

  Takes the `id` and a map of changes.
  """
  @spec update(binary, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, @schema, @nullable_keys, opts)
  end

  @doc """
  Delete a customer.
  """
  @spec delete(binary, list) :: :ok | {:error, Stripe.api_error_struct}
  def delete(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.delete(endpoint, %{}, opts)
  end

  @doc """
  List all customers.
  """
  @spec list(map, Keyword.t) :: {:ok, Stripe.List.t} | {:error, Stripe.api_error_struct}
  def list(params \\ %{}, opts \\ []) do
    endpoint = @plural_endpoint
    Stripe.Request.retrieve(params, endpoint, opts)
  end
end

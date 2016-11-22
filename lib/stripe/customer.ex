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

  alias Stripe.Util

  @type t :: %__MODULE__{}

  defstruct [
    :id, :account_balance, :business_vat_id, :created, :currency,
    :default_source, :delinquent, :description, :email, :livemode,
    :metadata
  ]

  @response_mapping %{
    id: :string,
    account_balance: :string,
    business_vat_id: :string,
    created: :datetime,
    currency: :string,
    default_source: :string,
    delinquent: :boolean,
    description: :string,
    email: :string,
    livemode: :boolean,
    metadata: :metadata
  }

  @plural_endpoint "customers"

  @valid_create_keys [
    :account_balance, :business_vat_id, :coupon, :description, :email,
    :metadata, :plan, :quantity, :tax_percent, :trial_end
  ]

  @valid_update_keys [
    :account_balance, :business_vat_id, :coupon, :default_source, :description,
    :email, :metadata
  ]

  @doc """
  Returns the Stripe response mapping of keys to types.
  """
  @spec response_mapping :: Keyword.t
  def response_mapping, do: @response_mapping

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

defmodule Stripe.BankAccount do
  @moduledoc """
  Work with Stripe bank_account objects.

  You can:

  - Create a bank account
  - Retrieve a bank account
  - Update a bank account
  - Delete a bank account

  Does not yet render lists or take options.

  Stripe API reference: https://stripe.com/docs/api#bank_account
  """

  alias Stripe.Util

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object, :account, :account_holder_name, :account_holder_type,
    :bank_name, :country, :currency, :default_for_currency, :fingerprint,
    :last4, :metadata, :routing_number, :status
  ]

  @response_mapping %{
    id: :string,
    object: :string,
    account: :string,
    account_holder_name: :string,
    account_holder_type: :string,
    bank_name: :string,
    country: :string,
    currency: :string,
    default_for_currency: :string,
    fingerprint: :string,
    last4: :string,
    metadata: :metadata,
    routing_number: :string,
    status: :string
  }

  @plural_endpoint "bank_accounts"

  @valid_create_keys [
    :source, :object, :account_number, :country, :currency,
    :account_holder_name, :account_holder_type, :routing_number,
    :default_for_currency, :metadata
  ]

  @valid_update_keys [
    :source, :object, :account_number, :country, :currency,
    :account_holder_name, :account_holder_type, :routing_number,
    :default_for_currency, :metadata
  ]

  @doc """
  Returns the Stripe response mapping of keys to types.
  """
  @spec response_mapping :: Keyword.t
  def response_mapping, do: @response_mapping

  @doc """
  Create a bank account.
  """
  @spec create(t, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(bank_account, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, bank_account, @valid_create_keys, __MODULE__, opts)
  end

  @doc """
  Retrieve a bank account.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, __MODULE__, opts)
  end

  @doc """
  Update a bank account.

  Takes the `id` and a map of changes.
  """
  @spec update(t, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, @valid_update_keys, __MODULE__, opts)
  end

  @doc """
  Delete a bank account.
  """
  @spec delete(binary, list) :: :ok | {:error, Stripe.api_error_struct}
  def delete(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.delete(endpoint, opts)
  end
end

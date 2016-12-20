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

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object, :account, :account_holder_name, :account_holder_type,
    :bank_name, :country, :currency, :default_for_currency, :fingerprint,
    :last4, :metadata, :routing_number, :status
  ]

  @relationships %{}

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
  Returns a map of relationship keys and their Struct name.
  Relationships must be specified for the relationship to
  be returned as a struct.
  """
  @spec relationships :: Keyword.t
  def relationships, do: @relationships

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

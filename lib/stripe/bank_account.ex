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

  @schema %{
    account: [:retrieve],
    account_number: :string,
    account_holder_name: [:retrieve, :update],
    account_holder_type: [:retrieve, :update],
    bank_name: [:retrieve],
    country: [:retrieve],
    currency: [:retrieve],
    default_for_currency: [:create, :retrieve],
    external_account: [:create],
    fingerprint: [:retrieve],
    id: [:retrieve],
    last4: [:retrieve],
    metadata: [:create, :retrieve, :update],
    object: [:retrieve],
    routing_number: [:retrieve],
    source: [:create],
    status: [:retrieve]
  }

  @nullable_keys []

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
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, @schema, __MODULE__, opts)
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
    Stripe.Request.update(endpoint, changes, @schema, __MODULE__, @nullable_keys, opts)
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

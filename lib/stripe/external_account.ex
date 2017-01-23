defmodule Stripe.ExternalAccount do
  @moduledoc """
  Work with Stripe external account objects.

  You can:

  - Create an external account
  - Retrieve an external account
  - Update an external account
  - Delete an external account

  Does not yet render lists or take options.

  Probably does not yet work for credit cards.

  Stripe API reference: https://stripe.com/docs/api#external_accounts
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object,
    :account, :account_holder_name, :account_holder_type,
    :bank_name, :country, :currency, :default_for_currency, :fingerprint,
    :last4, :metadata, :routing_number, :status
  ]

  @schema %{
    account: [:retrieve],
    account_number: [:retrieve],
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

  defp endpoint(managed_account_id) do
    "accounts/#{managed_account_id}/external_accounts"
  end

  @doc """
  Create an external account.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts = [connect_account: managed_account_id]) do
    endpoint = endpoint(managed_account_id)
    Stripe.Request.create(endpoint, changes, @schema, opts)
  end

  @doc """
  Retrieve an external account.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts = [connect_account: managed_account_id]) do
    endpoint = endpoint(managed_account_id) <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end

  @doc """
  Update an external account.

  Takes the `id` and a map of changes.
  """
  @spec update(binary, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts = [connect_account: managed_account_id]) do
    endpoint = endpoint(managed_account_id) <> "/" <> id
    Stripe.Request.update(endpoint, changes, @schema, @nullable_keys, opts)
  end

  @doc """
  Delete an external account.
  """
  @spec delete(binary, list) :: :ok | {:error, Stripe.api_error_struct}
  def delete(id, opts = [connect_account: managed_account_id]) do
    endpoint = endpoint(managed_account_id) <> "/" <> id
    Stripe.Request.delete(endpoint, opts)
  end
end

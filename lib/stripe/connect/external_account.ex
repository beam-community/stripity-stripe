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

  alias Stripe.Util

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object,
    :account, :account_holder_name, :account_holder_type,
    :bank_name, :country, :currency, :default_for_currency, :fingerprint,
    :last4, :metadata, :routing_number, :status
  ]

  defp endpoint(managed_account_id) do
    "accounts/#{managed_account_id}/external_accounts"
  end

  @doc """
  Create an external account.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts = [connect_account: managed_account_id]) do
    endpoint = endpoint(managed_account_id)
    Stripe.Request.create(endpoint, changes, opts)
  end

  @doc """
  Retrieve an external account.
  """
  @spec retrieve(String.t, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts = [connect_account: managed_account_id]) do
    endpoint = endpoint(managed_account_id) <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end

  @doc """
  Update an external account.

  Takes the `id` and a map of changes.
  """
  @spec update(String.t, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts = [connect_account: managed_account_id]) do
    endpoint = endpoint(managed_account_id) <> "/" <> id
    Stripe.Request.update(endpoint, changes, opts)
  end

  @doc """
  Delete an external account.
  """
  @spec delete(t | String.t, list) :: :ok | {:error, Stripe.api_error_struct}
  def delete(account, opts = [connect_account: managed_account_id]) do
    id = Util.normalize_id(account)
    endpoint = endpoint(managed_account_id) <> "/" <> id
    Stripe.Request.delete(endpoint, %{}, opts)
  end

  @doc """
  List all external accounts.
  """
  @spec list(map, Keyword.t) :: {:ok, Stripe.List.t} | {:error, Stripe.api_error_struct}
  def list(params \\ %{}, opts = [connect_account: managed_account_id]) do
    endpoint = endpoint(managed_account_id)
    params = Map.merge(params, %{"object" => "bank_account"})
    Stripe.Request.retrieve(params, endpoint, opts)
  end
end

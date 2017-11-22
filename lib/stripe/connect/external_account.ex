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

  defp endpoint(managed_account_id) do
    "accounts/#{managed_account_id}/external_accounts"
  end

  @type t :: Stripe.BankAccount.t() | Stripe.Card.t()

  @type create_params :: %{
          external_account:
            create_params_for_bank_account
            | create_params_for_card
            | String.t(),
          default_for_currency: boolean | nil,
          metadata: Stripe.Types.metadata() | nil
        }

  @type create_params_for_bank_account :: %{
          object: String.t(),
          account_number: String.t(),
          country: String.t(),
          currency: String.t(),
          account_holder_name: String.t() | nil,
          account_holder_type: String.t() | nil,
          routing_number: String.t() | nil
        }

  @type create_params_for_card :: %{
          object: String.t(),
          exp_month: String.t(),
          exp_year: String.t(),
          number: String.t(),
          address_city: String.t() | nil,
          address_country: String.t() | nil,
          address_line1: String.t() | nil,
          address_line2: String.t() | nil,
          address_state: String.t() | nil,
          address_zip: String.t() | nil,
          currency: String.t() | nil,
          cvc: String.t() | nil,
          default_for_currency: String.t() | nil,
          metadata: Stripe.Types.metadata() | nil,
          name: String.t() | nil
        }

  @doc """
  Create an external account.
  """
  @spec create(map, Keyword.t()) :: {:ok, t} | {:error, Stripe.api_error_struct()}
  def create(changes, opts = [connect_account: managed_account_id]) do
    endpoint = endpoint(managed_account_id)
    Stripe.Request.create(endpoint, changes, opts)
  end

  @doc """
  Retrieve an external account.
  """
  @spec retrieve(String.t(), Keyword.t()) :: {:ok, t} | {:error, Stripe.api_error_struct()}
  def retrieve(id, opts = [connect_account: managed_account_id]) do
    endpoint = endpoint(managed_account_id) <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end

  @doc """
  Update an external account.

  Takes the `id` and a map of changes.
  """
  @spec update(String.t(), map, list) :: {:ok, t} | {:error, Stripe.api_error_struct()}
  def update(id, changes, opts = [connect_account: managed_account_id]) do
    endpoint = endpoint(managed_account_id) <> "/" <> id
    Stripe.Request.update(endpoint, changes, opts)
  end

  @doc """
  Delete an external account.
  """
  @spec delete(t | String.t(), list) :: :ok | {:error, Stripe.api_error_struct()}
  def delete(account, opts = [connect_account: managed_account_id]) do
    id = Util.normalize_id(account)
    endpoint = endpoint(managed_account_id) <> "/" <> id
    Stripe.Request.delete(endpoint, %{}, opts)
  end

  @doc """
  List all external accounts.
  """
  @spec list(map, Keyword.t()) :: {:ok, Stripe.List.t()} | {:error, Stripe.api_error_struct()}
  def list(params \\ %{}, opts = [connect_account: managed_account_id]) do
    endpoint = endpoint(managed_account_id)
    params = Map.merge(params, %{"object" => "bank_account"})
    Stripe.Request.retrieve(params, endpoint, opts)
  end
end

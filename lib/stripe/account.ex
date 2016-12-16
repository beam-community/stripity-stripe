defmodule Stripe.Account do
  @moduledoc """
  Work with Stripe account objects.

  You can:

  - Retrieve your own account
  - Retrieve an account with a specified `id`

  This module does not yet support managed accounts.

  Does not yet render lists or take options.

  Stripe API reference: https://stripe.com/docs/api#account
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :business_name, :business_primary_color, :business_url,
    :charges_enabled, :country, :default_currency, :details_submitted,
    :display_name, :email, :legal_entity, :managed, :metadata, :statement_descriptor,
    :support_email, :support_phone, :support_url, :timezone,
    :transfers_enabled
  ]

  @response_mapping %{
    id: :string,
    business_name: :string,
    business_primary_color: :string,
    business_url: :string,
    charges_enabled: :boolean,
    country: :string,
    default_currency: :string,
    details_submitted: :boolean,
    display_name: :string,
    email: :string,
    managed: :boolean,
    metadata: :metadata,
    statement_descriptor: :string,
    support_email: :string,
    support_phone: :string,
    support_url: :string,
    timezone: :string,
    transfers_enabled: :boolean,
    legal_entity: %{module: Stripe.Account.LegalEntity}
  }

  @singular_endpoint "account"
  @plural_endpoint "accounts"

  @valid_create_keys [:country, :email, :managed, :legal_entity]

  @doc """
  Returns the Stripe response mapping of keys to types.
  """
  @spec response_mapping :: Keyword.t
  def response_mapping, do: @response_mapping

  @doc """
  Create an account.
  """
  @spec create(t, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(account, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, account, @valid_create_keys, __MODULE__, opts)
  end

  @doc """
  Retrieve your own account without options.
  """
  @spec retrieve :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve, do: retrieve([])

  @doc """
  Retrieve your own account with options.
  """
  @spec retrieve(list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(opts) when is_list(opts), do: do_retrieve(@singular_endpoint, opts)

  @doc """
  Retrieve an account with a specified `id`.
  """
  @spec retrieve(binary, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []), do: do_retrieve(@plural_endpoint <> "/" <> id, opts)

  @spec do_retrieve(String.t, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  defp do_retrieve(endpoint, opts \\ []) do
    Stripe.Request.retrieve(endpoint, __MODULE__, opts)
  end
end

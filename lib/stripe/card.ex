defmodule Stripe.Card do
  @moduledoc """
  Work with Stripe card objects.

  You can:

  - Create a card
  - Retrieve a card
  - Update a card
  - Delete a card

  All requests require `owner_type` and `owner_id` parameters to be specified.

  `owner_type` must be one of the following:
    * `:customer`,
    * `:recipient`.

  `owner_id` must be the ID of the owning object.

  This module does not yet support managed accounts.

  Does not yet render lists or take options.

  Recipients may be deprecated for your version of the API. They have
  been replaced by managed accounts (see
  https://stripe.com/docs/connect/managed-accounts), which you should use
  if you're creating a new platform.

  Stripe API reference: https://stripe.com/docs/api#cards
  """

  alias Stripe.Util

  @type t :: %__MODULE__{}
  @type source :: :customer | :recipient

  defstruct [
    :id, :address_city, :address_country, :address_line1,
    :address_line1_check, :address_line2, :address_state,
    :address_zip, :address_zip_check, :brand, :country,
    :customer, :cvc_check, :dynamic_last4, :exp_month, :exp_year,
    :fingerprint, :funding, :last4, :metadata, :name, :recipient,
    :tokenization_method
  ]

  @response_mapping %{
    id: :string,
    address_city: :string,
    address_country: :string,
    address_line1: :string,
    address_line1_check: :string,
    address_line2: :string,
    address_state: :string,
    address_zip: :string,
    address_zip_check: :string,
    brand: :string,
    country: :string,
    customer: :string,
    cvc_check: :string,
    dynamic_last4: :string,
    exp_month: :integer,
    exp_year: :integer,
    fingerprint: :string,
    funding: :string,
    last4: :string,
    metadata: :metadata,
    name: :string,
    recipient: :string,
    tokenization_method: :string
  }

  @valid_update_keys [
    :address_city, :address_country, :address_line1, :address_line2,
    :address_state, :address_zip, :exp_month, :exp_year, :metadata, :name
  ]

  @doc """
  Returns the Stripe response mapping of keys to types.
  """
  @spec response_mapping :: Keyword.t
  def response_mapping, do: @response_mapping

  defp endpoint_for_owner(owner_type, owner_id) do
    case owner_type do
      :customer -> "customers/#{owner_id}/sources"
      :recipient -> "recipients/#{owner_id}/cards"
    end
  end

  @doc """
  Create a card.

  This requires a `token` created by a library like Stripe.js.

  For PCI compliance reasons you should not send a card's number or CVC
  to your own server.

  If you want to create a card with your server without a token, you
  can use the low-level API.
  """
  @spec create(source, String.t, String.t, Keyword.t) :: {:ok, t} | {:error, Exception.t}
  def create(owner_type, owner_id, token, opts \\ []) do
    endpoint = endpoint_for_owner(owner_type, owner_id)
    body =
      to_create_body(owner_type, token)
      |> Util.map_keys_to_atoms()

    case Stripe.request(:post, endpoint, body, %{}, opts) do
      {:ok, result} -> {:ok, Util.stripe_map_to_struct(%__MODULE__{}, result)}
      {:error, error} -> {:error, error}
    end
  end

  @spec to_create_body(source, String.t) :: map
  defp to_create_body(owner_type, token) do
    case owner_type do
      :customer -> %{source: token}
      :recipient -> %{external_account: token}
    end
  end

  @doc """
  Retrieve a card.
  """
  @spec retrieve(source, String.t, String.t, Keyword.t) :: {:ok, t} | {:error, Exception.t}
  def retrieve(owner_type, owner_id, card_id, opts \\ []) do
    endpoint = endpoint_for_owner(owner_type, owner_id) <> "/" <> card_id
    Stripe.Request.retrieve(endpoint, __MODULE__, opts)
  end

  @doc """
  Update a card.

  Takes the `id` and a map of changes
  """
  @spec update(source, String.t, String.t, map, Keyword.t) :: {:ok, t} | {:error, Exception.t}
  def update(owner_type, owner_id, card_id, changes, opts \\ []) do
    endpoint = endpoint_for_owner(owner_type, owner_id) <> "/" <> card_id
    Stripe.Request.update(endpoint, changes, @valid_update_keys, __MODULE__, opts)
  end

  @doc """
  Delete a card.
  """
  @spec delete(source, String.t, String.t, Keyword.t) :: :ok | {:error, Exception.t}
  def delete(owner_type, owner_id, card_id, opts \\ []) do
    endpoint = endpoint_for_owner(owner_type, owner_id) <> "/" <> card_id
    Stripe.Request.delete(endpoint, opts)
  end
end

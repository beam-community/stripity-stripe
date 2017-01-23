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
  alias Stripe.Converter

  @type t :: %__MODULE__{}
  @type source :: :customer | :recipient

  defstruct [
    :id, :object,
    :address_city, :address_country, :address_line1,
    :address_line1_check, :address_line2, :address_state,
    :address_zip, :address_zip_check, :brand, :country,
    :customer, :cvc_check, :dynamic_last4, :exp_month, :exp_year,
    :fingerprint, :funding, :last4, :metadata, :name, :recipient,
    :tokenization_method
  ]

  @schema %{
    account: [:retrieve],
    address_city: [:retrieve, :update],
    address_country: [:retrieve, :update],
    address_line1: [:retrieve, :update],
    address_line1_check: [:retrieve],
    address_line2: [:retrieve, :update],
    address_state: [:retrieve, :update],
    address_zip: [:retrieve, :update],
    address_zip_check: [:retrieve],
    brand: [:retrieve, :update],
    country: [:retrieve, :update],
    currency: [:retrieve, :update],
    customer: [:retrieve, :update],
    cvc_check: [:retrieve, :update],
    default_for_currency: [:create, :retrieve, :update],
    dynamic_last4: [:retrieve],
    exp_month: [:retrieve, :update],
    exp_year: [:retrieve, :update],
    external_account: [:create],
    fingerprint: [:retrieve],
    funding: [:retrieve],
    id: [:retrieve],
    last4: [:retrieve],
    metadata: [:create, :retrieve, :update],
    name: [:retrieve, :update],
    object: [:retrieve],
    recipient: [:retrieve],
    source: [:create],
    three_d_secure: [:retrieve],
    tokenization_method: [:retrieve]
  }

  @nullable_keys []

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
  @spec create(source, String.t, String.t, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(owner_type, owner_id, token, opts \\ []) do
    endpoint = endpoint_for_owner(owner_type, owner_id)
    body =
      to_create_body(owner_type, token)
      |> Util.map_keys_to_atoms()

    case Stripe.request(:post, endpoint, body, %{}, opts) do
      {:ok, result} -> {:ok, Converter.stripe_map_to_struct(result)}
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
  @spec retrieve(source, String.t, String.t, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(owner_type, owner_id, card_id, opts \\ []) do
    endpoint = endpoint_for_owner(owner_type, owner_id) <> "/" <> card_id
    Stripe.Request.retrieve(endpoint, opts)
  end

  @doc """
  Update a card.

  Takes the `id` and a map of changes
  """
  @spec update(source, String.t, String.t, map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(owner_type, owner_id, card_id, changes, opts \\ []) do
    endpoint = endpoint_for_owner(owner_type, owner_id) <> "/" <> card_id
    Stripe.Request.update(endpoint, changes, @schema, @nullable_keys, opts)
  end

  @doc """
  Delete a card.
  """
  @spec delete(source, String.t, String.t, Keyword.t) :: :ok | {:error, Stripe.api_error_struct}
  def delete(owner_type, owner_id, card_id, opts \\ []) do
    endpoint = endpoint_for_owner(owner_type, owner_id) <> "/" <> card_id
    Stripe.Request.delete(endpoint, opts)
  end
end

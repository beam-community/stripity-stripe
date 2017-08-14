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

  Example:

  ```
  {
    "id": "card_19l8f52eZvKYlo2CLNWCS4RU",
    "object": "card",
    "address_city": null,
    "address_country": null,
    "address_line1": null,
    "address_line1_check": null,
    "address_line2": null,
    "address_state": null,
    "address_zip": "19006",
    "address_zip_check": "pass",
    "brand": "Visa",
    "country": "US",
    "customer": null,
    "cvc_check": "pass",
    "dynamic_last4": null,
    "exp_month": 10,
    "exp_year": 2018,
    "funding": "credit",
    "last4": "4242",
    "metadata": {
    },
    "name": "wjefalkwjefaiwojf@example.com",
    "tokenization_method": null
  }
  ```
  """

  alias Stripe.Util

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

  defp endpoint_for_owner(owner_type, owner_id) do
    case owner_type do
      :customer -> "customers/#{owner_id}/sources"
      :account -> "accounts/#{owner_id}/external_accounts"
      :recipient -> "recipients/#{owner_id}/cards" # Deprecated
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

    to_create_body(owner_type, token)
    |> Util.map_keys_to_atoms()
    |> Stripe.request(:post, endpoint, %{}, opts)
    |> Stripe.Request.handle_result
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
    Stripe.Request.update(endpoint, changes, opts)
  end

  @doc """
  Delete a card.
  """
  @spec delete(source, String.t, String.t, Keyword.t) :: :ok | {:error, Stripe.api_error_struct}
  def delete(owner_type, owner_id, card_id, opts \\ []) do
    endpoint = endpoint_for_owner(owner_type, owner_id) <> "/" <> card_id
    Stripe.Request.delete(endpoint, %{}, opts)
  end

  @doc """
  List all cards.
  """
  @spec list(source, String.t, map, Keyword.t) :: {:ok, Stripe.List.t} | {:error, Stripe.api_error_struct}
  def list(owner_type, owner_id, params \\ %{}, opts \\ []) do
    endpoint = endpoint_for_owner(owner_type, owner_id)
    params = Map.merge(params, %{"object" => "card"})
    Stripe.Request.retrieve(params, endpoint, opts)
  end
end

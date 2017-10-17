defmodule Stripe.Card do
  @moduledoc """
  Work with Stripe card objects.

  You can:

  - Create a card
  - Retrieve a card
  - Update a card
  - Delete a card

  If you have been using an old version of the library, note that the functions which take an
  `owner_type` argument are now deprecated.

  The owner type is indicated by setting either the `recipient` or `customer`
  ```
  """
  use Stripe.Entity

  alias Stripe.Util

  @type t :: %__MODULE__{}
  @type source :: :customer | :recipient | :account
  @sources [:customer, :recipient, :account]
  @type owner :: Stripe.Customer.t | Stripe.Account.t

  defstruct [
    :id, :object,
    :address_city, :address_country, :address_line1,
    :address_line1_check, :address_line2, :address_state,
    :address_zip, :address_zip_check, :brand, :country,
    :customer, :cvc_check, :dynamic_last4, :exp_month, :exp_year,
    :fingerprint, :funding, :last4, :metadata, :name, :recipient,
    :tokenization_method
  ]

  from_json data do
    # todo convert this appropriately
    data
  end

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
  @spec delete(source, owner_or_id, card_or_id, Keyword.t) :: :ok | {:error, Stripe.api_error_struct}
      when owner_or_id: owner | String.t, card_or_id: t | String.t
  def delete(owner_type, owner, card, opts \\ []) when owner_type in @sources do
    owner_id = Util.normalize_id(owner)
    card_id = Util.normalize_id(card)
    do_delete(owner_type, owner_id, card_id, opts)
  end

  defp do_delete(owner_type, owner_id, card_id, opts \\ []) do
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

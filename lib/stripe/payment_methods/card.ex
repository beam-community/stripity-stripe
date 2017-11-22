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

  Stripe API reference: https://stripe.com/docs/api#cards
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          account: Stripe.id() | Stripe.Account.t() | nil,
          address_city: String.t() | nil,
          address_country: String.t() | nil,
          address_line1: String.t() | nil,
          address_line1_check: String.t() | nil,
          address_line2: String.t() | nil,
          address_state: String.t() | nil,
          address_zip: String.t() | nil,
          address_zip_check: String.t() | nil,
          available_payout_methods: list(String.t()) | nil,
          brand: String.t(),
          country: String.t() | nil,
          currency: String.t() | nil,
          customer: Stripe.id() | Stripe.Customer.t() | nil,
          cvc_check: String.t() | nil,
          default_for_currency: boolean | nil,
          dynamic_last4: String.t() | nil,
          exp_month: integer,
          exp_year: integer,
          fingerprint: String.t() | nil,
          funding: String.t(),
          last4: String.t(),
          metadata: Stripe.Types.metadata(),
          name: String.t() | nil,
          recipient: Stripe.id() | Stripe.Recipient.t() | nil,
          tokenization_method: String.t() | nil
        }

  defstruct [
    :id,
    :object,
    :account,
    :address_city,
    :address_country,
    :address_line1,
    :address_line1_check,
    :address_line2,
    :address_state,
    :address_zip,
    :address_zip_check,
    :available_payout_methods,
    :brand,
    :country,
    :currency,
    :customer,
    :cvc_check,
    :default_for_currency,
    :dynamic_last4,
    :exp_month,
    :exp_year,
    :fingerprint,
    :funding,
    :last4,
    :metadata,
    :name,
    :recipient,
    :tokenization_method
  ]

  defp plural_endpoint(%{customer: id}) do
    "customers/" <> id <> "/sources"
  end

  @doc """
  Create a card.

  This requires a `token` created by a library like Stripe.js.

  For PCI compliance reasons you should not send a card's number or CVC
  to your own server.

  If you want to create a card with your server without a token, you
  can use the low-level API.
  """
  @spec create(map, Keyword.t()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def create(%{customer: _, source: _} = params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(params |> plural_endpoint())
    |> put_params(params |> Map.delete(:customer))
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Retrieve a card.
  """
  @spec retrieve(Stripe.id() | t, map, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, %{customer: _} = params, opts \\ []) do
    endpoint = params |> plural_endpoint()

    new_request(opts)
    |> put_endpoint(endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a card.

  Takes the `id` and a map of changes
  """
  @spec update(Stripe.id() | t, map, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def update(id, %{customer: _} = params, opts \\ []) do
    endpoint = params |> plural_endpoint()

    new_request(opts)
    |> put_endpoint(endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params |> Map.delete(:customer))
    |> make_request()
  end

  @doc """
  Delete a card.
  """
  @spec delete(Stripe.id() | t, map, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def delete(id, %{customer: _} = params, opts \\ []) do
    endpoint = params |> plural_endpoint()

    new_request(opts)
    |> put_endpoint(endpoint <> "/#{get_id!(id)}")
    |> put_method(:delete)
    |> make_request()
  end

  @doc """
  List all cards.
  """
  @spec list(map, Stripe.options()) :: {:ok, Stripe.List.of(t)} | {:error, Stripe.Error.t()}
  def list(%{customer: _} = params, opts \\ []) do
    endpoint = params |> plural_endpoint()
    params = params |> Map.put(:object, "card")

    new_request(opts)
    |> put_endpoint(endpoint)
    |> put_method(:get)
    |> put_params(params |> Map.delete(:customer))
    |> make_request()
  end
end

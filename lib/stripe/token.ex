defmodule Stripe.Token do
  @moduledoc """
  Work with Stripe token objects.

  You can:

  - Create a token for a Connect customer with a card
  - Retrieve a token

  Does not yet render lists or take options.

  Stripe API reference: https://stripe.com/docs/api#token
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :card, :client_ip, :created, :livemode, :type, :used
  ]

  @relationships %{
    card: Stripe.Card,
    created: DateTime
  }

  @plural_endpoint "tokens"

  @schema %{
    bank_account: [:create, :retrieve],
    card: [:create, :retrieve],
    client_ip: [:retrieve],
    created: [:retrieve],
    customer: [:create],
    id: [:retrieve],
    livemode: [:retrieve],
    object: [:retrieve],
    pii: %{
      personal_id_number: [:create]
    },
    type: [:retrieve],
    used: [:retrieve]
  }

  @doc """
  Returns a map of relationship keys and their Struct name.
  Relationships must be specified for the relationship to
  be returned as a struct.
  """
  @spec relationships :: Keyword.t
  def relationships, do: @relationships

  @doc """
  Create a token for a Connect customer with a card belonging to the
  platform customer.

  You must pass in the account number for the Stripe Connect account
  in `opts`.
  """
  @spec create_on_connect_account(String.t, String.t, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create_on_connect_account(customer_id, customer_card_id, opts = [connect_account: _]) do
    body = %{
      card: customer_card_id,
      customer: customer_id
    }
    Stripe.Request.create(@plural_endpoint, body, @schema, __MODULE__, opts)
  end

  @doc """
  Create a token for a Connect customer using the default card.

  You must pass in the account number for the Stripe Connect account
  in `opts`.
  """
  @spec create_with_default_card(String.t, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create_with_default_card(customer_id, opts \\ []) do
    body = %{
      customer: customer_id
    }
    Stripe.Request.create(@plural_endpoint, body, @schema, __MODULE__, opts)
  end

  @doc """
  Retrieve a token.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, __MODULE__, opts)
  end
end

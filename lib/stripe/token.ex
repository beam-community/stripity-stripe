defmodule Stripe.Token do
  @moduledoc """
  Work with Stripe token objects.

  You can:

  - Create a token for a Connect customer with a card
  - Retrieve a token

  Does not yet render lists or take options.

  Stripe API reference: https://stripe.com/docs/api#token
  """

  alias Stripe.Util

  @type t :: %__MODULE__{}

  defstruct [
    :id, :card, :client_ip, :created, :livemode, :type, :used
  ]

  @response_mapping %{
    id: :string,
    card: %{module: Stripe.Card},
    client_ip: :string,
    created: :datetime,
    livemode: :boolean,
    used: :boolean
  }

  @plural_endpoint "tokens"

  @valid_create_connect_keys [
    :card, :customer
  ]

  @doc """
  Returns the Stripe response mapping of keys to types.
  """
  @spec response_mapping :: Keyword.t
  def response_mapping, do: @response_mapping

  @doc """
  Create a token for a Connect customer with a card belonging to that customer.

  You must pass in the account number for the Stripe Connect account
  in `opts`.
  """
  @spec create_on_connect_account(String.t, String.t, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create_on_connect_account(customer_id, customer_card_id, opts = [connect_account: _]) do
    body = %{
      card: customer_card_id,
      customer: customer_id
    }
    Stripe.Request.create(@plural_endpoint, body, @valid_create_connect_keys, __MODULE__, opts)
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

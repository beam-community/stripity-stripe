defmodule Stripe.Token do
  @moduledoc """
  Work with Stripe token objects.

  You can:

  - Create a token for a Connect customer with a card
  - Retrieve a token

  Stripe API reference: https://stripe.com/docs/api#token
  """

  alias Stripe.Util

  @type t :: %__MODULE__{}
  @type stripe_response :: {:ok, t} | {:error, Exception.t}
  @type stripe_delete_response :: :ok | {:error, Exception.t}

  defstruct [
    :id, :bank_account, :card, :client_ip, :created, :livemode, :type, :used
  ]

  @plural_endpoint "tokens"

  @valid_create_connect_keys [
    :card, :customer
  ]

  @doc """
  Create a token for a Connect customer with a card belonging to that customer.

  You must pass in the account number for the Stripe Connect account
  in `opts`.
  """
  @spec create_on_connect_account(String.t, String.t, Keyword.t) :: stripe_response
  def create_on_connect_account(customer_id, customer_card_id, opts = [connect_account: _]) do
    body = %{
      card: customer_card_id,
      customer: customer_id
    }
    Stripe.Request.create(@plural_endpoint, body, @valid_create_connect_keys, %__MODULE__{}, opts)
  end

  @doc """
  Retrieve a token.
  """
  @spec retrieve(binary, Keyword.t) :: stripe_response
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, %__MODULE__{}, opts)
  end
end

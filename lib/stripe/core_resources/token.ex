defmodule Stripe.Token do
  @moduledoc """
  Work with Stripe token objects.

  You can:

  - Create a token for a Connect customer with a card
  - Create a token with all options - Only for Unit Tests with Stripe
  - Retrieve a token

  Does not yet render lists or take options.

  Stripe API reference: https://stripe.com/docs/api#token

  """
  use Stripe.Entity

  @type t :: %__MODULE__{
               id: Stripe.id,
               object: String.t,
               bank_account: Stripe.BankAccount.t,
               card: Stripe.Card.t,
               client_ip: String.t,
               created: Stripe.timestamp,
               livemode: boolean,
               type: :card | :bank_account,
               used: boolean
             }

  defstruct [
    :id,
    :object,
    :bank_account,
    :card,
    :client_ip,
    :created,
    :livemode,
    :type,
    :used
  ]

  @plural_endpoint "tokens"

  @doc """
  Create a token for a Connect customer with a card belonging to the platform
  customer.

  You must pass in the account number for the Stripe Connect account in `opts`.
  """
  @spec create_on_connect_account(String.t, String.t, Keyword.t) :: {:ok, t} | {
    :error,
    Stripe.api_error_struct
  }
  def create_on_connect_account(customer_id, customer_card_id, opts = [connect_account: _]) do
    body = %{
      card: customer_card_id,
      customer: customer_id
    }
    Stripe.Request.create(@plural_endpoint, body, opts)
  end

  @doc """
  Create a token for a Connect customer using the default card.

  You must pass in the account number for the Stripe Connect account in `opts`.
  """
  @spec create_with_default_card(String.t, Keyword.t) :: {:ok, t} | {
    :error,
    Stripe.api_error_struct
  }
  def create_with_default_card(customer_id, opts \\ []) do
    body = %{
      customer: customer_id
    }
    Stripe.Request.create(@plural_endpoint, body, opts)
  end

  @doc """
  Create a token.

  WARNING: This function is mainly for testing purposes only, you should not
  use it on a production server, unless you are able to transfer and store
  credit card data on your server in a PCI compliant way.

  Use the Stripe.js library on the client device instead.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, opts)
  end

  @doc """
  Retrieve a token.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end
end

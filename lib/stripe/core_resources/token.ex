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

  @type token_bank_account :: %{
    id: Stripe.id,
    object: String.t,
    account_holder_name: String.t | nil,
    account_holder_type: Stripe.BankAccount.account_holder_type | nil,
    bank_name: String.t | nil,
    country: String.t,
    currency: String.t,
    fingerprint: String.t | nil,
    last4: String.t,
    routing_number: String.t | nil,
    status: Stripe.BankAccount.status
  }

  @type token_card :: %{
    id: Stripe.id,
    object: String.t,
    address_city: String.t | nil,
    address_country: String.t | nil,
    address_line1: String.t | nil,
    address_line1_check: Stripe.Card.check_result | nil,
    address_line2: String.t | nil,
    address_state: String.t | nil,
    address_zip: String.t | nil,
    address_zip_check: Stripe.Card.check_result | nil,
    brand: String.t,
    country: String.t | nil,
    currency: String.t,
    cvc_check: Stripe.Card.check_result | nil,
    dynamic_last4: String.t | nil,
    exp_month: integer,
    exp_year: integer,
    fingerprint: String.t | nil,
    funding: Stripe.Card.funding,
    last4: String.t,
    metadata: Stripe.Types.metadata,
    name: String.t | nil,
    tokenization_method: Stripe.Card.tokenization_method | nil
  }

  @type t :: %__MODULE__{
    id: Stripe.id,
    object: String.t,
    bank_account: token_bank_account,
    card: token_card,
    client_ip: String.t | nil,
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

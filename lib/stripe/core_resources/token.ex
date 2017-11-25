defmodule Stripe.Token do
  @moduledoc """
  Work with Stripe token objects.

  You can:

  - Create a token for a Connect customer with a card
  - Create a token with all options - Only for Unit Tests with Stripe
  - Retrieve a token

  Stripe API reference: https://stripe.com/docs/api#token

  """

  use Stripe.Entity
  import Stripe.Request

  @type token_bank_account :: %{
          id: Stripe.id(),
          object: String.t(),
          account_holder_name: String.t() | nil,
          account_holder_type: String.t() | nil,
          bank_name: String.t() | nil,
          country: String.t(),
          currency: String.t(),
          fingerprint: String.t() | nil,
          last4: String.t(),
          routing_number: String.t() | nil,
          status: String.t()
        }

  @type token_card :: %{
          id: Stripe.id(),
          object: String.t(),
          address_city: String.t() | nil,
          address_country: String.t() | nil,
          address_line1: String.t() | nil,
          address_line1_check: String.t() | nil,
          address_line2: String.t() | nil,
          address_state: String.t() | nil,
          address_zip: String.t() | nil,
          address_zip_check: String.t() | nil,
          brand: String.t(),
          country: String.t() | nil,
          currency: String.t(),
          cvc_check: String.t() | nil,
          dynamic_last4: String.t() | nil,
          exp_month: integer,
          exp_year: integer,
          fingerprint: String.t() | nil,
          funding: String.t(),
          last4: String.t(),
          metadata: Stripe.Types.metadata(),
          name: String.t() | nil,
          tokenization_method: String.t() | nil
        }

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          bank_account: token_bank_account | nil,
          card: token_card | nil,
          client_ip: String.t() | nil,
          created: Stripe.timestamp(),
          livemode: boolean,
          type: String.t(),
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
  Creates a single use token that wraps the details of a credit card. This
  token can be used in place of a credit card dictionary with any API method.
  These tokens can only be used once: by creating a new charge object, or
  attaching them to a customer.

  In most cases, you should create tokens client-side using Checkout, Elements,
  or Stripe's mobile libraries, instead of using the API.
  """
  @spec create(map, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Retrieve a token.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end
end

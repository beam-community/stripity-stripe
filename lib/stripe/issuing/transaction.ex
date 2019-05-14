defmodule Stripe.Issuing.Transaction do
  @moduledoc """
  Work with Stripe Issuing transaction objects.

  You can:

  - Retrieve a transaction
  - Update a transaction
  - List all transactions

  Stripe API reference: https://stripe.com/docs/api/issuing/transactions
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          amount: integer,
          authorization: Stripe.id() | Stripe.Issuing.Authorization.t(),
          balance_transaction: String.t(),
          card: Stripe.id() | Stripe.Issuing.Card.t(),
          cardholder: Stripe.id() | Stripe.Issuing.Cardholder.t(),
          created: Stripe.timestamp(),
          currency: String.t() | nil,
          dispute: Stripe.id() | Stripe.Issuing.Dispute.t(),
          livemode: boolean,
          merchant_data: Stripe.Issuing.Types.merchant_data(),
          metadata: Stripe.Types.metadata(),
          type: String.t()
        }

  defstruct [
    :id,
    :object,
    :amount,
    :authorization,
    :balance_transaction,
    :card,
    :cardholder,
    :created,
    :currency,
    :dispute,
    :livemode,
    :merchant_data,
    :metadata,
    :type
  ]

  @plural_endpoint "issuing/transactions"

  @doc """
  Retrieve a transaction.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a transaction.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:metadata) => Stripe.Types.metadata()
               }
               | %{}
  def update(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  List all transactions.
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:card) => Stripe.Issuing.Card.t() | Stripe.id(),
                 optional(:cardholder) => Stripe.Issuing.Cardholder.t() | Stripe.id(),
                 optional(:created) => String.t() | Stripe.date_query(),
                 optional(:dispute) => Stripe.Issuing.Dispute.t() | Stripe.id(),
                 optional(:ending_before) => t | Stripe.id(),
                 optional(:limit) => 1..100,
                 optional(:settlement) => String.t(),
                 optional(:starting_after) => t | Stripe.id()
               }
               | %{}
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> prefix_expansions()
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:card, :cardholder, :dispute, :ending_before, :starting_after])
    |> make_request()
  end
end

defmodule Stripe.BalanceTransaction do
  @moduledoc """
  Work with [Stripe `balance_transaction` objects]  (https://stripe.com/docs/api#balance_transaction_object).

  You can:
  - [Retrieve a balance transaction](https://stripe.com/docs/api#balance_transaction_retrieve)
  - [List all balance history](https://stripe.com/docs/api#balance_history)
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          amount: integer,
          available_on: Stripe.timestamp(),
          created: Stripe.timestamp(),
          currency: String.t(),
          description: String.t() | nil,
          exchange_rate: integer | nil,
          fee: integer,
          fee_details: list(Stripe.Types.fee()) | [],
          net: integer,
          reporting_category: String.t(),
          source: Stripe.id() | Stripe.Source.t() | nil,
          status: String.t(),
          type: String.t()
        }

  defstruct [
    :id,
    :object,
    :amount,
    :available_on,
    :created,
    :currency,
    :description,
    :exchange_rate,
    :fee,
    :fee_details,
    :net,
    :reporting_category,
    :source,
    :status,
    :type
  ]

  @endpoint "balance/history"

  @doc """
  Retrieves the balance transaction with the given ID.

  Requires the ID of the balance transaction to retrieve and takes no other parameters.

  See the [Stripe docs](https://stripe.com/docs/api#balance_transaction_retrieve).
  """
  @spec retrieve(Stripe.id(), Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@endpoint <> "/#{id}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Returns a list of transactions that have contributed to the Stripe account balance.

  Examples of such transactions are charges, transfers, and so forth.
  The transactions are returned in sorted order, with the most recent transactions appearing first.

  See `t:Stripe.BalanceTransaction.All.t/0` or the
  [Stripe docs](https://stripe.com/docs/api#balance_history) for parameter structure.
  """
  @spec all(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:available_on) => String.t() | Stripe.date_query(),
               optional(:created) => String.t() | Stripe.date_query(),
               optional(:currency) => String.t(),
               optional(:ending_before) => Stripe.id() | Stripe.BalanceTransaction.t(),
               optional(:limit) => 1..100,
               optional(:payout) => Stripe.id() | Stripe.Payout.t(),
               optional(:source) => Stripe.id() | Stripe.Source.t(),
               optional(:starting_after) => Stripe.id() | Stripe.BalanceTransaction.t(),
               optional(:type) => String.t()
             }
  def all(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:ending_before, :payout, :source, :starting_after])
    |> make_request()
  end
end

defmodule Stripe.BalanceTransaction do
  import Stripe.Request

  @moduledoc """
  Work with [Stripe `balance_transaction` objects]  (https://stripe.com/docs/api#balance_transaction_object).

  You can:
  - [Retrieve a balance transaction](https://stripe.com/docs/api#balance_transaction_retrieve)
  - [List all balance history](https://stripe.com/docs/api#balance_history)
  """
  use Stripe.Entity

  @type transaction_type :: :adjustment | :application_fee | :application_fee_refund | :charge
  | :payment | :payment_failure_refund | :payment_refund | :refund | :transfer | :transfer_refund
  | :payout | :payout_cancel | :payout_failure | :validation

  @type fee :: %{
                 amount: integer,
                 application: String.t,
                 currency: String.t,
                 description: String.t,
                 type: :application_fee | :stripe_fee | :tax
               }

  @type t :: %__MODULE__{
               id: Stripe.id,
               object: String.t,
               amount: integer,
               available_on: Stripe.timestamp,
               created: Stripe.timestamp,
               currency: String.t,
               description: String.t,
               fee: integer,
               fee_details: [fee],
               net: integer,
               source: Stripe.id | Stripe.Source.t,
               status: :available | :pending,
               type: transaction_type
             }

  defstruct [:id, :object, :amount, :available_on, :created, :currency, :description, :fee,
    :fee_details, :net, :source, :status, :type]

  from_json data do
    data
    |> cast_to_atom([:type, :status])
    |> cast_each(:fee_details, &cast_to_atom(&1, :type))
  end

  @endpoint "balance/history"

  @doc """
  Retrieves the balance transaction with the given ID.

  Requires the ID of the balance transaction to retrieve and takes no other parameters.

  See the [Stripe docs](https://stripe.com/docs/api#balance_transaction_retrieve).
  """
  @spec retrieve(Stripe.id, Stripe.options) :: {:ok, t} | {:error, Stripe.Error.t}
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
  @spec all(params, Stripe.options) :: {:ok, Stripe.List.of(t)} | {:error, Stripe.Error.t}
        when params: %{
               available_on: Stripe.date_query,
               created: Stripe.date_query,
               currency: String.t,
               ending_before: Stripe.id | Stripe.BalanceTransaction.t,
               limit: 1..100,
               payout: Stripe.id | Stripe.Payout.t,
               source: Stripe.id | Stripe.Source.t,
               starting_after: Stripe.id | Stripe.BalanceTransaction.t,
               type: Stripe.BalanceTransaction.transaction_type
             }
  def all(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> valid_keys([:available_on, :created, :currency, :ending_before, :limit, :payout, :source,
      :starting_after, :type])
    |> cast_to_id([:ending_before, :payout, :source, :starting_after])
    |> make_request()
  end
end

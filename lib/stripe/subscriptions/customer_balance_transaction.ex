defmodule Stripe.CustomerBalanceTransaction do
  @moduledoc """
  Work with Stripe Customer Balance Transactions objects.

  You can:

  - Create a customer balance transaction
  - Retrieve a customer balance transaction
  - Update a customer balance transaction
  - List customer balance transactions

  Stripe API reference: https://stripe.com/docs/api/customer_balance_transactions
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %{
          id: Stripe.id(),
          object: String.t(),
          amount: integer,
          created: Stripe.timestamp(),
          credit_note: String.t() | Stripe.CreditNote.t() | nil,
          currency: String.t(),
          customer: Stripe.id() | Stripe.Customer.t(),
          description: String.t() | nil,
          ending_balance: integer,
          invoice: Stripe.id() | Stripe.Invoice.t() | nil,
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          type: String.t()
        }

  defstruct [
    :id,
    :object,
    :amount,
    :created,
    :credit_note,
    :currency,
    :customer,
    :description,
    :ending_balance,
    :invoice,
    :livemode,
    :metadata,
    :type
  ]

  defp plural_endpoint(customer_id) do
    "customers/#{customer_id}/balance_transactions"
  end

  defp plural_endpoint(customer_id, balance_transaction_id) do
    "customers/#{customer_id}/balance_transactions/#{balance_transaction_id}"
  end

  @doc """
  Create a customer balance transaction.
  """
  @spec create(Stripe.id() | Stripe.Customer.t(), params, Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 :amount => number,
                 :currency => String.t(),
                 optional(:description) => String.t(),
                 optional(:metadata) => Stripe.Types.metadata()
               }
               | %{}
  def create(customer, %{amount: _, currency: _} = params, opts \\ []) do
    plural_endpoint = customer |> get_id!() |> plural_endpoint()

    new_request(opts)
    |> put_endpoint(plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Retrieve a Customer Balance Transaction.
  """
  @spec retrieve(Stripe.id() | Stripe.Customer.t(), Stripe.id() | t, Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(customer, balance_transaction, opts \\ []) do
    customer_id = get_id!(customer)
    balance_transaction_id = get_id!(balance_transaction)
    plural_endpoint = plural_endpoint(customer_id, balance_transaction_id)

    new_request(opts)
    |> put_endpoint(plural_endpoint)
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a Customer Balance Transaction.
  """
  @spec update(Stripe.id() | Stripe.Customer.t(), Stripe.id() | t, params, Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:description) => String.t(),
               optional(:metadata) => Stripe.Types.metadata()
             }
  def update(customer, balance_transaction, params, opts \\ []) do
    customer_id = get_id!(customer)
    balance_transaction_id = get_id!(balance_transaction)
    plural_endpoint = plural_endpoint(customer_id, balance_transaction_id)

    new_request(opts)
    |> put_endpoint(plural_endpoint)
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  List all Customer Balance Transactions.
  """
  @spec list(Stripe.id() | Stripe.Customer.t(), params, Stripe.options()) ::
          {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:ending_before) => t | Stripe.id(),
                 optional(:limit) => 1..100,
                 optional(:starting_after) => t | Stripe.id()
               }
               | %{}
  def list(customer, params \\ %{}, opts \\ []) do
    plural_endpoint = customer |> get_id!() |> plural_endpoint()

    new_request(opts)
    |> put_endpoint(plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:ending_before, :starting_after])
    |> make_request()
  end
end

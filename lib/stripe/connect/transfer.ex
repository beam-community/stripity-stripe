defmodule Stripe.Transfer do
  @moduledoc """
  Work with Stripe transfer objects.

  Stripe API reference: https://stripe.com/docs/api#transfers
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          amount: integer,
          amount_reversed: integer,
          balance_transaction: Stripe.id() | Stripe.BalanceTransaction.t(),
          created: Stripe.timestamp(),
          currency: String.t(),
          description: String.t(),
          destination: Stripe.id() | Stripe.Account.t(),
          destination_payment: String.t(),
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          reversals: Stripe.List.t(Stripe.TransferReversal.t()),
          reversed: boolean,
          source_transaction: Stripe.id() | Stripe.Charge.t(),
          source_type: String.t(),
          transfer_group: String.t()
        }

  defstruct [
    :id,
    :object,
    :amount,
    :amount_reversed,
    :balance_transaction,
    :created,
    :currency,
    :description,
    :destination,
    :destination_payment,
    :livemode,
    :metadata,
    :reversals,
    :reversed,
    :source_transaction,
    :source_type,
    :transfer_group
  ]

  @plural_endpoint "transfers"

  @doc """
  Create a transfer.
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               :amount => pos_integer,
               :currency => String.t(),
               :destination => Stripe.id() | Stripe.Account.t(),
               optional(:metadata) => Stripe.Types.metadata(),
               optional(:source_transaction) => Stripe.id() | Stripe.Charge.t(),
               optional(:transfer_group) => String.t(),
               optional(:description) => String.t()
             }
  def create(%{amount: _, currency: _, destination: _} = params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> cast_to_id([:coupon, :customer, :source])
    |> make_request()
  end

  @doc """
  Retrieve a transfer.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a transfer.

  Takes the `id` and a map of changes.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:description) => String.t(),
               optional(:metadata) => Stripe.Types.metadata()
             }
  def update(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> cast_to_id([:coupon, :source])
    |> make_request()
  end

  @doc """
  List all transfers.
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:created) => Stripe.date_query(),
               optional(:destination) => Stripe.id() | Stripe.Account.t(),
               optional(:ending_before) => t | Stripe.id(),
               optional(:limit) => 1..100,
               optional(:starting_after) => t | Stripe.id(),
               optional(:transfer_group) => String.t()
             }
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:customer, :ending_before, :plan, :starting_after])
    |> make_request()
  end
end

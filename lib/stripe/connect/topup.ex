defmodule Stripe.Topup do
  @moduledoc """
  Work with Stripe Connect top-up objects.

  You can:

  - Create a top-up
  - Retrieve a top-up
  - Update a top-up
  - List all top-ups
  - Cancel a top-up

  Stripe API reference: https://stripe.com/docs/api/topups
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          amount: pos_integer,
          balance_transaction: Stripe.id() | Stripe.BalanceTransaction.t() | nil,
          created: Stripe.timestamp(),
          currency: String.t(),
          description: String.t(),
          expected_availability_date: Stripe.timestamp() | nil,
          failure_code: String.t() | nil,
          failure_message: String.t() | nil,
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          source: Stripe.id() | Stripe.Source.t(),
          statement_descriptor: String.t() | nil,
          status: String.t(),
          transfer_group: String.t() | nil
        }

  defstruct [
    :id,
    :object,
    :amount,
    :balance_transaction,
    :created,
    :currency,
    :description,
    :expected_availability_date,
    :failure_code,
    :failure_message,
    :livemode,
    :metadata,
    :source,
    :statement_descriptor,
    :status,
    :transfer_group
  ]

  @plural_endpoint "topups"

  @doc """
  Create a Top-up.
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               :amount => pos_integer(),
               :currency => String.t(),
               optional(:description) => String.t(),
               optional(:metadata) => Stripe.Types.metadata(),
               optional(:source) => Stripe.Source.t(),
               optional(:statement_descriptor) => String.t(),
               optional(:transfer_group) => String.t()
             }
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> cast_to_id([:source])
    |> make_request()
  end

  @doc """
  Retrieve a Top-up.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a Top-up.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:description) => String.t(),
               optional(:metadata) => Stripe.Types.metadata()
             }
  def update(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  List Top-ups.
  """
  @spec list(params, Stripe.options()) ::
          {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:amount) => pos_integer() | Stripe.integer_query(),
               optional(:created) => Stripe.date_query(),
               optional(:ending_before) => t | Stripe.id(),
               optional(:starting_after) => t | Stripe.id(),
               optional(:limit) => 1..100,
               optional(:status) => String.t()
             }
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> prefix_expansions()
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:ending_before, :starting_after])
    |> make_request()
  end

  @doc """
  Cancel a pending Top-up.
  """
  @spec cancel(Stripe.id() | t, Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
  def cancel(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}/cancel")
    |> put_method(:post)
    |> make_request()
  end
end

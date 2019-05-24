defmodule Stripe.Issuing.Dispute do
  @moduledoc """
  Work with Stripe Issuing dispute objects.

  You can:

  - Create a dispute
  - Retrieve a dispute
  - Update a dispute
  - List all disputes

  Stripe API reference: https://stripe.com/docs/api/issuing/disputes
  """

  use Stripe.Entity
  import Stripe.Request

  @type evidence :: %{
          fraudulent: evidence_detail() | nil,
          other: evidence_detail() | nil
        }

  @type evidence_detail :: %{
          dispute_explanation: String.t(),
          uncategorized_file: String.t()
        }

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          amount: integer,
          created: Stripe.timestamp(),
          currency: String.t() | nil,
          disputed_transaction: Stripe.id() | Stripe.Issuing.Transaction.t(),
          evidence: evidence(),
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          reason: atom() | String.t(),
          status: String.t()
        }

  defstruct [
    :id,
    :object,
    :amount,
    :created,
    :currency,
    :disputed_transaction,
    :evidence,
    :livemode,
    :metadata,
    :reason,
    :status
  ]

  @plural_endpoint "issuing/disputes"

  @doc """
  Create a dispute.
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 :disputed_transaction => Stripe.id() | Stripe.Issuing.Transaction.t(),
                 :reason => :other | :fradulent,
                 optional(:amount) => non_neg_integer,
                 optional(:evidence) => evidence(),
                 optional(:metadata) => Stripe.Types.metadata()
               }
               | %{}
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> cast_to_id([:disputed_transaction])
    |> make_request()
  end

  @doc """
  Retrieve a dispute.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a dispute.
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
  List all disputes.
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:created) => String.t() | Stripe.date_query(),
                 optional(:disputed_transaction) => Stripe.Issuing.Transaction.t() | Stripe.id(),
                 optional(:ending_before) => t | Stripe.id(),
                 optional(:limit) => 1..100,
                 optional(:starting_after) => t | Stripe.id()
               }
               | %{}
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> prefix_expansions()
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:disputed_transaction, :ending_before, :starting_after])
    |> make_request()
  end
end

defmodule Stripe.CreditNote do
  @moduledoc """
  Work with Stripe Credit Note objects.

  You can:

  - Create a credit note
  - Retrieve a credit note
  - Update a credit note
  - Void a credit note
  - List credit notes

  ```
  {
    "id": "ivory-extended-580",
    "object": "plan",
    "active": true,
    "aggregate_usage": null,
    "amount": 999,
    "billing_scheme": "per_unit",
    "created": 1531234812,
    "currency": "usd",
    "interval": "month",
    "interval_count": 1,
    "livemode": false,
    "metadata": {
    },
    "nickname": null,
    "product": "prod_DCmtkptv7qHXGE",
    "tiers": null,
    "tiers_mode": null,
    "transform_usage": null,
    "trial_period_days": null,
    "usage_type": "licensed"
  }
  ```
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          amount: integer,
          created: Stripe.timestamp(),
          currency: String.t(),
          currency: String.t(),
          customer: Stripe.id() | nil,
          invoice: Stripe.id(),
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          number: String.t(),
          pdf: String.t(),
          reason: String.t() | nil,
          refund: Stripe.id() | Stripe.Refund.t() | nil,
          status: String.t(),
          type: String.t()
        }

  defstruct [
    :id,
    :object,
    :amount,
    :created,
    :currency,
    :customer,
    :invoice,
    :livemode,
    :memo,
    :metadata,
    :number,
    :pdf,
    :reason,
    :refund,
    :status,
    :type
  ]

  @plural_endpoint "credit_notes"

  @doc """
  Create a credit note.

    Stripe.CreditNote.create(%{
      invoice: "in_173uNd4Wq104wst7Gf4dgq1Y",
      amount: 500,
    })

  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 :amount => number,
                 :invoice => Stripe.id(),
                 optional(:credit_amount) => number,
                 optional(:memo) => String.t(),
                 optional(:metadata) => Stripe.Types.metadata(),
                 optional(:reason) => String.t(),
                 optional(:refund_amount) => number,
                 optional(:refund) => Stripe.id()
               }
               | %{}
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Retrieve a Credit Note.

    Stripe.CreditNote.retrieve("cn_1EXwJk4Wq104wst7IISdh9ed")
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a credit note.

  Takes the `id` and a map of changes.

    Stripe.CreditNote.update(
      "cn_1EXwJk4Wq104wst7IISdh9ed",
      %{
        metadata: {order_id: "6735"},
      }
    )
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:memo) => String.t(),
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
  Void a credit note.

    Stripe.CreditNote.void("cn_1EXwJk4Wq104wst7IISdh9ed")

  """
  @spec void(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def void(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}/void")
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  List all credit notes.

    Stripe.CreditNote.list(limit: 3)
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:ending_before) => t | Stripe.id(),
                 optional(:limit) => 1..100,
                 optional(:invoice) => Stripe.id(),
                 optional(:starting_after) => t | Stripe.id()
               }
               | %{}
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:ending_before, :starting_after])
    |> make_request()
  end
end

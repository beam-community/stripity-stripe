defmodule Stripe.Plan do
  @moduledoc """
  Work with Stripe plan objects.

  You can:

  - Create a plan
  - Retrieve a plan
  - Update a plan
  - Delete a plan

  Does not yet render lists or take options.

  Stripe API reference: https://stripe.com/docs/api#plan

  Example:

  ```
  {
    "id": "quartz-enterprise",
    "object": "plan",
    "amount": 5000,
    "created": 1486598337,
    "currency": "usd",
    "interval": "month",
    "interval_count": 1,
    "livemode": false,
    "metadata": {
    },
    "name": "Quartz enterprise",
    "statement_descriptor": null,
    "trial_period_days": null
  }
  ```
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          amount: non_neg_integer,
          created: Stripe.timestamp(),
          currency: String.t(),
          interval: String.t(),
          interval_count: pos_integer,
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          name: String.t(),
          statement_descriptor: String.t() | nil,
          trial_period_days: integer | nil
        }

  defstruct [
    :id,
    :object,
    :amount,
    :created,
    :currency,
    :interval,
    :interval_count,
    :livemode,
    :metadata,
    :name,
    :statement_descriptor,
    :trial_period_days
  ]

  @plural_endpoint "plans"

  @doc """
  Create a plan.
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               amount: non_neg_integer,
               currency: String.t(),
               interval: String.t(),
               interval_count: pos_integer | nil,
               metadata: Stripe.Types.metadata() | nil,
               name: String.t(),
               statement_descriptor: String.t() | nil
             } | %{}
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Retrieve a plan.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a plan.

  Takes the `id` and a map of changes.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               metadata: Stripe.Types.metadata() | nil,
               name: String.t() | nil,
               statement_descriptor: String.t() | nil
             } | %{}
  def update(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  Delete a plan.
  """
  @spec delete(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def delete(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:delete)
    |> make_request()
  end

  @doc """
  List all plans.
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.of(t)} | {:error, Stripe.Error.t()}
        when params: %{
               created: Stripe.date_query() | nil,
               ending_before: t | Stripe.id() | nil,
               limit: 1..100 | nil,
               starting_after: t | Stripe.id() | nil
             } | %{}
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:ending_before, :starting_after])
    |> make_request()
  end
end

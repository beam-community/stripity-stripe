defmodule Stripe.Plan do
  @moduledoc """
  Work with Stripe plan objects.

  You can:

  - Create a plan
  - Retrieve a plan
  - Update a plan
  - Delete a plan

  Stripe API reference: https://stripe.com/docs/api#plan
  """

  alias Stripe.Util

  @type t :: %__MODULE__{}

  defstruct [
    :id, :amount, :created, :currency, :interval, :interval_count,
    :livemode, :metadata, :name, :statement_descriptor, :trial_period_days
  ]

  @plural_endpoint "plans"

  @valid_create_keys [
    :id, :amount, :currency, :interval, :interval_count, :metadata, :name,
    :statement_descriptor, :trial_period_days
  ]

  @valid_update_keys [
    :metadata, :name, :statement_descriptor, :trial_period_days
  ]

  @doc """
  Create a plan.
  """
  @spec create(t, Keyword.t) :: {:ok, t} | {:error, Exception.t}
  def create(plan, opts \\ []) do
    endpoint = @plural_endpoint

    plan =
      Map.from_struct(plan)
      |> Map.take(@valid_create_keys)
      |> Util.drop_nil_keys()

    case Stripe.request(:post, endpoint, plan, %{}, opts) do
      {:ok, result} -> {:ok, to_struct(result)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Retrieve a plan.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Exception.t}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    case Stripe.request(:get, endpoint, %{}, %{}, opts) do
      {:ok, result} -> {:ok, to_struct(result)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Update a plan.

  Takes the `id` and a map of changes.
  """
  @spec update(t, map, list) :: {:ok, t} | {:error, Exception.t}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id

    plan =
      changes
      |> Util.map_keys_to_atoms()
      |> Map.take(@valid_update_keys)
      |> Util.drop_nil_keys()

    case Stripe.request(:post, endpoint, plan, %{}, opts) do
      {:ok, result} -> {:ok, to_struct(result)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Delete a plan.
  """
  @spec delete(binary, list) :: :ok | {:error, Exception.t}
  def delete(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id

    case Stripe.request(:delete, endpoint, %{}, %{}, opts) do
      {:ok, _} -> :ok
      {:error, error} -> {:error, error}
    end
  end
end

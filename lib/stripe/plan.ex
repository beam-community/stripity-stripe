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
  @type stripe_response :: {:ok, t} | {:error, Exception.t}
  @type stripe_delete_response :: :ok | {:error, Exception.t}

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
  @spec create(t, Keyword.t) :: stripe_response
  def create(plan, opts \\ []) do
    endpoint = @plural_endpoint

    plan =
      plan
      |> Map.take(@valid_create_keys)
      |> Util.drop_nil_keys()

    case Stripe.request(:post, endpoint, plan, %{}, opts) do
      {:ok, result} -> {:ok, Util.stripe_response_to_struct(%__MODULE__{}, result)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Retrieve a plan.
  """
  @spec retrieve(binary, Keyword.t) :: stripe_response
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    case Stripe.request(:get, endpoint, %{}, %{}, opts) do
      {:ok, result} -> {:ok, Util.stripe_response_to_struct(%__MODULE__{}, result)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Update a plan.

  Takes the `id` and a map of changes.
  """
  @spec update(t, map, list) :: stripe_response
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id

    plan =
      changes
      |> Util.map_keys_to_atoms()
      |> Map.take(@valid_update_keys)
      |> Util.drop_nil_keys()

    case Stripe.request(:post, endpoint, plan, %{}, opts) do
      {:ok, result} -> {:ok, Util.stripe_response_to_struct(%__MODULE__{}, result)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Delete a plan.
  """
  @spec delete(binary, list) :: stripe_delete_response
  def delete(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id

    case Stripe.request(:delete, endpoint, %{}, %{}, opts) do
      {:ok, _} -> :ok
      {:error, error} -> {:error, error}
    end
  end
end

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
  """

  alias Stripe.Util

  @type t :: %__MODULE__{}

  defstruct [
    :id, :amount, :created, :currency, :interval, :interval_count,
    :livemode, :metadata, :name, :statement_descriptor, :trial_period_days
  ]

  @response_mapping %{
    id: :string,
    amount: :integer,
    created: :datetime,
    currency: :string,
    interval: :string,
    interval_count: :integer,
    livemode: :boolean,
    metadata: :metadata,
    name: :string,
    statement_descriptor: :string,
    trial_period_days: :integer
  }

  @plural_endpoint "plans"

  @valid_create_keys [
    :id, :amount, :currency, :interval, :interval_count, :metadata, :name,
    :statement_descriptor, :trial_period_days
  ]

  @valid_update_keys [
    :metadata, :name, :statement_descriptor, :trial_period_days
  ]

  @doc """
  Returns the Stripe response mapping of keys to types.
  """
  @spec response_mapping :: Keyword.t
  def response_mapping, do: @response_mapping

  @doc """
  Create a plan.
  """
  @spec create(t, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(plan, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, plan, @valid_create_keys, __MODULE__, opts)
  end

  @doc """
  Retrieve a plan.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, __MODULE__, opts)
  end

  @doc """
  Update a plan.

  Takes the `id` and a map of changes.
  """
  @spec update(t, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, @valid_update_keys, __MODULE__, opts)
  end

  @doc """
  Delete a plan.
  """
  @spec delete(binary, list) :: :ok | {:error, Stripe.api_error_struct}
  def delete(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.delete(endpoint, opts)
  end
end

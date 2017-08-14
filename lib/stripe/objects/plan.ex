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

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object,
    :amount, :created, :currency, :interval, :interval_count,
    :livemode, :metadata, :name, :statement_descriptor, :trial_period_days
  ]

  @plural_endpoint "plans"

  @doc """
  Create a plan.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, opts)
  end

  @doc """
  Retrieve a plan.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end

  @doc """
  Update a plan.

  Takes the `id` and a map of changes.
  """
  @spec update(binary, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, opts)
  end

  @doc """
  Delete a plan.
  """
  @spec delete(binary, list) :: :ok | {:error, Stripe.api_error_struct}
  def delete(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.delete(endpoint, %{}, opts)
  end

  @doc """
  List all plans.
  """
  @spec list(map, Keyword.t) :: {:ok, Stripe.List.t} | {:error, Stripe.api_error_struct}
  def list(params \\ %{}, opts \\ []) do
    endpoint = @plural_endpoint
    Stripe.Request.retrieve(params, endpoint, opts)
  end
end

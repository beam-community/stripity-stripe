defmodule Stripe.Refund do
  @moduledoc """
  Work with Stripe refund objects.

  You can:

  - Create a refund
  - Retrieve a refund
  - Update a refund

  Stripe API reference: https://stripe.com/docs/api#refunds
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object, :amount, :balance_transaction, :charge, :created, :currency,
    :metadata, :reason, :receipt_number, :status
  ]

  @plural_endpoint "refunds"

  @doc """
  Create a refund.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, opts)
  end

  @doc """
  Retrieve a refund
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end

  @doc """
  Update a refund
  """
  @spec update(binary, map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, opts)
  end

  @doc """
  List all refunds.
  """
  @spec list(map, Keyword.t) :: {:ok, Stripe.List.t} | {:error, Stripe.api_error_struct}
  def list(params \\ %{}, opts \\ []) do
    endpoint = @plural_endpoint
    Stripe.Request.retrieve(params, endpoint, opts)
  end
end

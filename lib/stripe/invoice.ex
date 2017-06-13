defmodule Stripe.Invoice do
  @moduledoc """
  Work with Stripe invoice objects.

  You can:

  - Create an invoice
  - Retrieve an invoice
  - Update an invoice

  Does not take options yet.

  Stripe API reference: https://stripe.com/docs/api#invoice
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object,
    :amount_due, :application_fee, :attempt_count, :attempted,
    :charge, :closed, :currency, :customer, :date, :description, :discount,
    :ending_balance, :forgiven, :lines, :livemode, :metadata,
    :next_payment_attempt, :paid, :period_end, :period_start,
    :receipt_number, :starting_balance, :statement_descriptor,
    :subscription, :subscription_proration_date, :subtotal, :tax,
    :tax_percent, :total, :webhooks_delivered_at
  ]

  @plural_endpoint "invoices"

  @schema %{
    amount_due: [:retrieve],
    application_fee: [:create, :retrieve, :update],
    attempt_count: [:retrieve],
    attempted: [:retrieve],
    charge: [:retrieve],
    closed: [:retrieve],
    currency: [:retrieve],
    customer: [:retrieve],
    date: [:retrieve],
    description: [:create, :retrieve, :update],
    discount: [:retrieve],
    ending_balance: [:retrieve],
    forgiven: [:retrieve, :update],
    id: [:retrieve],
    lines: [:retrieve],
    livemode: [:retrieve],
    metadata: [:create, :retrieve, :update],
    next_payment_attempt: [:retrieve],
    paid: [:retrieve],
    period_end: [:retrieve],
    period_start: [:retrieve],
    receipt_number: [:retrieve],
    starting_balance: [:retrieve],
    statement_descriptor: [:retrieve, :update],
    subscription: [:create, :retrieve],
    subscription_proration_date: [:retrieve],
    subtotal: [:retrieve],
    tax: [:retrieve],
    tax_percent: [:create, :retrieve, :update],
    total: [:retrieve],
    webhooks_delivered_at: [:retrieve]
  }

  @nullable_keys []

  @doc """
  Create an invoice.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, @schema, opts)
  end

  @doc """
  Retrieve an invoice.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end

  @doc """
  Update an invoice.

  Takes the `id` and a map of changes.
  """
  @spec update(binary, map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, @schema, @nullable_keys, opts)
  end

  @doc """
  Retrieve an upcoming invoice.
  """
  @spec upcoming(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def upcoming(changes = %{customer: _customer}, opts \\ []) do
    endpoint = @plural_endpoint <> "/upcoming"
    Stripe.Request.retrieve(changes, endpoint, opts)
  end
end

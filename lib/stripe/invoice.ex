defmodule Stripe.Invoice do
  @moduledoc """
  Work with Stripe invoice objects.

  You can:

  - Create an invoice
  - Retrieve an invoice
  - Update an invoice

  Does not yet implement `lines`.

  Does not yet render lists or take options.

  Stripe API reference: https://stripe.com/docs/api#invoice
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :amount_due, :application_fee, :attempt_count, :attempted,
    :charge, :closed, :currency, :customer, :date, :description, :discount,
    :ending_balance, :forgiven, :livemode, :metadata,
    :next_payment_attempt, :paid, :period_end, :period_start, :receipt_number,
    :starting_balance, :statement_descriptor, :subscription,
    :subscription_proration_date, :subtotal, :tax, :tax_percent, :total,
    :webhooks_delivered_at
  ]

  @relationships %{}

  @plural_endpoint "invoices"

  @schema %{
    amount_due: [:receive],
    application_fee: [:create, :receive, :update],
    attempt_count: [:receive],
    attempted: [:receive],
    charge: [:receive],
    closed: [:receive],
    currency: [:receive],
    customer: [:receive],
    date: [:receive],
    description: [:create, :receive, :update],
    discount: [:receive],
    ending_balance: [:receive],
    forgiven: [:receive, :update],
    id: [:receive],
    livemode: [:receive],
    metadata: [:create, :receive, :update],
    next_payment_attempt: [:receive],
    paid: [:receive],
    period_end: [:receive],
    period_start: [:receive],
    receipt_number: [:receive],
    starting_balance: [:receive],
    statement_descriptor: [:receive, :update],
    subscription: [:create, :receive],
    subscription_proration_date: [:receive],
    subtotal: [:receive],
    tax: [:receive],
    tax_percent: [:create, :receive, :update],
    total: [:receive],
    webhooks_delivered_at: [:receive]
  }

  @nullable_keys []

  @doc """
  Returns a map of relationship keys and their Struct name.
  Relationships must be specified for the relationship to
  be returned as a struct.
  """
  @spec relationships :: Keyword.t
  def relationships, do: @relationships

  @doc """
  Create an invoice.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, @schema, __MODULE__, opts)
  end

  @doc """
  Retrieve an invoice.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, __MODULE__, opts)
  end

  @doc """
  Update an invoice.

  Takes the `id` and a map of changes.
  """
  @spec update(t, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, @schema, __MODULE__, @nullable_keys, opts)
  end
end

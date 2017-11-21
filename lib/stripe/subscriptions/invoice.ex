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

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
    id: Stripe.id,
    object: String.t,
    amount_due: integer,
    application_fee: integer | nil,
    attempt_count: non_neg_integer,
    attempted: boolean,
    charge: Stripe.id | Stripe.Charge.t | nil,
    closed: boolean,
    currency: String.t,
    customer: Stripe.id | Stripe.Customer.t,
    date: Stripe.timestamp,
    description: String.t | nil,
    discount: Stripe.Discount.t | nil,
    ending_balance: integer | nil,
    forgiven: boolean,
    lines: Stripe.List.of(Stripe.LineItem.t),
    livemode: boolean,
    metadata: Stripe.Types.metadata | nil,
    next_payment_attempt: Stripe.timestamp | nil,
    paid: boolean,
    period_end: Stripe.timestamp,
    period_start: Stripe.timestamp,
    receipt_number: String.t | nil,
    starting_balance: integer,
    statement_descriptor: String.t | nil,
    subscription: Stripe.id | Stripe.Subscription.t | nil,
    subscription_proration_date: Stripe.timestamp,
    subtotal: integer,
    tax: integer | nil,
    tax_percent: integer | nil,
    total: integer,
    webhooks_delivered_at: Stripe.timestamp | nil,
  }

  defstruct [
    :id,
    :object,
    :amount_due,
    :application_fee,
    :attempt_count,
    :attempted,
    :charge,
    :closed,
    :currency,
    :customer,
    :date,
    :description,
    :discount,
    :ending_balance,
    :forgiven,
    :lines,
    :livemode,
    :metadata,
    :next_payment_attempt,
    :paid,
    :period_end,
    :period_start,
    :receipt_number,
    :starting_balance,
    :statement_descriptor,
    :subscription,
    :subscription_proration_date,
    :subtotal,
    :tax,
    :tax_percent,
    :total,
    :webhooks_delivered_at
  ]

  @plural_endpoint "invoices"

  @doc """
  Create an invoice.
  """
  @spec create(params, Stripe.options) :: {:ok, t} | {:error, Stripe.Error.t}
        when params: %{
               application_fee: integer,
               description: String.t,
               metadata: %{
                 optional(String.t) => String.t
               },
               statement_descriptor: String.t,
               subscription: Stripe.id | Stripe.Subscription.t,
               tax_percent: integer | nil
             }
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> cast_to_id([:subscription])
    |> make_request()
  end

  @doc """
  Retrieve an invoice.
  """
  @spec retrieve(Stripe.id | t, Stripe.options) :: {:ok, t} | {:error, Stripe.Error.t}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update an invoice.

  Takes the `id` and a map of changes.
  """
  @spec update(Stripe.id | t, params, Stripe.options) :: {:ok, t} | {:error, Stripe.Error.t}
        when params: %{
               application_fee: integer,
               closed: boolean,
               description: String.t,
               forgiven: true,
               metadata: %{
                 optional(String.t) => String.t
               },
               statement_descriptor: String.t,
               tax_percent: integer | nil
             }
  def update(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  Retrieve an upcoming invoice.
  """
  @spec upcoming(map, Stripe.options) :: {:ok, t} | {:error, Stripe.Error.t}
  def upcoming(params = %{customer: _customer}, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/upcoming")
    |> put_method(:get)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  List all invoices.
  """
  @spec list(params, Stripe.options) :: {:ok, Stripe.List.of(t)} | {:error, Stripe.Error.t}
        when params: %{
               customer: Stripe.Customer.t | Stripe.id,
               date: Stripe.date_query,
               ending_before: t | Stripe.id,
               limit: 1..100,
               starting_after: t | Stripe.id,
               subscription: Stripe.Subscription.t | Stripe.id
             }
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:customer, :ending_before, :starting_after, :subscription])
    |> make_request()
  end

  @doc """
  Pay an invoice.
  """
  @spec pay(Stripe.id | t, params, Stripe.options) :: {:ok, t} | {:error, Stripe.Error.t}
        when params: %{
               source: Stripe.id | Stripe.Source.t | nil
             }
  def pay(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}/pay")
    |> put_method(:post)
    |> put_params(params)
    |> cast_to_id([:source])
    |> make_request()
  end
end

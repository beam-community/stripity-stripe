defmodule Stripe.Invoice do
  @moduledoc """
  Work with Stripe invoice objects.

  You can:

  - Create an invoice
  - Retrieve an invoice
  - Update an invoice
  - Void an invoice

  Does not take options yet.

  Stripe API reference: https://stripe.com/docs/api#invoice
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          account_country: String.t(),
          account_name: String.t(),
          amount_due: integer,
          amount_paid: integer,
          amount_remaining: integer,
          application_fee_amount: integer | nil,
          attempt_count: non_neg_integer,
          attempted: boolean,
          auto_advance: boolean,
          collection_method: String.t() | nil,
          billing_reason: String.t() | nil,
          charge: Stripe.id() | Stripe.Charge.t() | nil,
          currency: String.t(),
          customer_address: Stripe.Types.address() | nil,
          customer_email: String.t() | nil,
          customer_name: String.t() | nil,
          customer_phone: String.t() | nil,
          customer_shipping: Stripe.Types.shipping() | nil,
          customer_tax_exempt: String.t() | nil,
          customer_tax_ids: Stripe.List.t(map) | nil,
          custom_fields: custom_fields() | nil,
          customer: Stripe.id() | Stripe.Customer.t(),
          created: Stripe.timestamp(),
          default_payment_method: String.t() | nil,
          default_source: String.t() | nil,
          default_tax_rates: Stripe.List.t(map) | nil,
          description: String.t() | nil,
          discount: Stripe.Discount.t() | nil,
          due_date: Stripe.timestamp() | nil,
          ending_balance: integer | nil,
          finalized_at: Stripe.timestamp() | nil,
          footer: String.t() | nil,
          forgiven: boolean,
          hosted_invoice_url: String.t() | nil,
          invoice_pdf: String.t() | nil,
          lines: Stripe.List.t(Stripe.LineItem.t()),
          livemode: boolean,
          metadata: Stripe.Types.metadata() | nil,
          next_payment_attempt: Stripe.timestamp() | nil,
          number: String.t() | nil,
          paid: boolean,
          payment_intent: String.t() | nil,
          period_end: Stripe.timestamp(),
          period_start: Stripe.timestamp(),
          post_payment_credit_notes_amount: integer,
          pre_payment_credit_notes_amount: integer,
          receipt_number: String.t() | nil,
          starting_balance: integer,
          statement_descriptor: String.t() | nil,
          status: String.t() | nil,
          status_transitions: status_transitions() | nil,
          subscription: Stripe.id() | Stripe.Subscription.t() | nil,
          subscription_proration_date: Stripe.timestamp(),
          subtotal: integer,
          tax: integer | nil,
          tax_percent: number | nil,
          total_tax_amounts: Stripe.List.t(map) | nil,
          total: integer,
          webhooks_delivered_at: Stripe.timestamp() | nil
        }

  @type custom_fields ::
          list(%{
            name: String.t(),
            value: String.t()
          })

  @type invoice_settings :: %{
          default_payment_method: String.t() | nil,
          custom_fields: custom_fields | nil,
          footer: String.t() | nil
        }

  @type status_transitions ::
          list(%{
            finalized_at: Stripe.timestamp() | nil,
            marked_uncollectible_at: Stripe.timestamp() | nil,
            paid_at: Stripe.timestamp() | nil,
            voided_at: Stripe.timestamp() | nil
          })

  defstruct [
    :id,
    :object,
    :account_country,
    :account_name,
    :amount_due,
    :amount_paid,
    :amount_remaining,
    :application_fee_amount,
    :attempt_count,
    :attempted,
    :auto_advance,
    :collection_method,
    :billing_reason,
    :charge,
    :created,
    :customer_address,
    :customer_email,
    :customer_name,
    :customer_phone,
    :customer_shipping,
    :customer_tax_exempt,
    :customer_tax_ids,
    :currency,
    :custom_fields,
    :customer,
    :default_payment_method,
    :default_source,
    :default_tax_rates,
    :description,
    :discount,
    :due_date,
    :ending_balance,
    :finalized_at,
    :footer,
    :forgiven,
    :hosted_invoice_url,
    :invoice_pdf,
    :lines,
    :livemode,
    :metadata,
    :next_payment_attempt,
    :number,
    :paid,
    :payment_intent,
    :period_end,
    :period_start,
    :post_payment_credit_notes_amount,
    :pre_payment_credit_notes_amount,
    :receipt_number,
    :status,
    :status_transitions,
    :starting_balance,
    :statement_descriptor,
    :subscription,
    :subscription_proration_date,
    :subtotal,
    :tax,
    :tax_percent,
    :total_tax_amounts,
    :total,
    :webhooks_delivered_at
  ]

  @plural_endpoint "invoices"

  @doc """
  Create an invoice

  This endpoint creates a draft invoice for a given customer. The draft invoice
  created pulls in all pending invoice items on that customer, including
  prorations.

  See [Stripe docs](https://stripe.com/docs/api/invoices/update)
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:application_fee_amount) => integer,
                 optional(:auto_advance) => boolean,
                 optional(:collection_method) => String.t(),
                 :customer => Stripe.id() | Stripe.Customer.t(),
                 optional(:custom_fields) => custom_fields,
                 optional(:days_until_due) => integer,
                 optional(:default_payment_method) => String.t(),
                 optional(:default_source) => String.t(),
                 optional(:description) => String.t(),
                 optional(:due_date) => Stripe.timestamp(),
                 optional(:footer) => String.t(),
                 optional(:metadata) => Stripe.Types.metadata(),
                 optional(:statement_descriptor) => String.t(),
                 optional(:subscription) => Stripe.id() | Stripe.Subscription.t(),
                 optional(:tax_percent) => number
               }
               | %{}
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

  Retrieves the invoice with the given ID.

  See [Stripe docs](https://stripe.com/docs/api/invoices/retrieve)
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update an invoice.

  Takes the `id` and a map of changes. Draft invoices are fully editable. Once
  an invoice is finalized, monetary values, as well as collection_method, become
  uneditable.

  See [Stripe docs](https://stripe.com/docs/api/invoices/update)
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:application_fee_amount) => integer,
                 optional(:auto_advance) => boolean,
                 optional(:custom_fields) => custom_fields,
                 optional(:days_until_due) => integer,
                 optional(:default_payment_method) => String.t(),
                 optional(:default_source) => String.t(),
                 optional(:description) => String.t(),
                 optional(:due_date) => Stripe.timestamp(),
                 optional(:footer) => String.t(),
                 optional(:forgiven) => boolean,
                 optional(:metadata) => Stripe.Types.metadata(),
                 optional(:paid) => boolean,
                 optional(:statement_descriptor) => String.t(),
                 optional(:tax_percent) => number
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
  Retrieve an upcoming invoice

  At any time, you can preview the upcoming invoice for a customer. This will
  show you all the charges that are pending, including subscription renewal
  charges, invoice item charges, etc. It will also show you any discount that is
  applicable to the customer.

  See [Stripe docs](https://stripe.com/docs/api/invoices/upcoming)
  """
  @spec upcoming(map, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def upcoming(params, opts \\ [])
  def upcoming(params = %{customer: _customer}, opts), do: get_upcoming(params, opts)
  def upcoming(params = %{subscription: _subscription}, opts), do: get_upcoming(params, opts)

  defp get_upcoming(params, opts) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/upcoming")
    |> put_method(:get)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  List all invoices

  You can list all invoices, or list the invoices for a specific customer. The
  invoices are returned sorted by creation date, with the most recently created
  invoices appearing first.

  See [Stripe docs](https://stripe.com/docs/api/invoices/list)
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:collection_method) => String.t(),
                 optional(:customer) => Stripe.id() | Stripe.Customer.t(),
                 optional(:created) => Stripe.date_query(),
                 optional(:due_date) => Stripe.timestamp(),
                 optional(:ending_before) => t | Stripe.id(),
                 optional(:limit) => 1..100,
                 optional(:starting_after) => t | Stripe.id(),
                 optional(:subscription) => Stripe.id() | Stripe.Subscription.t()
               }
               | %{}
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:customer, :ending_before, :starting_after, :subscription])
    |> make_request()
  end

  @doc """
  Finalize an invoice

  Stripe automatically finalizes drafts before sending and attempting payment on
  invoices. However, if you’d like to finalize a draft invoice manually, you can
  do so using this method.

  See [Stripe docs](https://stripe.com/docs/api/invoices/finalize)
  """
  @spec finalize(Stripe.id() | t, params, Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 :id => String.t(),
                 optional(:auto_advance) => boolean
               }
               | %{}
  def finalize(id, params, opts \\ []) do
    new_request(opts)
    |> prefix_expansions()
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}/finalize")
    |> put_method(:post)
    |> put_params(params)
    |> cast_to_id([:source])
    |> make_request()
  end

  @doc """
  Pay an invoice

  Stripe automatically creates and then attempts to collect payment on invoices
  for customers on subscriptions according to your subscriptions settings.
  However, if you’d like to attempt payment on an invoice out of the normal
  collection schedule or for some other reason, you can do so.

  See [Stripe docs](https://stripe.com/docs/api/invoices/delete)
  """
  @spec pay(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 :id => String.t(),
                 optional(:forgive) => boolean,
                 optional(:paid_out_of_band) => boolean,
                 optional(:payment_method) => String.t(),
                 optional(:source) => Stripe.id() | Stripe.Source.t()
               }
               | %{}
  def pay(id, params, opts \\ []) do
    new_request(opts)
    |> prefix_expansions()
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}/pay")
    |> put_method(:post)
    |> put_params(params)
    |> cast_to_id([:source])
    |> make_request()
  end

  @doc """
  Void an invoice

  Mark a finalized invoice as void. This cannot be undone. Voiding an invoice is
  similar to deletion, however it only applies to finalized invoices and
  maintains a papertrail where the invoice can still be found.

  See [Stripe docs](https://stripe.com/docs/api/invoices/void)
  """
  @spec void(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def void(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}/void")
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Send an invoice

  Stripe will automatically send invoices to customers according to your
  subscriptions settings. However, if you’d like to manually send an invoice to
  your customer out of the normal schedule, you can do so. When sending invoices
  that have already been paid, there will be no reference to the payment in the
  email.

  Requests made in test-mode result in no emails being sent, despite sending an
  `invoice.sent` event.


  See [Stripe docs](https://stripe.com/docs/api/invoices/send)
  """
  @spec send(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def send(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}/send")
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Delete an invoice

  Permanently deletes a draft invoice. This cannot be undone. Attempts to delete
  invoices that are no longer in a draft state will fail; once an invoice has
  been finalized, it must be voided.

  ## Example

      {:ok, _} = Stripe.Invoice.delete("in_16vEXC2eZvKYlo2CU9MyflAA")

      {:ok, _} = Stripe.Invoice.delete(%Stripe.Invoice{id: "in_16vEXC2eZvKYlo2CU9MyflAA"})

  See [Stripe docs](https://stripe.com/docs/api/invoices/delete)
  """
  @spec delete(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def delete(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:delete)
    |> make_request()
  end

  @doc """
  Mark an invoice as uncollectible

  Marking an invoice as uncollectible is useful for keeping track of bad debts
  that can be written off for accounting purposes.

  ## Example

      {:ok, _} = Stripe.Invoice.mark_as_uncollectible("in_16vEXC2eZvKYlo2CU9MyflAA")

      {:ok, _} = Stripe.Invoice.mark_as_uncollectible(%Stripe.Invoice{id: "in_16vEXC2eZvKYlo2CU9MyflAA"})

  See [Stripe docs](https://stripe.com/docs/api/invoices/mark_uncollectible)
  """
  @spec mark_as_uncollectible(Stripe.id() | t, Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
  def mark_as_uncollectible(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}/mark_uncollectible")
    |> put_method(:post)
    |> make_request()
  end
end

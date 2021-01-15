defmodule Stripe.Subscription do
  @moduledoc """
  Work with Stripe subscription objects.

  You can:

  - Create a subscription
  - Retrieve a subscription
  - Update a subscription
  - Delete a subscription

  Stripe API reference: https://stripe.com/docs/api#subscription
  """

  use Stripe.Entity
  import Stripe.Request
  import Stripe.Util, only: [log_deprecation: 1]

  @type pause_collection :: %{
          behavior: String.t(),
          resumes_at: Stripe.timestamp()
        }

  @type pending_invoice_item_interval :: %{
          interval: String.t(),
          interval_count: integer
        }

  @type pending_update :: %{
          billing_cycle_anchor: Stripe.timestamp(),
          expires_at: Stripe.timestamp(),
          subscription_items: [Stripe.SubscriptionItem.t()],
          trial_end: Stripe.timestamp(),
          trial_from_plan: boolean
        }

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          application_fee_percent: float | nil,
          billing_cycle_anchor: Stripe.timestamp() | nil,
          billing_thresholds: map | nil,
          collection_method: String.t() | nil,
          collection_method_cycle_anchor: Stripe.timestamp() | nil,
          collection_method_thresholds: Stripe.Types.collection_method_thresholds() | nil,
          cancel_at: Stripe.timestamp() | nil,
          cancel_at_period_end: boolean,
          canceled_at: Stripe.timestamp() | nil,
          created: Stripe.timestamp(),
          current_period_end: Stripe.timestamp() | nil,
          current_period_start: Stripe.timestamp() | nil,
          customer: Stripe.id() | Stripe.Customer.t(),
          days_until_due: integer | nil,
          default_payment_method: Stripe.id() | Stripe.PaymentMethod.t() | nil,
          default_source: Stripe.id() | Stripe.Source.t() | nil,
          default_tax_rates: list(Stripe.TaxRate),
          discount: Stripe.Discount.t() | nil,
          ended_at: Stripe.timestamp() | nil,
          items: Stripe.List.t(Stripe.SubscriptionItem.t()),
          latest_invoice: Stripe.id() | Stripe.Invoice.t() | nil,
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          next_pending_invoice_item_invoice: Stripe.timestamp() | nil,
          pending_invoice_item_interval: pending_invoice_item_interval() | nil,
          pending_setup_intent: Stripe.SetupIntent.t() | nil,
          pending_update: pending_update() | nil,
          plan: Stripe.Plan.t() | nil,
          pause_collection: pause_collection() | nil,
          quantity: integer | nil,
          schedule: String.t() | nil,
          start_date: Stripe.timestamp(),
          status: String.t(),
          tax_percent: float | nil,
          trial_end: Stripe.timestamp() | nil,
          trial_start: Stripe.timestamp() | nil
        }

  defstruct [
    :id,
    :object,
    :application_fee_percent,
    :billing_cycle_anchor,
    :billing_thresholds,
    :collection_method,
    :collection_method_cycle_anchor,
    :collection_method_thresholds,
    :cancel_at,
    :cancel_at_period_end,
    :canceled_at,
    :created,
    :current_period_end,
    :current_period_start,
    :customer,
    :days_until_due,
    :default_payment_method,
    :default_source,
    :default_tax_rates,
    :discount,
    :ended_at,
    :items,
    :latest_invoice,
    :livemode,
    :metadata,
    :next_pending_invoice_item_invoice,
    :pending_invoice_item_interval,
    :pending_setup_intent,
    :pending_update,
    :plan,
    :pause_collection,
    :quantity,
    :schedule,
    :start_date,
    :status,
    :tax_percent,
    :trial_end,
    :trial_start
  ]

  @plural_endpoint "subscriptions"

  @doc """
  Create a subscription.
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               :customer => Stripe.id() | Stripe.Customer.t(),
               optional(:application_fee_percent) => integer,
               optional(:billing_cycle_anchor) => Stripe.timestamp(),
               optional(:billing_thresholds) => map,
               optional(:collection_method) => String.t(),
               optional(:collection_method_cycle_anchor) => Stripe.timestamp(),
               optional(:cancel_at) => Stripe.timestamp(),
               optional(:cancel_at_period_end) => boolean,
               optional(:collection_method) => String.t(),
               optional(:coupon) => Stripe.id() | Stripe.Coupon.t(),
               optional(:days_until_due) => non_neg_integer,
               :items => [
                 %{
                   optional(:plan) => Stripe.id() | Stripe.Plan.t(),
                   optional(:price) => Stripe.id() | Stripe.Price.t(),
                   optional(:billing_methods) => map,
                   optional(:metadata) => map,
                   optional(:quantity) => non_neg_integer,
                   optional(:tax_rates) => list
                 }
               ],
               optional(:default_payment_method) => Stripe.id(),
               optional(:default_tax_rates) => [Stripe.id()],
               optional(:metadata) => Stripe.Types.metadata(),
               optional(:prorate) => boolean,
               optional(:proration_behavior) => String.t(),
               optional(:promotion_code) => Stripe.id(),
               optional(:tax_percent) => float,
               optional(:trial_end) => Stripe.timestamp(),
               optional(:trial_from_plan) => boolean,
               optional(:trial_period_days) => non_neg_integer
             }
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> cast_to_id([:coupon, :customer])
    |> make_request()
  end

  @doc """
  Retrieve a subscription.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a subscription.

  Takes the `id` and a map of changes.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:application_fee_percent) => float,
               optional(:billing_cycle_anchor) => Stripe.timestamp(),
               optional(:billing_thresholds) => map,
               optional(:collection_method) => String.t(),
               optional(:collection_method_cycle_anchor) => Stripe.timestamp(),
               optional(:cancel_at) => Stripe.timestamp(),
               optional(:cancel_at_period_end) => boolean(),
               optional(:collection_method) => String.t(),
               optional(:coupon) => Stripe.id() | Stripe.Coupon.t(),
               optional(:days_until_due) => non_neg_integer,
               optional(:items) => [
                 %{
                   optional(:id) => Stripe.id() | binary(),
                   optional(:plan) => Stripe.id() | Stripe.Plan.t(),
                   optional(:price) => Stripe.id() | Stripe.Price.t(),
                   optional(:billing_methods) => map,
                   optional(:metadata) => map,
                   optional(:quantity) => non_neg_integer,
                   optional(:tax_rates) => list
                 }
               ],
               optional(:default_payment_method) => Stripe.id(),
               optional(:default_tax_rates) => [Stripe.id()],
               optional(:metadata) => Stripe.Types.metadata(),
               optional(:prorate) => boolean,
               optional(:proration_behavior) => String.t(),
               optional(:proration_date) => Stripe.timestamp(),
               optional(:tax_percent) => float,
               optional(:trial_end) => Stripe.timestamp(),
               optional(:trial_from_plan) => boolean
             }
  def update(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> cast_to_id([:coupon])
    |> make_request()
  end

  @doc """
  Delete a subscription.

  Takes the subscription `id` or a `Stripe.Subscription` struct.
  """
  @spec delete(Stripe.id() | t) :: {:ok, t} | {:error, Stripe.Error.t()}
  def delete(id), do: delete(id, %{}, [])

  @doc """
  Delete a subscription.

  Takes the subscription `id` or a `Stripe.Subscription` struct.

  Second argument can be a map of cancellation `params`, such as `invoice_now`,
  or a list of options, such as custom API key.

  ### Deprecated Usage

  Passing a map with `at_period_end: true` to `Subscription.delete/2`
  is deprecated.  Use `Subscription.update/2` with
  `cancel_at_period_end: true` instead.
  """

  @spec delete(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def delete(id, opts) when is_list(opts) do
    delete(id, %{}, opts)
  end

  @spec delete(Stripe.id() | t, %{at_period_end: true}) :: {:ok, t} | {:error, Stripe.Error.t()}
  def delete(id, %{at_period_end: true}) do
    log_deprecation("Use Stripe.Subscription.update/2 with `cancel_at_period_end: true`")
    update(id, %{cancel_at_period_end: true})
  end

  @spec delete(Stripe.id() | t, params) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:invoice_now) => boolean,
               optional(:prorate) => boolean
             }
  def delete(id, params) when is_map(params) do
    delete(id, params, [])
  end

  @doc """
  Delete a subscription.

  Takes the subscription `id` or a `Stripe.Subscription` struct.

  Second argument is a map of cancellation `params`, such as `invoice_now`.

  Third argument is a list of options, such as custom API key.
  """
  @spec delete(Stripe.id() | t, %{at_period_end: true}, Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
  def delete(id, %{at_period_end: true}, opts) do
    log_deprecation("Use Stripe.Subscription.update/2 with `cancel_at_period_end: true`")
    update(id, %{cancel_at_period_end: true}, opts)
  end

  @spec delete(Stripe.id() | t, params, Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:invoice_now) => boolean,
               optional(:prorate) => boolean
             }
  def delete(id, params, opts) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:delete)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  List all subscriptions.
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:collection_method) => String.t(),
               optional(:created) => Stripe.date_query(),
               optional(:customer) => Stripe.Customer.t() | Stripe.id(),
               optional(:ending_before) => t | Stripe.id(),
               optional(:limit) => 1..100,
               optional(:plan) => Stripe.Plan.t() | Stripe.id(),
               optional(:price) => Stripe.Price.t() | Stripe.id(),
               optional(:starting_after) => t | Stripe.id(),
               optional(:status) => String.t()
             }
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> prefix_expansions()
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:customer, :ending_before, :plan, :price, :starting_after])
    |> make_request()
  end

  @doc """
  Deletes the discount on a subscription.
  """
  @spec delete_discount(Stripe.id() | t, Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
  def delete_discount(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}/discount")
    |> put_method(:delete)
    |> make_request()
  end
end

defmodule Stripe.SubscriptionSchedule do
  @moduledoc """
  Work with Stripe subscription schedule objects.

  """

  use Stripe.Entity
  import Stripe.Request

  @type plans :: %{
          plan: String.t(),
          quantity: pos_integer
        }

  @type phases :: %{
          application_fee_percent: float | nil,
          end_date: Stripe.timestamp(),
          start_date: Stripe.timestamp(),
          tax_percent: float | nil,
          trial_end: Stripe.timestamp(),
          plans: list(plans)
        }

  @type default_settings :: %{
          billing_thresholds: Stripe.Types.collection_method_thresholds() | nil,
          collection_method: String.t(),
          default_payment_method: Stripe.id() | Stripe.PaymentMethod.t(),
          invoice_settings: %{
            days_until_due: integer
          }
        }

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          created: Stripe.timestamp(),
          canceled_at: Stripe.timestamp() | nil,
          released_at: Stripe.timestamp() | nil,
          completed_at: Stripe.timestamp() | nil,
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          default_settings: default_settings,
          current_phase: %{
            start_date: Stripe.timestamp(),
            end_date: Stripe.timestamp()
          },
          end_behavior: String.t(),
          revision: String.t(),
          status: String.t(),
          subscription: Stripe.id() | Stripe.Subscription.t(),
          customer: Stripe.id() | Stripe.Customer.t(),
          released_subscription: Stripe.id() | Stripe.Subscription.t() | nil,
          phases: list(phases)
        }

  defstruct [
    :id,
    :object,
    :created,
    :canceled_at,
    :completed_at,
    :current_phase,
    :customer,
    :phases,
    :released_at,
    :released_subscription,
    :status,
    :subscription,
    :default_settings,
    :livemode,
    :metadata,
    :end_behavior,
    :revision
  ]

  @plural_endpoint "subscription_schedules"

  @doc """
  Create a subscription schedule.

  ### Examples

  # Create subscription schedule from existing subscription
  Stripe.SubscriptionSchedule.create(%{from_subscription: "sub_1234"})

  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:customer) => Stripe.id(),
               optional(:from_subscription) => Stripe.id(),
               optional(:default_settings) => %{
                 optional(:collection_method) => String.t(),
                 optional(:default_payment_method) => Stripe.id(),
                 optional(:invoice_settings) => %{
                   optional(:days_until_due) => non_neg_integer
                 }
               },
               optional(:phases) => [
                 %{
                   :plans => [
                     %{
                       :plan => Stripe.id() | Stripe.Plan.t(),
                       optional(:quantity) => non_neg_integer
                     }
                   ],
                   optional(:application_fee_percent) => non_neg_integer,
                   optional(:coupon) => String.t(),
                   optional(:end_date) => Stripe.timestamp(),
                   optional(:iterations) => non_neg_integer,
                   optional(:start_date) => Stripe.timestamp(),
                   optional(:tax_percent) => float,
                   optional(:trial) => boolean(),
                   optional(:trial_end) => Stripe.timestamp()
                 }
               ],
               optional(:end_behavior) => String.t(),
               optional(:start_date) => Stripe.timestamp()
             }
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Retrieve a subscription schedule.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a subscription schedule.
  Takes the `id` and a map of changes.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:default_settings) => %{
                 optional(:collection_method) => String.t(),
                 optional(:default_payment_method) => Stripe.id(),
                 optional(:invoice_settings) => %{
                   optional(:days_until_due) => non_neg_integer
                 }
               },
               optional(:phases) => [
                 %{
                   :plans => [
                     %{
                       :plan => Stripe.id() | Stripe.Plan.t(),
                       optional(:quantity) => non_neg_integer
                     }
                   ],
                   optional(:application_fee_percent) => non_neg_integer,
                   optional(:coupon) => String.t(),
                   optional(:end_date) => Stripe.timestamp(),
                   optional(:iterations) => non_neg_integer,
                   optional(:start_date) => Stripe.timestamp(),
                   optional(:tax_percent) => float,
                   optional(:trial) => boolean(),
                   optional(:trial_end) => Stripe.timestamp()
                 }
               ],
               optional(:end_behavior) => String.t(),
               optional(:prorate) => boolean()
             }
  def update(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  Cancels a subscription schedule and its associated subscription immediately
  (if the subscription schedule has an active subscription). A subscription
  schedule can only be canceled if its status is not_started or active.

  Takes the subscription schedule `id`.
  """

  @spec cancel(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def cancel(id, opts \\ []) when is_list(opts) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}/cancel")
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Releases a subscription schedule

  Takes the subscription schedule `id`.
  """

  @spec release(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def release(id, opts \\ []) when is_list(opts) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}/release")
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Retrieves the list of your subscription schedules.
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:canceled_at) => Stripe.date_query(),
               optional(:completed_at) => Stripe.date_query(),
               optional(:created) => Stripe.date_query(),
               optional(:customer) => Stripe.Customer.t() | Stripe.id(),
               optional(:ending_before) => t | Stripe.id(),
               optional(:limit) => 1..100,
               optional(:released_at) => Stripe.date_query(),
               optional(:scheduled) => boolean(),
               optional(:starting_after) => t | Stripe.id()
             }
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> prefix_expansions()
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> make_request()
  end
end

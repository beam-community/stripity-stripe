defmodule Stripe.Session do
  @moduledoc """
  Work with Stripe Checkout Session objects.

  You can:

  - Create a new session
  - Retrieve a session

  Stripe API reference: https://stripe.com/docs/api/checkout/sessions
  """

  use Stripe.Entity
  import Stripe.Request

  @type line_item :: %{
          :amount => integer(),
          :currency => String.t(),
          :name => String.t(),
          :quantity => integer(),
          optional(:description) => String.t(),
          optional(:images) => list(String.t())
        }

  @type capture_method :: :automatic | :manual

  @type transfer_data :: %{
          :destination => String.t()
        }

  @type payment_intent_data :: %{
          optional(:application_fee_amount) => integer(),
          optional(:capture_method) => capture_method,
          optional(:description) => String.t(),
          optional(:metadata) => Stripe.Types.metadata(),
          optional(:on_behalf_of) => String.t(),
          optional(:receipt_email) => String.t(),
          optional(:shipping) => Stripe.Types.shipping(),
          optional(:statement_descriptor) => String.t(),
          optional(:transfer_data) => transfer_data
        }

  @type item :: %{
          :plan => String.t(),
          optional(:quantity) => integer()
        }

  @type subscription_data :: %{
          :items => list(item),
          :metadata => Stripe.Types.metadata(),
          :trial_end => integer(),
          :trial_period_days => integer()
        }

  @type create_params :: %{
          :cancel_url => String.t(),
          :payment_method_types => list(String.t()),
          :success_url => String.t(),
          optional(:client_reference_id) => String.t(),
          optional(:customer_email) => String.t(),
          optional(:line_items) => list(line_item),
          optional(:locale) => String.t(),
          optional(:payment_intent_data) => payment_intent_data,
          optional(:subscription_data) => subscription_data
        }

  @type t :: %__MODULE__{
          :id => Stripe.id(),
          :object => String.t(),
          :billing_address_collection => String.t(),
          :cancel_url => boolean(),
          :client_reference_id => String.t(),
          :customer => Stripe.id() | Stripe.Customer.t() | nil,
          :customer_email => String.t(),
          :display_items => list(line_item),
          :livemode => boolean(),
          :locale => boolean(),
          :mode => String.t(),
          :payment_intent => Stripe.id() | Stripe.PaymentIntent.t() | nil,
          :payment_method_types => list(String.t()),
          :setup_intent => Stripe.id() | Stripe.SetupIntent.t() | nil,
          :submit_type => String.t(),
          :subscription => Stripe.id() | Stripe.Subscription.t() | nil,
          :success_url => String.t()
        }

  defstruct [
    :id,
    :object,
    :billing_address_collection,
    :cancel_url,
    :client_reference_id,
    :customer,
    :customer_email,
    :display_items,
    :livemode,
    :locale,
    :mode,
    :payment_intent,
    :payment_method_types,
    :setup_intent,
    :submit_type,
    :subscription,
    :success_url
  ]

  @plural_endpoint "checkout/sessions"

  @spec create(create_params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Retrieve a session.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end
end

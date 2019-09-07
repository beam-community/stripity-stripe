defmodule Stripe.SetupIntent do
  @moduledoc """
  A [SetupIntent](https://stripe.com/docs/api/setup_intents) guides you through
  the process of setting up a customer's payment credentials for future payments.

   You can:
  - [Create a SetupIntent](https://stripe.com/docs/api/setup_intents/create)
  - [Retrieve a SetupIntent](https://stripe.com/docs/api/setup_intents/retrieve)
  - [Update a SetupIntent](https://stripe.com/docs/api/setup_intents/update)
  - [Confirm a SetupIntent](https://stripe.com/docs/api/setup_intents/confirm)
  - [Cancel a SetupIntent](https://stripe.com/docs/api/setup_intents/cancel)
  - [List all SetupIntents](https://stripe.com/docs/api/setup_intents/list)
  """

  use Stripe.Entity
  import Stripe.Request
  require Stripe.Util

  @type last_setup_error :: %{
          code: String.t(),
          decline_code: String.t(),
          doc_url: String.t(),
          message: String.t(),
          param: String.t(),
          payment_method: map,
          type: String.t()
        }

  @type next_action :: %{
          redirect_to_url: redirect_to_url | nil,
          type: String.t(),
          use_stripe_sdk: map | nil
        }

  @type redirect_to_url :: %{
          return_url: String.t(),
          url: String.t()
        }

  @type payment_method_options_card :: %{
          request_three_d_secure: String.t()
        }

  @type payment_method_options :: %{
          card: payment_method_options_card | nil
        }

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          application: Stripe.id() | nil,
          cancellation_reason: String.t() | nil,
          client_secret: String.t(),
          created: Stripe.timestamp(),
          customer: Stripe.id() | Stripe.Customer.t() | nil,
          description: String.t() | nil,
          last_setup_error: last_setup_error | nil,
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          next_action: next_action | nil,
          on_behalf_of: Stripe.id() | Stripe.Account.t() | nil,
          payment_method: Stripe.id() | Stripe.PaymentMethod.t() | nil,
          payment_method_options: payment_method_options | nil,
          payment_method_types: list(String.t()),
          status: String.t(),
          usage: String.t()
        }

  defstruct [
    :id,
    :object,
    :application,
    :cancellation_reason,
    :client_secret,
    :created,
    :customer,
    :description,
    :last_setup_error,
    :livemode,
    :metadata,
    :next_action,
    :on_behalf_of,
    :payment_method,
    :payment_method_options,
    :payment_method_types,
    :status,
    :usage
  ]

  @plural_endpoint "setup_intents"

  @doc """
  Creates a SetupIntent object.
  See the [Stripe docs](https://stripe.com/docs/api/setup_intents/create).
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:confirm) => boolean,
                 optional(:customer) => Stripe.id() | Stripe.Customer.t(),
                 optional(:description) => String.t(),
                 optional(:metadata) => map,
                 optional(:on_behalf_of) => Stripe.id() | Stripe.Account.t(),
                 optional(:payment_method) => Stripe.id(),
                 optional(:payment_method_options) => payment_method_options,
                 optional(:payment_method_types) => [String.t()],
                 optional(:return_url) => String.t(),
                 optional(:usage) => String.t()
               }
               | %{}
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> cast_to_id([:on_behalf_of, :customer, :payment_method])
    |> make_request()
  end

  @doc """
  Retrieves the details of a SetupIntent that has previously been created.
  See the [Stripe docs](https://stripe.com/docs/api/setup_intents/retrieve).
  """
  @spec retrieve(Stripe.id() | t, params, Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:client_secret) => String.t()
               }
               | %{}
  def retrieve(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_params(params)
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Updates a SetupIntent object.
  See the [Stripe docs](https://stripe.com/docs/api/setup_intents/update).
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:customer) => Stripe.id() | Stripe.Customer.t(),
                 optional(:description) => String.t(),
                 optional(:metadata) => map,
                 optional(:payment_method) => Stripe.id(),
                 optional(:payment_method_types) => [String.t()]
               }
               | %{}
  def update(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> cast_to_id([:customer, :payment_method])
    |> make_request()
  end

  @doc """
  Confirm that your customer intends to set up the current or provided payment method.
  See the [Stripe docs](https://stripe.com/docs/api/setup_intents/confirm).
  """
  @spec confirm(Stripe.id() | t, params, Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:payment_method) => Stripe.id(),
                 optional(:payment_method_options) => payment_method_options,
                 optional(:return_url) => String.t()
               }
               | %{}
  def confirm(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}" <> "/confirm")
    |> put_method(:post)
    |> put_params(params)
    |> cast_to_id([:payment_method])
    |> make_request()
  end

  @doc """
  A SetupIntent object can be canceled when it is in one of these statuses:
  `requires_payment_method`, `requires_capture`, `requires_confirmation`, `requires_action`.
  See the [Stripe docs](https://stripe.com/docs/api/setup_intents/cancel).
  """
  @spec cancel(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:cancellation_reason) => String.t()
               }
               | %{}
  def cancel(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}" <> "/cancel")
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  Returns a list of SetupIntents.
  See the [Stripe docs](https://stripe.com/docs/api/setup_intents/list).
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:created) => Stripe.date_query(),
               optional(:customer) => Stripe.id() | Stripe.Customer.t(),
               optional(:ending_before) => t | Stripe.id(),
               optional(:limit) => 1..100,
               optional(:starting_after) => t | Stripe.id()
             }
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> prefix_expansions()
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:customer, :ending_before, :starting_after])
    |> make_request()
  end
end

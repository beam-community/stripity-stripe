defmodule Stripe.PaymentMethod do
  @moduledoc """
  Work with Stripe payment method objects.

  Stripe API reference: https://stripe.com/docs/api/payment_methods
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          billing_details: %{
            address: Stripe.Types.address(),
            email: String.t() | nil,
            name: String.t() | nil,
            phone: String.t() | nil
          },
          card: Stripe.Card.t() | nil,
          created: Stripe.timestamp(),
          customer: Stripe.id() | Stripe.Customer.t() | nil,
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          type: String.t()
        }

  defstruct [
    :id,
    :object,
    :billing_details,
    :card,
    :created,
    :customer,
    :livemode,
    :metadata,
    :type
  ]

  defp plural_endpoint() do
    "payment_methods"
  end

  defp plural_endpoint(%{payment_method: payment_method}) do
    plural_endpoint() <> "/" <> get_id!(payment_method)
  end

  @type billing_details :: %{
          optional(:address) => Stripe.Types.address(),
          optional(:email) => String.t(),
          optional(:name) => String.t(),
          optional(:phone) => String.t()
        }

  @type card :: %{
          :exp_month => integer,
          :exp_year => integer,
          :number => String.t(),
          :cvc => String.t()
        }

  @doc """
  Create a payment method.
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               :type => String.t(),
               optional(:billing_details) => billing_details(),
               optional(:card) => card(),
               optional(:metadata) => Stripe.Types.metadata()
             }
  def create(%{} = params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(plural_endpoint())
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Retrieve a payment method.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(plural_endpoint() <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a card.

  Takes the `id` and a map of changes
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:billing_details) => billing_details(),
               optional(:card) => card(),
               optional(:metadata) => Stripe.Types.metadata()
             }
  def update(id, %{} = params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(plural_endpoint() <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  List all payment methods.
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{
               :customer => Stripe.id() | Stripe.Customer.t(),
               :type => String.t(),
               optional(:ending_before) => t | Stripe.id(),
               optional(:limit) => 1..100,
               optional(:starting_after) => t | Stripe.id()
             }
  def list(%{customer: _} = params, opts \\ []) do
    endpoint = plural_endpoint()

    new_request(opts)
    |> put_endpoint(endpoint)
    |> put_method(:get)
    |> put_params(params |> Map.update!(:customer, &get_id!/1))
    |> make_request()
  end

  @doc """
  Attach payment_method to customer
  """
  @spec attach(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               :customer => Stripe.id() | Stripe.Customer.t(),
               :payment_method => Stripe.id() | t()
             }
  def attach(%{customer: customer, payment_method: _} = params, opts \\ []) do
    endpoint = plural_endpoint(params) <> "/attach"

    new_request(opts)
    |> put_endpoint(endpoint)
    |> put_method(:post)
    |> put_params(%{customer: get_id!(customer)})
    |> make_request()
  end

  @doc """
  Detach payment_method from customer
  """
  @spec detach(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{:payment_method => Stripe.id() | t()}
  def detach(%{payment_method: _} = params, opts \\ []) do
    endpoint = plural_endpoint(params) <> "/detach"

    new_request(opts)
    |> put_endpoint(endpoint)
    |> put_method(:post)
    |> make_request()
  end
end

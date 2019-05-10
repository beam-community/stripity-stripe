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
  Dettach payment_method from customer
  """
  @spec dettach(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{:payment_method => Stripe.id() | t()}
  def dettach(%{payment_method: _} = params, opts \\ []) do
    endpoint = plural_endpoint(params) <> "/detach"

    new_request(opts)
    |> put_endpoint(endpoint)
    |> put_method(:post)
    |> make_request()
  end
end

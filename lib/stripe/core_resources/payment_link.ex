defmodule Stripe.PaymentLink do
  @moduledoc """
  Work with [Stripe `payment_link` objects](https://stripe.com/docs/payments/payment-links/api).
   You can:
  - [Create a payment_link](https://stripe.com/docs/api/payment_links/payment_links/create)
  - [Retrieve a payment_link](https://stripe.com/docs/api/payment_links/payment_links/retrieve)
  - [Update a payment_link](https://stripe.com/docs/api/payment_links/payment_links/update)
  - [List all payment_link](https://stripe.com/docs/api/payment_links/payment_links/list)
  - [Retrieve a payment_link's line items](https://stripe.com/docs/api/payment_links/line_items)
  """

  use Stripe.Entity
  import Stripe.Request
  require Stripe.Util

  @type after_completion :: %{
          hosted_confirmation: map,
          redirect: map,
          type: list(String.t())
        }

  @type transfer_data :: %{
          destination: String.t()
        }

  @type line_items :: %{
          price: Stripe.id(),
          quantity: non_neg_integer,
          adjustable_quantity: map()
        }

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          active: boolean,
          after_completion: after_completion,
          allow_promotion_codes: boolean,
          application_fee_amount: non_neg_integer | nil,
          application_fee_percent: non_neg_integer | nil,
          automatic_tax: map,
          billing_address_collection: list(String.t()),
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          on_behalf_of: String.t() | nil,
          payment_method_types: list(String.t()) | nil,
          phone_number_collection: map,
          shipping_address_collection: map | nil,
          subscription_data: map | nil,
          transfer_data: transfer_data | nil,
          url: String.t()
        }

  defstruct [
    :id,
    :object,
    :active,
    :after_completion,
    :allow_promotion_codes,
    :application_fee_amount,
    :application_fee_percent,
    :automatic_tax,
    :billing_address_collection,
    :livemode,
    :metadata,
    :on_behalf_of,
    :payment_method_types,
    :phone_number_collection,
    :shipping_address_collection,
    :subscription_data,
    :transfer_data,
    :url
  ]

  @plural_endpoint "payment_links"

  @doc """
  Creates a payment link.
  """
  @spec create(params) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 :line_items => [line_items],
                 optional(:metadata) => map,
                 optional(:payment_method_types) => [String.t()],
                 optional(:after_completion) => after_completion,
                 optional(:allow_promotion_codes) => boolean,
                 optional(:application_fee_amount) => pos_integer(),
                 optional(:application_fee_percent) => pos_integer(),
                 optional(:automatic_tax) => map(),
                 optional(:billing_address_collection) => [String.t()],
                 optional(:on_behalf_of) => map(),
                 optional(:phone_number_collection) => map(),
                 optional(:shipping_address_collection) => map(),
                 optional(:subscription_data) => map(),
                 optional(:transfer_data) => transfer_data
               }
               | %{}
  def create(params) do
    new_request()
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> cast_to_id([:on_behalf_of])
    |> make_request()
  end

  @doc """
  Retrieves the details of a PaymentLink that has previously been created.
  """
  @spec retrieve(Stripe.id()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id) do
    new_request()
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Updates a PaymentLink object.
  """
  @spec update(Stripe.id() | t, params) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:active) => boolean,
                 optional(:line_items) => [line_items],
                 optional(:metadata) => map,
                 optional(:payment_method_types) => [String.t()],
                 optional(:after_completion) => after_completion,
                 optional(:allow_promotion_codes) => boolean,
                 optional(:automatic_tax) => map(),
                 optional(:billing_address_collection) => [String.t()],
                 optional(:shipping_address_collection) => map()
               }
               | %{}
  def update(id, params) do
    new_request()
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  Returns a list of PaymentLinks.
  """
  @spec list(params) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:active) => boolean,
               optional(:ending_before) => Stripe.id(),
               optional(:limit) => pos_integer(),
               optional(:starting_after) => Stripe.id()
             }
  def list(params \\ %{}) do
    new_request()
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:ending_before, :starting_after])
    |> make_request()
  end

  @doc """
  Returns a list of PaymentLink's Line Items.
  """
  @spec list_line_items(Stripe.id() | t, params) ::
          {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:ending_before) => Stripe.id(),
               optional(:limit) => pos_integer(),
               optional(:starting_after) => Stripe.id()
             }
  def list_line_items(id, params \\ %{}) do
    new_request()
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}" <> "/line_items")
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:ending_before, :starting_after])
    |> make_request()
  end
end

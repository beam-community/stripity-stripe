defmodule Stripe.PromotionCode do
  @moduledoc """
  Work with Stripe promotion code objects.

  You can:

  - Create a promotion code
  - Retrieve a promotion code
  - Update a promotion code
  - List all promotion codes

  Stripe API reference: https://stripe.com/docs/api/promotion_codes
  """

  use Stripe.Entity
  import Stripe.Request

  @type restrictions :: %{
          first_time_transaction: boolean | nil,
          minimum_amount: pos_integer | nil,
          minimum_amount_currency: String.t() | nil
        }
  @type t :: %__MODULE__{
          id: Stripe.id(),
          code: String.t(),
          coupon: Stripe.Coupon.t(),
          metadata: Stripe.Types.metadata(),
          object: String.t(),
          active: boolean,
          created: Stripe.timestamp(),
          customer: Stripe.id() | Stripe.Customer.t() | nil,
          expires_at: Stripe.timestamp(),
          livemode: boolean,
          max_redemptions: pos_integer | nil,
          restrictions: restrictions,
          times_redeemed: non_neg_integer
        }

  defstruct [
    :id,
    :object,
    :code,
    :coupon,
    :metadata,
    :active,
    :created,
    :customer,
    :expires_at,
    :livemode,
    :max_redemptions,
    :restrictions,
    :times_redeemed
  ]

  @plural_endpoint "promotion_codes"

  @doc """
  Create a promotion_code.
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               :coupon => String.t(),
               optional(:code) => String.t(),
               optional(:metadata) => Stripe.Types.metadata(),
               optional(:active) => boolean,
               optional(:customer) => Stripe.id() | Stripe.Customer.t(),
               optional(:expires_at) => Stripe.timestamp(),
               optional(:max_redemptions) => pos_integer,
               optional(:restrictions) => restrictions
             }
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Retrieve a promotion_code.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Updates the specified promotion code by setting the values of the parameters
  passed. Most fields are, by design, not editable.

  Takes the `id` and a map of changes.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:metadata) => Stripe.Types.metadata(),
                 optional(:active) => boolean
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
  List all promotion_codes.
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:active) => boolean,
               optional(:code) => String.t(),
               optional(:coupon) => Stripe.id() | Stripe.Coupon.t(),
               optional(:created) => Stripe.date_query(),
               optional(:ending_before) => t | Stripe.id(),
               optional(:limit) => 1..100,
               optional(:starting_after) => t | Stripe.id()
             }
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    # TODO - add coupon etc here?
    |> cast_to_id([:ending_before, :starting_after])
    |> make_request()
  end
end

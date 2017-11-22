defmodule Stripe.Coupon do
  @moduledoc """
  Work with Stripe coupon objects.

  You can:

  - Create a coupon
  - Retrieve a coupon
  - Update a coupon
  - Delete a coupon
  - list all coupons

  Stripe API reference: https://stripe.com/docs/api#coupons
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          amount_off: pos_integer,
          created: Stripe.timestamp(),
          currency: String.t(),
          duration: String.t(),
          duration_in_months: pos_integer | nil,
          livemode: boolean,
          max_redemptions: pos_integer,
          metadata: Stripe.Types.metadata(),
          percent_off: pos_integer,
          redeem_by: Stripe.timestamp(),
          times_redeemed: non_neg_integer,
          valid: boolean
        }

  defstruct [
    :id,
    :object,
    :amount_off,
    :created,
    :currency,
    :duration,
    :duration_in_months,
    :livemode,
    :max_redemptions,
    :metadata,
    :percent_off,
    :redeem_by,
    :times_redeemed,
    :valid
  ]

  @plural_endpoint "coupons"

  @doc """
  Create a coupon.
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               id: String.t(),
               duration: String.t(),
               amount_off: pos_integer,
               currency: String.t(),
               duration_in_months: pos_integer,
               max_redemptions: pos_integer,
               metadata: Stripe.Types.metadata(),
               percent_off: pos_integer,
               redeem_by: Stripe.timestamp()
             }
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Retrieve a coupon.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Updates the metadata of a coupon. Other coupon details (currency, duration,
  amount_off) are, by design, not editable.

  Takes the `id` and a map of changes.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               metadata: Stripe.Types.metadata()
             }
  def update(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  Delete a coupon.
  """
  @spec delete(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def delete(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:delete)
    |> make_request()
  end

  @doc """
  List all coupons.
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.of(t)} | {:error, Stripe.Error.t()}
        when params: %{
               created: Stripe.date_query(),
               ending_before: t | Stripe.id(),
               limit: 1..100,
               starting_after: t | Stripe.id()
             }
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:ending_before, :starting_after])
    |> make_request()
  end
end

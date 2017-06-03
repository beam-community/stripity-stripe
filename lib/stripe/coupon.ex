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

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object, :amount_off, :created, :currency, :duration, :duration_in_months,
    :livemode, :max_redemptions, :metadata, :percent_off, :redeem_by, :times_redeemed
  ]

  @plural_endpoint "coupons"

  @schema %{
    id: [:retrieve, :create],
    object: [:retrieve],
    amount_off: [:create, :retrieve],
    created: [:retrieve],
    currency: [:create, :retrieve],
    duration: [:create, :retrieve],
    duration_in_months: [:create, :retrieve],
    livemode: [:retrieve],
    max_redemptions: [:create, :retrieve],
    metadata: [:create, :retrieve, :update],
    percent_off: [:create, :retrieve],
    redeem_by: [:create, :retrieve],
    times_redeemed: [:create, :retrieve]
  }

  @nullable_keys [
    :amount_off, :currency, :duration_in_months, :max_redemptions,
    :metadata, :percent_off, :redeem_by, :times_redeemed
  ]

  @doc """
  Create a coupon.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, @schema, opts)
  end

  @doc """
  Retrieve a coupon.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end

  @doc """
  Update a coupon.

  Takes the `id` and a map of changes.
  """
  @spec update(binary, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, @schema, @nullable_keys, opts)
  end

  @doc """
  Delete a coupon.
  """
  @spec delete(binary, list) :: :ok | {:error, Stripe.api_error_struct}
  def delete(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.delete(endpoint, %{}, opts)
  end
end
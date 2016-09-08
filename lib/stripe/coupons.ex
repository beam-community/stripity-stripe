defmodule Stripe.Coupons do
  @moduledoc """
  Handles coupons to the Stripe API.
  (API ref: https://stripe.com/docs/api#coupons)

  Operations:
  - create
  - retrieve
  - update (TODO)
  - delete (TODO)
  - list (TODO)
  """

  @endpoint "coupons"

  @doc """
  Retrieves the coupon with the given ID.
  Returns a coupon if a valid coupon ID was provided.
  Throws an error otherwise.

  ## Examples
  ```
    params = "free-1-month"

    {:ok, result} = Stripe.Coupons.retrieve params
  ```
  """
  def retrieve(params) do
    path = @endpoint <> "/" <> params

    Stripe.make_request(:get, path, %{}, %{})
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Creates a coupon with given options. :duration is required and must be
  either "forever", "once", or "repeating".
  Returns a coupon if successful.
  Throws an error otherwise.

  ## Examples
  ```
    opts = [
      duration: "forever",
      id: "DISCOUNT20",
      percent_off: 25
    ]

    {:ok, result} = Stripe.Coupons.create opts
  ```
  """
  def create(opts \\ []) do
    create opts, Stripe.config_or_env_key
  end

  @doc """
  Creates a coupon with given options using given API key. :duration is required and must be
  either "forever", "once", or "repeating".
  Returns a coupon if successful.
  Throws an error otherwise.

  ## Examples
  ```
    opts = [
      duration: "forever",
      id: "DISCOUNT20",
      percent_off: 25
    ]

    {:ok, result} = Stripe.Coupons.create opts, key
  ```
  """
  def create(opts, key) do
    Stripe.make_request_with_key(:post, @endpoint, key, opts)
    |> Stripe.Util.handle_stripe_response
  end
end

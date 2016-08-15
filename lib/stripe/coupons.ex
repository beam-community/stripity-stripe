defmodule Stripe.Coupons do
  @moduledoc """
  Handles coupons to the Stripe API.
  (API ref: https://stripe.com/docs/api#coupons)

  Operations:
  - create (TODO)
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
end

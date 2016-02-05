defmodule Stripe.Cards do
  @moduledoc """
  Main API for working with Cards at Stripe. Through this API you can:
  - create

  (API ref https://stripe.com/docs/api#subscriptions)
  """
  @endpoint "customers"

  @doc """
  Create a card for the specified customer.

  ## Example

  ```
    new_card = [
      source: token,
      metadata: [
      ...
      ]
    ]
    {:ok, card} = Stripe.Cards.create customer_id, new_card
  ```
  """
  def create(customer_id, opts) do
    create customer_id, opts, Stripe.config_or_env_key
  end

  @doc """
  Create a card for the specified customer using given api key.

  ## Example

  ```
    new_card = [
      source: token,
      metadata: [
      ...
      ]
    ]
    {:ok, card} = Stripe.Cards.create customer_id, new_card
  ```
  """
  def create(customer_id, opts, key) do
    Stripe.make_request_with_key(:post, "#{@endpoint}/#{customer_id}/sources", key, opts)
    |> Stripe.Util.handle_stripe_response
  end
end

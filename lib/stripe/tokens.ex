defmodule Stripe.Tokens do
  @moduledoc """
  API for working with Tokens at Stripe. Through this API you can create and retrieve tokens for both credit card and bank account allowing you to use them instead of a credit card number in various operations.
  """

  @endpoint "tokens"

  @doc """
  Creates a token.
  ##Example
  ```
     # payload for credit card token
      params = [
            card: [
                number: "4242424242424242",
                exp_month: 8,
                exp_year: 2016,
                cvc: "314"
            ]
      ]
      # payload for a bank account token
      params: [
        bank_account: [
            country: "US",
            currency: "usd",
            routing_number: "110000000",
            account_number: "000123456789"
        ]
      ]
     {:ok, token} = Stripe.Tokens.create params
     IO.puts token.id

  ```
  """
  def create(params) do
    Stripe.make_request(:post, @endpoint, params)
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Retrieve a token by its id. Returns 404 if not found.
  ## Example

  ```
  {:ok, token} = Stripe.Tokens.get "token_id"
  ```
  """
  def get(id) do
    Stripe.make_request(:get, "#{@endpoint}/#{id}")
    |> Stripe.Util.handle_stripe_response
  end
end

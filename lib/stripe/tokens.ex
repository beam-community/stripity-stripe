defmodule Stripe.Tokens do
  @moduledoc """
  API for working with Tokens at Stripe. Through this API you can:
  -create
  -retrieve
  tokens for both credit card and bank account allowing you to use them instead of a credit card number in various operations.

  Supports Connect workflow by allowing to pass in any API key explicitely (vs using the one from env/config).

  (API ref https://stripe.com/docs/api#tokens)
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
    create params, Stripe.config_or_env_key
  end

  @doc """
  Creates a token using given api key.
  ##Example
  ```
  ...
  {:ok, token} = Stripe.Tokens.create params, key
  ...
  ```
  """
  def create(params, key) do
    Stripe.make_request_with_key(:post, @endpoint, key, params)
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
    get id, Stripe.config_or_env_key
  end

  @doc """
  Retrieve a token by its id using given api key.
  ## Example

  ```
  {:ok, token} = Stripe.Tokens.get "token_id", key
  ```
  """
  def get(id,key) do
    Stripe.make_request_with_key(:get, "#{@endpoint}/#{id}", key)
    |> Stripe.Util.handle_stripe_response
  end
end

defmodule Stripe.Charges do
  @moduledoc """
  Handles charges to the Stripe API.
  (API ref: https://stripe.com/docs/api#charges)

  Operations:
  - create
  - update
  - get one 
  - list 
  - count
  - refund 
  - refund partial 
  """

  @endpoint "charges"


  @doc """
  Creates a charge for a customer or card. You must pass in the amount, and also a source for the charge
  that can be a token or customer. See the Stripe docs for proper source specs.

  ## Examples
  ```
    params = [
      source: [
        object: "card",
        number: "4111111111111111",
        exp_month: 10,
        exp_year: 2020,
        country: "US",
        name: "Ducky Test",
        cvc: 123
      ],
      description: "1000 Widgets"
    ]

    {:ok, result} = Stripe.Charges.create 1000,params
  ```
  """
  def create(amount, params) do
    create amount, params, Stripe.config_or_env_key
  end

  @doc """
  Creates a charge for a customer or card. You must pass in the amount, and also a source for the charge
  that can be a token or customer. See the Stripe docs for proper source specs.
  Using a given stripe key to apply against the account associated.

  ## Examples

  {:ok, result} = Stripe.Charges.create 1000,params, key
"""
  def create(amount, params, key) do
    #default currency
    params = Keyword.put_new params, :currency, "USD"
    #drop in the amount
    params = Keyword.put_new params, :amount, amount

    Stripe.make_request_with_key(:post, @endpoint, key, params)
    |> Stripe.Util.handle_stripe_response
  end


  @doc """
  Lists out charges from your account with a default limit of 10. You can override this by passing in a limit.

  ## Examples
  ```
    {:ok, charges} = Stripe.Charges.list(100)
  ```
  """
  def list(limit \\ 10) do
    list Stripe.config_or_env_key, limit
  end

  @doc """
  Lists out charges from your account with a default limit of 10. You can override this by passing in a limit.
  Using a given stripe key to apply against the account associated.

  ## Examples
  ```
  {:ok, charges} = Stripe.Charges.list(key, 100)
  ```
  """
  def list(key, limit) do
    Stripe.make_request_with_key(:get, "#{@endpoint}?limit=#{limit}", key)
    |> Stripe.Util.handle_stripe_response
  end


  @doc """
  Updates a charge with changeable information (see the Stripe docs on what you can change)
  ## Examples

  ```
    params = [description: "Changed charge"]
    {:ok, charge} = Stripe.Charges.change("charge_id", params)
  ```
  """
  def change(id, params) do
    change id, params, Stripe.config_or_env_key
  end

  @doc """
  Updates a charge with changeable information (see the Stripe docs on what you can change)
  Using a given stripe key to apply against the account associated.
  ## Examples

  ```
  params = [description: "Changed charge"]
  {:ok, charge} = Stripe.Charges.change("charge_id", params, key)
  ```
  """
  def change(id, params, key) do
    Stripe.make_request_with_key(:post, "#{@endpoint}/#{id}", key, params)
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Captures a charge that is currently pending. Note: you can default a charge to be automatically captured by setting  `capture: true` in the charge create params.

  ## Example

  ```
      {:ok, charge} = Stripe.Charges.capture("charge_id")
  ```
  """
  def capture(id) do
    capture id, Stripe.config_or_env_key
  end

  @doc """
  Captures a charge that is currently pending. Note: you can default a charge to be automatically captured by setting  `capture: true` in the charge create params.

  Using a given stripe key to apply against the account associated.
  ## Example

  ```
  {:ok, charge} = Stripe.Charges.capture("charge_id", key)
  ```
  """
  def capture(id,key) do
    Stripe.make_request_with_key(:post, "#{@endpoint}/#{id}/capture", key)
    |> Stripe.Util.handle_stripe_response
  end


  @doc """
  Retrieves a given charge.

  ## Example

  ```
      {:ok, charge} = Stripe.Charges.get("charge_id")
  ```
  """
  def get(id) do
    get id, Stripe.config_or_env_key
  end

  @doc """
  Retrieves a given charge.
  Using a given stripe key to apply against the account associated.

  ## Example

  ```
  {:ok, charge} = Stripe.Charges.get("charge_id", key)
  ```
  """
  def get(id, key) do
    Stripe.make_request_with_key(:get, "#{@endpoint}/#{id}", key)
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Refunds a charge completely. Use `refund_partial` if you just want to... you know... partially refund

  ## Example

  ```
    {:ok, charge} = Stripe.Charges.refund("charge_id")
  ```
  """
  def refund(id) do
    refund id, Stripe.config_or_env_key
  end

  @doc """
  Refunds a charge completely. Use `refund_partial` if you just want to... you know... partially refund
  Using a given stripe key to apply against the account associated.
  
  ## Example

  ```
  {:ok, charge} = Stripe.Charges.refund("charge_id", key)
  """
  def refund(id, key) do
    Stripe.make_request_with_key(:post, "#{@endpoint}/#{id}/refunds", key)
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Refunds a charge partially; the amount is required.

  ## Example

  ```
    {:ok, charge} = Stripe.Charges.refund_partial("charge_id",500)
  ```
  """
  def refund_partial(id, amount) do
    refund_partial id, amount, Stripe.config_or_env_key
  end

  @doc """
  Refunds a charge partially; the amount is required.
  Using a given stripe key to apply against the account associated.
  ## Example

  ```
  {:ok, charge} = Stripe.Charges.refund_partial("charge_id",500, key)
  ```
  """
  def refund_partial(id, amount, key) do
    params = [amount: amount]
    Stripe.make_request_with_key(:post, "#{@endpoint}/#{id}/refunds", key, params)
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Count number of charges.
  ## Example

  ```
  {:ok, cnt} = Stripe.Charges.count 
  ```
  """
  def count do
    count Stripe.config_or_env_key
  end

  @doc """
  Count number of charges.
  Using a given stripe key to apply against the account associated.
  ## Example

  ```
  {:ok, cnt} = Stripe.Charges.count key 
  ```
  """
  def count(key) do
    Stripe.Util.count  "#{@endpoint}", key
  end
end

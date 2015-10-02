defmodule Stripe.Charges do
  @moduledoc """
  Handles charges to the Stripe API.
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
    #default currency
    params = Keyword.put_new params, :currency, "USD"
    #drop in the amount
    params = Keyword.put_new params, :amount, amount

    Stripe.make_request(:post, @endpoint, params)
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
    Stripe.make_request(:get, "#{@endpoint}?limit=#{limit}")
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
    Stripe.make_request(:post, "#{@endpoint}/#{id}",params)
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
    Stripe.make_request(:post, "#{@endpoint}/#{id}/capture")
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
    Stripe.make_request(:get, "#{@endpoint}/#{id}")
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
    Stripe.make_request(:post, "#{@endpoint}/#{id}/refunds")
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
    params = [amount: amount]
    Stripe.make_request(:post, "#{@endpoint}/#{id}/refunds", params)
      |> Stripe.Util.handle_stripe_response
  end
end

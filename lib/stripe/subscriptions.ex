defmodule Stripe.Subscriptions do
  @moduledoc """
  Main API for working with Subscriptions at Stripe. Through this API you can:
  - create
  - update
  - cancel
  - cancel_all
  - list all
  - count all
  """
  @endpoint "customers"

  @doc """
  Starts a subscription for the specified customer. Note that if you pass in the customer *and* subscription information, both will be created at the same time.

  ## Example

  ```
    new_sub = [
      email: "jill@test.com",
      description: "Poop on the Potty",
      plan: "standard",
      source: [
        object: "card",
        number: "4111111111111111",
        exp_month: 01,
        exp_year: 2018,
        cvc: 123,
        name: "Jill Subscriber"
      ]
    ]
    {:ok, sub} = Stripe.Subscriptions.create new_sub
  ```

  You can also just pass along the customer id and the plan name:

  ```
    new_sub = [
      plan: plan_id, #like "standard",
      customer: "customer_id"
    ]
    {:ok, sub} = Stripe.Subscriptions.create new_sub
  ```

  """
  def create(opts) do
    customer_id = Keyword.get opts, :customer
    plan_id = Keyword.get opts, :plan
    create( customer_id, plan_id )
  end

  @doc """
  Creates a subscription for the specified customer.

  ## Example

  ```
    Stripe.Subscriptions.create "customer_id", "plan_id"
  ```
  """
  def create(customer_id, plan_id) do
    Stripe.make_request(:post, "#{@endpoint}/#{customer_id}/subscriptions", [plan: plan_id])
      |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Returns a subscription; customer_id and subscription_id are required.

  ## Example

  ```
    Stripe.Customers.get_subscription "customer_id", "subscription_id"
  ```

  """
  def get(customer_id, sub_id) do
    Stripe.make_request(:get, "#{@endpoint}/#{customer_id}/subscriptions/#{sub_id}")
      |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Changes a customer's subscription (plan, description, etc - see Stripe API for acceptable options).
  Customer ID and Subscription ID are required for this.

  ## Example
  ```
  Stripe.Subscriptions.change "customer_id", "subscription_id", "plan_id"
  ```
  """
  def change(customer_id, sub_id, plan_id) do
    Stripe.make_request(:post, "#{@endpoint}/#{customer_id}/subscriptions/#{sub_id}", [plan: plan_id])
    |> Stripe.Util.handle_stripe_response
  end


  @doc """
  Cancels a subscription

  ## Example

  ```
    Stripe.Subscriptions.cancel "customer_id", "subscription_id"
    Stripe.Subscriptions.cancel "customer_id", "subscription_id", [at_period_end: true]
  ```
  """
  def cancel(customer_id, sub_id, opts \\ []) do
    Stripe.make_request(:delete, "#{@endpoint}/#{customer_id}/subscriptions/#{sub_id}", opts)
    |> Stripe.Util.handle_stripe_response
  end
  @doc """
  Cancel all subscriptions for account.

  #Example
  ```
  Stripe.Subscriptions.cancel_all customer_id
  ```
  """
  def cancel_all(customer_id) do
    case all(customer_id) do
      {:ok, subs} ->
        Enum.each subs, fn sub -> cancel(customer_id, sub["id"]) end
      {:error, err} -> raise err
    end
  end

  @doc """
  Changes the payment source for a subscription.

  #Example
  ```
  source = [object: "card", number: "4111111111111111", exp_month: 01, exp_year: 2018, cvc: 123]
  Stripe.Subscriptions.change_payment_source("customer_id", "subscription_id", source)
  ```
  """
  def change_payment_source(customer_id, sub_id, source) do
    data = [source: source]
    Stripe.make_request(:post, "#{@endpoint}/#{customer_id}/subscriptions/#{sub_id}", data)
    |> Stripe.Util.handle_stripe_response
  end

  @max_fetch_size 100
  @doc """
  List all subscriptions.

  ##Example

  ```
  {:ok, subscriptions} = Stripe.Subscriptions.all customer_id
  ```

  """
  def all( customer_id, accum \\ [], startingAfter \\ "") do
    case Stripe.Util.list_raw("#{@endpoint}/#{customer_id}/subscriptions",@max_fetch_size, startingAfter) do
      {:ok, resp}  ->
        case resp[:has_more] do
          true ->
            last_sub = List.last( resp[:data] )
            all( customer_id, resp[:data] ++ accum, last_sub["id"] )
          false ->
            result = resp[:data] ++ accum
            {:ok, result}
        end
    end
  end

  @doc """
  Count total number of subscriptions.

  ## Example
  ```
  {:ok, count} = Stripe.Subscriptions.count customer_id
  ```
  """
  def count(customer_id) do
    Stripe.Util.count "#{@endpoint}/#{customer_id}/subscriptions"
  end
 end

defmodule Stripe.Subscriptions do
  @moduledoc """
  Main API for working with Subscriptions at Stripe. Through this API you can:
  - create
  - change
  - retrieve
  - cancel
  - cancel_all
  - list all
  - count all

  Supports Connect workflow by allowing to pass in any API key explicitely (vs using the one from env/config).

  (API ref https://stripe.com/docs/api#subscriptions)
  """
  @endpoint "customers"

  @doc """
  Starts a subscription for the specified customer. 

  ## Example

  ```
    new_sub = [
      plan: plan_id,
      metadata: [
      ...
      ]
    ]
    {:ok, sub} = Stripe.Subscriptions.create customer_id, new_sub
  ```
  """
  def create( customer_id, opts ) do
    create customer_id, opts, Stripe.config_or_env_key
  end

  @doc """
  Starts a subscription for the specified customer using given api key. 

  ## Example

  ```
  new_sub = [
    plan: plan_id,
    metadata: [
    ...
    ]
  ]
  {:ok, sub} = Stripe.Subscriptions.create customer_id, opts, key
  ```
  """
  def create(customer_id, opts, key) do
    plan_id = Keyword.get opts, :plan

    Stripe.make_request_with_key(:post, "#{@endpoint}/#{customer_id}/subscriptions", key, opts)
    |> Stripe.Util.handle_stripe_response
  end


  @doc """
  Returns a subscription; customer_id and subscription_id are required.

  ## Example

  ```
    {:ok, customer} = Stripe.Customers.get_subscription "customer_id", "subscription_id"
  ```
  """
  def get(customer_id, sub_id) do
    get customer_id, sub_id, Stripe.config_or_env_key
  end

  @doc """
  Returns a subscription using given api key; customer_id and subscription_id are required.

  ## Example

  ```
  {:ok, sub} = Stripe.Subscriptions.get "customer_id", "subscription_id", key


  """
  def get(customer_id, sub_id, key) do
    Stripe.make_request_with_key(:get, "#{@endpoint}/#{customer_id}/subscriptions/#{sub_id}", key)
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
    change customer_id, sub_id, plan_id, Stripe.config_or_env_key
  end

  @doc """
  Changes a customer's subscription (plan, description, etc - see Stripe API for acceptable options).
  Customer ID and Subscription ID are required for this.
  Using a given stripe key to apply against the account associated.

  ## Example

  ```
  Stripe.Customers.change_subscription "customer_id", "subscription_id", "plan_id", key
  ```
  """
  def change(customer_id, sub_id, plan_id, key) do
    Stripe.make_request_with_key(:post, "#{@endpoint}/#{customer_id}/subscriptions/#{sub_id}", key, [plan: plan_id])
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Changes a customer's subscription using given api key(plan, description, etc - see Stripe API for acceptable options).
  Customer ID, Subscription ID, opts and api key are required for this.

  ## Example
  ```
  Stripe.Subscriptions.change "customer_id", "subscription_id", "plan_id", key
  ```
  """
  def change(customer_id, sub_id, opts, key) do
    Stripe.make_request_with_key(:post, "#{@endpoint}/#{customer_id}/subscriptions/#{sub_id}", key, opts)
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
    cancel customer_id, sub_id, opts, Stripe.config_or_env_key
  end

  @doc """
  Cancels a subscription with given api key.

  ## Example

  ```
  Stripe.Subscriptions.cancel "customer_id", "subscription_id", key
  ```
  """
  def cancel(customer_id, sub_id, opts, key) do
    Stripe.make_request_with_key(:delete, "#{@endpoint}/#{customer_id}/subscriptions/#{sub_id}", key, opts)
    |> Stripe.Util.handle_stripe_response
  end
  
  @doc """
  Cancel all subscriptions for account.

  #Example
  ```
  Stripe.Subscriptions.cancel_all customer_id
  ```
  """
  def cancel_all(customer_id,opts) do
    cancel_all customer_id, opts, Stripe.config_or_env_key
  end

  @doc """
  Cancel all subscriptions for account using given api key.

  #Example
  ```
  Stripe.Subscriptions.cancel_all customer_id, key
  ```
  """
  def cancel_all(customer_id, opts, key) do
    case all(customer_id, [], "", key) do
      {:ok, subs} ->
        Enum.each subs, fn sub -> cancel(customer_id, sub["id"], opts, key) end
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
  def all( customer_id, accum \\ [], starting_after \\ "") do
    all customer_id, accum, starting_after, Stripe.config_or_env_key
  end

  @doc """
  List all subscriptions using given api key.

  ##Example

  ```
  {:ok, subscriptions} = Stripe.Subscriptions.all customer_id, [], "", key
  ```

  """
  def all( customer_id, accum, starting_after, key) do
    case Stripe.Util.list_raw("#{@endpoint}/#{customer_id}/subscriptions", key,@max_fetch_size, starting_after) do
      {:ok, resp}  ->
        case resp[:has_more] do
          true ->
            last_sub = List.last( resp[:data] )
            all( customer_id, resp[:data] ++ accum, last_sub["id"], key )
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
    count customer_id, Stripe.config_or_env_key
  end

  @doc """
  Count total number of subscriptions using given api key.

  ## Example
  ```
  {:ok, count} = Stripe.Subscriptions.count customer_id, key
  ```
  """
  def count(customer_id, key) do
    Stripe.Util.count "#{@endpoint}/#{customer_id}/subscriptions", key
  end
end

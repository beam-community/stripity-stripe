defmodule Stripe.Customers do
  @moduledoc """
  Main API for working with Customers at Stripe. Through this API you can:
  -change subscriptions
  -create invoices
  -create customers
  -delete single customer
  -delete all customer
  -count customers
  """

  @endpoint "customers"

  @doc """
  Creates a Customer with the given parameters - all of which are optional.

  ## Example

  ```
    new_customer = [
      email: "test@test.com",
      description: "An Test Account",
      card: [
        number: "4111111111111111",
        exp_month: 01,
        exp_year: 2018,
        cvc: 123,
        name: "Joe Test User"
      ],
      source: [
        metadata:[
            app_order_id: "ABC123"
            app_state_x: "xyz"
        ]
      ]
    ]
    {:ok, res} = Stripe.Customers.create new_customer
  ```

  """
  def create(params) do
    Stripe.make_request(:post, @endpoint, params)
      |> Stripe.Util.handle_stripe_response
  end


  @doc """
  Retrieves a given Customer with the specified ID. Returns 404 if not found.
  ## Example

  ```
    Stripe.Customers.get "customer_id"
  ```

  """
  def get(id) do
    Stripe.make_request(:get, "#{@endpoint}/#{id}")
      |> Stripe.Util.handle_stripe_response
  end


  @doc """
  Changes a customer's subscription (plan, description, etc - see Stripe API for acceptable options).
  Customer ID and Subscription ID are required for this.

  ## Example

  ```
    Stripe.Customers.change_subscription "customer_id", "subscription_id", plan: "premium"
  ```

  """
  def change_subscription(id, sub_id, opts) do
    Stripe.make_request(:post, "#{@endpoint}/#{id}/subscriptions/#{sub_id}", opts)
      |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Starts a subscription for the specified customer. Note that if you pass in the customer *and* subscription information, both will be created at the same time.
Request/response object specs: https://stripe.com/docs/api/curl#create_customer
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
        name: "Jill Subscriber",
        metadata:[
           app_order_id: "ABC123"
           app_state_x: "xyz"
        ]
      ]
    ]
    {:ok, sub} = Stripe.Customers.create_subscription new_sub
  ```

  You can also just pass along the customer id and the plan name:

  ```
    new_sub = [
      plan: "standard",
      customer: "customer_id"
    ]
    {:ok, sub} = Stripe.Customers.create_subscription new_sub
  ```

  """
  def create_subscription(opts) do
    Stripe.make_request(:post, "#{@endpoint}", opts)
      |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Creates a subscription for the specified customer.

  ## Example

  ```
    Stripe.Customers.create_subscription "customer_id", "plan"
  ```
  """
  def create_subscription(id, opts) do
    Stripe.make_request(:post, "#{@endpoint}/#{id}/subscriptions", opts)
      |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Returns a subscription; customer_id and subscription_id are required.

  ## Example

  ```
    Stripe.Customers.get_subscription "customer_id", "subscription_id"
  ```

  """
  def get_subcription(id, sub_id) do
    Stripe.make_request(:get, "#{@endpoint}/#{id}/subscriptions/#{sub_id}")
      |> Stripe.Util.handle_stripe_response
  end


  @doc """
  Invoices a customer according to Stripe's invoice rules. This is not the same as a charge.

  ## Example

  ```
    Stripe.Customers.create_invoice "customer_id", "subscription_id"
  ```

  """
  def create_invoice(id, params) do
    params = Keyword.put_new params, :customer, id
    Stripe.make_request(:post, "invoices", params)
      |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Returns a list of invoices for a given customer

  ## Example

  ```
    Stripe.Customers.get_invoices "customer_id"
  ```

  """
  def get_invoices(id, params \\ []) do
    params = Keyword.put_new params, :limit, 10
    params = Keyword.put_new params, :customer, id

    Stripe.make_request(:get, "invoices", params )
      |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Cancels a subscription

  ## Example

  ```
    Stripe.Customers.cancel_subscription "customer_id", "subscription_id"
  ```
  """
  def cancel_subscription(id, sub_id) do
    Stripe.make_request(:delete, "#{@endpoint}/#{id}/subscriptions/#{sub_id}")
      |> Stripe.Util.handle_stripe_response

  end


  @doc """
  Returns all subscriptions for a Customer.

  ## Example

  ```
    Stripe.Customers.get_subscriptions "customer_id"
  ```

  """
  def get_subscriptions(id) do
    Stripe.make_request(:get, "#{@endpoint}/#{id}/subscriptions")
      |> Stripe.Util.handle_stripe_response

  end

  @doc """
  Returns a list of Customers with a default limit of 10 which you can override with `list/1`

  ## Example

  ```
    {:ok, customers} = Stripe.Customers.list(20)
  ```
  """
  def list(limit \\ 10) do
    Stripe.make_request(:get, "#{@endpoint}?limit=#{limit}")
      |> Stripe.Util.handle_stripe_response
  end


  @doc """
  Deletes a Customer with the specified ID

  ## Example

  ```
    Stripe.Customers.delete "customer_id"
  ```
  """
  def delete(id) do
    Stripe.make_request(:delete, "#{@endpoint}/#{id}")
      |> Stripe.Util.handle_stripe_response
  end
  
  @doc """
  Deletes all Customers

  ## Example

  ```
  Stripe.Customers.delete_all
  ```
  """
  def delete_all do
    case all  do
      {:ok, customers} ->
        Enum.each customers, fn c -> delete(c["id"]) end
      {:error, err} -> raise err
    end
  end

  @max_fetch_size 100
  @doc """
  List all customers.

  ##Example

  ```
  {:ok, customers} = Stripe.Customers.all
  ```

  """
  def all( accum \\ [], startingAfter \\ "") do
    case Stripe.Util.list_raw("#{@endpoint}",@max_fetch_size, startingAfter) do
      {:ok, resp}  ->
        case resp[:has_more] do
          true ->
            last_sub = List.last( resp[:data] )
            all( resp[:data] ++ accum, last_sub["id"] )
          false ->
            result = resp[:data] ++ accum
            {:ok, result}
        end
    {:error, err} -> raise err
    end
  end
  
  @doc """
  Count total number of customers.

  ## Example
  ```
  {:ok, count} = Stripe.Customers.count
  ```
  """
  def count do
    Stripe.Util.count "#{@endpoint}"
  end
end

 defmodule Stripe.Invoices do
  @moduledoc """
  Main API for working with Invoices at Stripe. Through this API you can:
  -create
  -retrieve single
  -list (paged, 100 max/page)
  -count

  All calls have a version with accept a key parameter for leveraging Connect.

  (API ref:https://stripe.com/docs/api#invoices) 
  """

  @endpoint "invoices"

  def get(id) do
    get id, Stripe.config_or_env_key
  end

  @doc """
  Retrieves a given Invoice with the specified ID. Returns 404 if not found.
  Using a given stripe key to apply against the account associated.
  ## Example

  ```
  {:ok, cust} = Stripe.Invoices.get "customer_id", key
  ```
  """
  def get(id, key) do
    Stripe.make_request_with_key(:get, "#{@endpoint}/#{id}", key)
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Returns a list of invoices for a given customer

  ## Example

  ```
  {:ok, invoices} = Stripe.Customers.get_invoices "customer_id"
  ```

  """
 # def get_invoices(id, params \\ []) do
 #   get_invoices id, params, Stripe.config_or_env_key
 # end

  @doc """
  Returns a list of invoices for a given customer
  Using a given stripe key to apply against the account associated.

  ## Example

  ```
  {:ok, invoices} = Stripe.Customers.get_invoices "customer_id", key
  ```
  """
 # def get_invoices(id, params, key) do
 #   params = Keyword.put_new params, :limit, 10
 #   params = Keyword.put_new params, :customer, id
 #   Stripe.Util.list "invoices", key, starting_after, limit
 # end

  @doc """
  Count number of invoices.
  ## Example

  ```
  {:ok, cnt} = Stripe.Invoices.count 
  ```
  """
  def count do
    count Stripe.config_or_env_key
  end

  @doc """
  Count number of invoices.
  Using a given stripe key to apply against the account associated.
  ## Example

  ```
  {:ok, cnt} = Stripe.Invoices.count key 
  ```
  """
  def count(key) do
    Stripe.Util.count  "#{@endpoint}", key
  end

  @doc """
  Lists invoices with a default limit of 10. You can override this by passing in a l imit.

  ## Examples
  ```
  {:ok, invoices} = Stripe.Invoices.list(starting_after,100)
  ```
  """
  def list(starting_after,limit \\ 10) do
    list Stripe.config_or_env_key, starting_after ,limit
  end

  @doc """
  Lists invoices with a default limit of 10. You can override this by passing in a limit.
  Using a given stripe key to apply against the account associated.

  ## Examples
  ```
  {:ok, invoices} = Stripe.Invoices.list(key,starting_after,100)
  ```
  """
  def list(key,starting_after,limit)  do
    Stripe.Util.list @endpoint, key,  starting_after, limit
  end


  @doc """
  Create invoice according to Stripe's invoice rules. This is not the same as a charge.

  ## Example

  ```
  params = [
    subscription: "subscription_id"
    metadata: [
        app_order_id: "ABC123",
        app_attr1: "xyz"
    ]
  ]
  {:ok, invoice} = Stripe.Invoices.create "customer_id", params
  ```
  """
  def create(customer_id, params) do
    create customer_id, params, Stripe.config_or_env_key
  end

  @doc """
  Create invoice according to Stripe's invoice rules. This is not the same as a charge.
  Using a given stripe key to apply against the account associated.

  ## Example

  ```
  params = [
    subscription: "subscription_id"
    metadata: [
        app_order_id: "ABC123",
        app_attr1: "xyz"
    ]
  {:ok, invoice} = Stripe.Invoices.create "customer_id", params, key
  ```
  """
  def create(customer_id, params, key) do
    params = Keyword.put_new params, :customer, customer_id
    Stripe.make_request_with_key(:post, "invoices", key, params)
    |> Stripe.Util.handle_stripe_response
  end
end

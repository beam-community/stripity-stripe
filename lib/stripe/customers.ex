defmodule Stripe.Customers do
  @moduledoc """
  Main API for working with Customers at Stripe. Through this API you can:
  -change subscriptions
  -create invoices
  -create customers
  -delete single customer
  -delete all customer
  -count customers

  Supports Connect workflow by allowing to pass in any API key explicitely (vs using the one from env/config).


  (API ref: https://stripe.com/docs/api/curl#customer_object
  """

  @endpoint "customers"

  @doc """
  Creates a Customer with the given parameters - all of which are optional.

  ## Example

  ```
    new_customer = [
      email: "test@test.com",
      description: "An Test Account",
      metadata:[
        app_order_id: "ABC123"
        app_state_x: "xyz"
      ],
      card: [
        number: "4111111111111111",
        exp_month: 01,
        exp_year: 2018,
        cvc: 123,
        name: "Joe Test User"
      ]
    ]
    {:ok, res} = Stripe.Customers.create new_customer
  ```

  """
  def create(params) do
    create params, Stripe.config_or_env_key
  end

  @doc """
  Creates a Customer with the given parameters - all of which are optional.
  Using a given stripe key to apply against the account associated.

  ## Example
  ```
  {:ok, res} = Stripe.Customers.create new_customer, key
  ```
  """
  def create(params, key) do
    Stripe.make_request_with_key(:post, @endpoint, key, params)
    |> Stripe.Util.handle_stripe_response
  end


  @doc """
  Retrieves a given Customer with the specified ID. Returns 404 if not found.
  ## Example

  ```
    {:ok, cust} = Stripe.Customers.get "customer_id" 
  ```

  """
  def get(id) do
    get id, Stripe.config_or_env_key
  end

  @doc """
  Retrieves a given Customer with the specified ID. Returns 404 if not found.
  Using a given stripe key to apply against the account associated.
  ## Example

  ```
  {:ok, cust} = Stripe.Customers.get "customer_id", key
  ```
  """
  def get(id, key) do
    Stripe.make_request_with_key(:get, "#{@endpoint}/#{id}", key)
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Returns a list of Customers with a default limit of 10 which you can override with `list/1`

  ## Example

  ```
    {:ok, customers} = Stripe.Customers.list(starting_after, 20)
  ```
  """
  def list(starting_after,limit \\ 10) do
    list Stripe.config_or_env_key, "", limit
  end

  @doc """
  Returns a list of Customers with a default limit of 10 which you can override with `list/1`
  Using a given stripe key to apply against the account associated.

  ## Example

  ```
  {:ok, customers} = Stripe.Customers.list(key,starting_after,20)
  ```
  """
  def list(key, starting_after, limit) do
    Stripe.Util.list @endpoint, key, starting_after, limit
  end

  @doc """
  Deletes a Customer with the specified ID

  ## Example

  ```
  {:ok, resp} =  Stripe.Customers.delete "customer_id"
  ```
  """
  def delete(id) do
    delete id, Stripe.config_or_env_key
  end

  @doc """
  Deletes a Customer with the specified ID
  Using a given stripe key to apply against the account associated.

  ## Example

  ```
  {:ok, resp} = Stripe.Customers.delete "customer_id", key
  ```
  """
  def delete(id,key) do
    Stripe.make_request_with_key(:delete, "#{@endpoint}/#{id}", key)
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

  @doc """
  Deletes all Customers
  Using a given stripe key to apply against the account associated.

  ## Example

  ```
  Stripe.Customers.delete_all key
  ```
  """
  def delete_all key do
    case all  do
      {:ok, customers} ->
        Enum.each customers, fn c -> delete(c["id"], key) end
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
  def all( accum \\ [], starting_after \\ "") do
    all Stripe.config_or_env_key, accum, starting_after
  end
  
  @doc """
  List all customers.
  Using a given stripe key to apply against the account associated.

  ##Example

  ```
  {:ok, customers} = Stripe.Customers.all key, accum, starting_after
  ```
  """
  def all( key, accum, starting_after) do
    case Stripe.Util.list_raw("#{@endpoint}",key, @max_fetch_size, starting_after) do
      {:ok, resp}  ->
        case resp[:has_more] do
          true ->
            last_sub = List.last( resp[:data] )
            all( key, resp[:data] ++ accum, last_sub["id"] )
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
    count Stripe.config_or_env_key
  end

  @doc """
  Count total number of customers.
  Using a given stripe key to apply against the account associated.

  ## Example
  ```
  {:ok, count} = Stripe.Customers.count key
  ```
  """
  def count( key )do
    Stripe.Util.count "#{@endpoint}", key
  end
end

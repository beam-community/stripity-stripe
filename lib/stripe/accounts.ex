defmodule Stripe.Accounts do
  @moduledoc """
  Main API for working with Customers at Stripe. Through this API you can:
  -create accounts
  -get single account
  -delete single account
  -delete all account
  -count account

  https://stripe.com/docs/api/curl#account_object
  """

  @endpoint "accounts"

  @doc """
  Creates an Account with the given parameters

  At the bare minimum, to create and connect to a managed account, simply set
  managed to true in the creation request, and provide a country. The country,
  once set, cannot be changed.

  https://stripe.com/docs/connect/managed-accounts

  ## Example

  ```
    new_account = [
      email: "test@example.com",
      managed: true,
      tos_acceptance: [
        date: :os.system_time(:seconds),
        ip: "127.0.0.1"
      ],
      legal_entity: [
        type: "individual",
        dob: [
          day: 1,
          month: 1,
          year: 1991
        ],
        first_name: "John",
        last_name: "Doe"
      ],
      external_account: [
        object: "bank_account",
        country: "US",
        currency: "usd",
        routing_number: "110000000",
        account_number: "000123456789"
      ]
    ]
    {:ok, res} = Stripe.Accounts.create new_account
  ```

  """
  def create(params) do
    create params, Stripe.config_or_env_key
  end

  @doc """
  Save as create(params).
  Accepts a stripe api key (for connect workflow)
  # Example
```
{:ok, resp} = Stripe.Account.create(params,key)
```
  """
  def create(params, key) do
    Stripe.make_request_with_key(:post, @endpoint, key, params)
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Retrieves a given Account with the specified ID. Returns 404 if not found.
  ## Example

  ```
    {:ok, account} = Stripe.Accounts.get "account_id" 
  ```

  """
  def get(id) do
    get id, Stripe.config_or_env_key
  end

  @doc """
  Retrieves a given Account with the specified ID. Returns 404 if not found.
  Accepts a stripe api key (for connect workflow)
  ## Example

  ```
  {:ok, account} = Stripe.Accounts.get "account_id", key
  ```
"""
   def get(id, key) do
    Stripe.make_request_with_key(:get, "#{@endpoint}/#{id}", key)
    |> Stripe.Util.handle_stripe_response
   end

  @max_fetch_size 100
  @doc """
  List all accounts.

  ##Example

  ```
  {:ok, accounts} = Stripe.Accounts.all
  ```

  """
  def all( accum \\ [], starting_after \\ "") do
    all Stripe.config_or_env_key, accum, starting_after 
  end

  @doc """
  List all accounts.
  Accepts a stripe api key (for connect workflow)

  ##Example

  ```
  {:ok, accounts} = Stripe.Accounts.all key, accum, starting_after
  ```
  where accum is []
  starting_after is the paging marker

  """
  def all( key, accum, starting_after) do
    case Stripe.Util.list_raw("#{@endpoint}", key, @max_fetch_size, starting_after)  do

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
  Deletes a Account with the specified ID

  ## Example

  ```
    Stripe.Accounts.delete "account_id"
  ```
  """
  def delete(id) do
    delete id, Stripe.config_or_env_key
  end

  @doc """
  Deletes a Account with the specified ID
  Accepts a stripe api key (for connect workflow)

  ## Example

  ```
  Stripe.Accounts.delete "account_id", key
  ```
  """
  def delete(id, key) do
    Stripe.make_request_with_key(:delete, "#{@endpoint}/#{id}", key)
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Deletes all Accounts

  ## Example

  ```
  Stripe.Accounts.delete_all
  ```
  """
  def delete_all do
    delete_all Stripe.config_or_env_key
  end

  @doc """
  Deletes all Accounts
  Accepts a stripe api key (for connect workflow)

  ## Example

  ```
  Stripe.Accounts.delete_all key
  ```
  """
  def delete_all key do
    case all  do
      {:ok, accounts} ->
        Enum.each accounts, fn c -> delete(c["id"], key) end
      {:error, err} -> raise err
    end
  end

  @doc """
  Count total number of accounts.

  ## Example
  ```
  {:ok, count} = Stripe.Accounts.count
  ```
  """
  def count do
    Stripe.Util.count "#{@endpoint}"
  end

  @doc """
  Count total number of accounts.
  Accepts a stripe api key (for connect workflow)

  ## Example
  ```
  {:ok, count} = Stripe.Accounts.count key
  ```
  """
  def count key do
    Stripe.Util.count "#{@endpoint}", key
  end

  @doc """
  Returns a list of Accounts with a default limit of 10 which you can override with `list/1`

  ## Example

  ```
    {:ok, accounts} = Stripe.Accounts.list(20)
  ```
  """
  def list(limit \\ 10) do
    list limit, Stripe.config_or_env_key
  end

  @doc """
  Returns a list of Accounts with a default limit of 10 which you can override with `list/1`
  Accepts a stripe api key (for connect workflow)
  
  ## Example

  ```
  {:ok, accounts} = Stripe.Accounts.list(20, key)
  ```
  """
  def list(limit, key) do
    Stripe.make_request_with_key(:get, "#{@endpoint}?limit=#{limit}", key)
    |> Stripe.Util.handle_stripe_response
  end
end

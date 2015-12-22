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
    Stripe.make_request(:post, @endpoint, params)
      |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Retrieves a given Account with the specified ID. Returns 404 if not found.
  ## Example

  ```
    Stripe.Accounts.get "account_id"
  ```

  """
  def get(id) do
    Stripe.make_request(:get, "#{@endpoint}/#{id}")
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
  Deletes a Account with the specified ID

  ## Example

  ```
    Stripe.Accounts.delete "account_id"
  ```
  """
  def delete(id) do
    Stripe.make_request(:delete, "#{@endpoint}/#{id}")
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
    case all  do
      {:ok, accounts} ->
        Enum.each accounts, fn c -> delete(c["id"]) end
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
  Returns a list of Accounts with a default limit of 10 which you can override with `list/1`

  ## Example

  ```
    {:ok, accounts} = Stripe.Accounts.list(20)
  ```
  """
  def list(limit \\ 10) do
    Stripe.make_request(:get, "#{@endpoint}?limit=#{limit}")
      |> Stripe.Util.handle_stripe_response
  end
end

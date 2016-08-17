defmodule Stripe.Accounts do
  @moduledoc """
  Functions for working with customers at Stripe. Through this API you can:

    * create account,
    * get account,
    * get all accounts,
    * delete account,
    * delete all accounts,
    * count accounts.

  Stripe API reference: https://stripe.com/docs/api/curl#account_object
  """

  @endpoint "accounts"

  @doc """
  Creates an account given the account params.

  Returns created account.

  At the bare minimum, to create and connect to a managed account, simply set
  managed to true in the creation request, and provide a country. The country,
  once set, cannot be changed.

  https://stripe.com/docs/connect/managed-accounts

  ## Examples

      params = [
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
      {:ok, account} = Stripe.Accounts.create(params)

  """
  def create(params) do
    create params, Stripe.config_or_env_key
  end

  @doc """
  Creates an account given the account params. Accepts Stripe API key.

  Returns created account.

  # Example

      {:ok, account} = Stripe.Account.create(params, "my_key")

  """
  def create(params, key) do
    Stripe.make_request_with_key(:post, @endpoint, key, params)
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Returns an account given the account ID.

  ## Examples

      {:ok, account} = Stripe.Accounts.get("account_id")

  """
  def get(id) do
    get id, Stripe.config_or_env_key
  end

  @doc """
  Returns an account given the account ID. Accepts Stripe API key.

  ## Examples

      {:ok, account} = Stripe.Accounts.get("account_id", "my_key")

  """
  def get(id, key) do
    Stripe.make_request_with_key(:get, "#{@endpoint}/#{id}", key)
    |> Stripe.Util.handle_stripe_response
  end

  @max_fetch_size 100
  @doc """
  Returns a list with all accounts.

  ## Examples

      {:ok, accounts} = Stripe.Accounts.all()

  """
  def all( accum \\ [], starting_after \\ "") do
    all Stripe.config_or_env_key, accum, starting_after 
  end

  @doc """
  Returns a list with all accounts. Accepts Stripe API key.

  ## Examples

      {:ok, accounts} = Stripe.Accounts.all("my_key", [], 3)

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
  Deletes an account given the account ID.

  Returns a deleted account.

  ## Examples

      {:ok, deleted_account} = Stripe.Accounts.delete("account_id")

  """
  def delete(id) do
    delete id, Stripe.config_or_env_key
  end

  @doc """
  Deletes an account given the account ID. Accepts Stripe API key.

  Returns a deleted account.

  ## Examples

      {:ok, deleted_account} = Stripe.Accounts.delete("account_id", "my_key")

  """
  def delete(id, key) do
    Stripe.make_request_with_key(:delete, "#{@endpoint}/#{id}", key)
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Deletes all accounts.

  ## Examples

      Stripe.Accounts.delete_all()

  """
  def delete_all do
    delete_all Stripe.config_or_env_key
  end

  @doc """
  Deletes all accounts. Accepts Stripe API key.

  ## Examples

      Stripe.Accounts.delete_all("my_key")

  """
  def delete_all key do
    case all() do
      {:ok, accounts} ->
        Enum.each accounts, fn c -> delete(c["id"], key) end
      {:error, err} -> raise err
    end
  end

  @doc """
  Returns total number of accounts.

  ## Examples

      {:ok, count} = Stripe.Accounts.count()

  """
  def count do
    Stripe.Util.count "#{@endpoint}"
  end

  @doc """
  Returns total number of accounts. Accepts Stripe API key.

  ## Examples

      {:ok, count} = Stripe.Accounts.count("my_key")

  """
  def count key do
    Stripe.Util.count "#{@endpoint}", key
  end

  @doc """
  Returns a list of accounts.

  Default limit of items returned is 10.

  ## Examples

      {:ok, accounts} = Stripe.Accounts.list() # Get a list of 10 accounts
      {:ok, accounts} = Stripe.Accounts.list(20) # Get a list of 20 accounts

  """
  def list(limit \\ 10) do
    list limit, Stripe.config_or_env_key
  end

  @doc """
  Returns a list of accounts. Accepts Stripe API key.

  Default limit of items returned is 10.

  ## Examples

      {:ok, accounts} = Stripe.Accounts.list("my_key") # Get a list of 10 accounts
      {:ok, accounts} = Stripe.Accounts.list(20, "my_key") # Get a list of 20 accounts

  """
  def list(limit, key) do
    Stripe.make_request_with_key(:get, "#{@endpoint}?limit=#{limit}", key)
    |> Stripe.Util.handle_stripe_response
  end
end

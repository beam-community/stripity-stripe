defmodule Stripe.Accounts do
  @moduledoc """
  Functions for working with customers at Stripe. Through this API you can:

    * create an account,
    * get an account,
    * delete an account,
    * delete all accounts,
    * list all accounts,
    * count accounts.

  Stripe API reference: https://stripe.com/docs/api/curl#account_object
  """

  @endpoint "accounts"

  @doc """
  Create an account.

  Creates an account using params.

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
  Create an account. Accepts Stripe API key.

  Creates an account given the account params.

  Returns created account.

  # Example

      {:ok, account} = Stripe.Account.create(params, "my_key")

  """
  def create(params, key) do
    Stripe.make_request_with_key(:post, @endpoint, key, params)
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Get an account.

  Gets an account using account ID.

  ## Examples

      {:ok, account} = Stripe.Accounts.get("account_id")

  """
  def get(id) do
    get id, Stripe.config_or_env_key
  end

  @doc """
  Get an account. Accepts Stripe API key.

  Gets an account using account ID.

  ## Examples

      {:ok, account} = Stripe.Accounts.get("account_id", "my_key")

  """
  def get(id, key) do
    Stripe.make_request_with_key(:get, "#{@endpoint}/#{id}", key)
    |> Stripe.Util.handle_stripe_response
  end

  @max_fetch_size 100
  @doc """
  List all accounts.

  Lists all accounts.

  Accepts the following parameters:

    * `accum` - a list to start accumulating accounts to (optional; defaults to `[]`).,
    * `starting_after` - an offset (optional; defaults to `""`).

  Returns `{:ok, accounts}` tuple.

  ## Examples

      {:ok, accounts} = Stripe.Accounts.all([], 5)

  """
  def all( accum \\ [], starting_after \\ "") do
    all Stripe.config_or_env_key, accum, starting_after 
  end

  @doc """
  List all accounts. Accepts Stripe API key.

  Lists all accounts.

  Accepts the following parameters:

    * `accum` - a list to start accumulating accounts to (optional; defaults to `[]`).,
    * `starting_after` - an offset (optional; defaults to `""`).

  Returns `{:ok, accounts}` tuple.

  ## Examples

      {:ok, accounts} = Stripe.Accounts.all("my_key", [], 5)

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
  Delete an account.

  Deletes an account given the account ID.

  Returns a `{:ok, account}` tuple.

  ## Examples

      {:ok, deleted_account} = Stripe.Accounts.delete("account_id")

  """
  def delete(id) do
    delete id, Stripe.config_or_env_key
  end

  @doc """
  Delete an account. Accepts Stripe API key.

  Deletes an account given the account ID.

  Returns a `{:ok, account}` tuple.

  ## Examples

      {:ok, deleted_account} = Stripe.Accounts.delete("account_id", "my_key")

  """
  def delete(id, key) do
    Stripe.make_request_with_key(:delete, "#{@endpoint}/#{id}", key)
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Delete all accounts.

  Deletes all accounts.

  Returns `:ok` atom.

  ## Examples

      Stripe.Accounts.delete_all()

  """
  def delete_all do
    delete_all Stripe.config_or_env_key
  end

  @doc """
  Delete all accounts. Accepts Stripe API key.

  Deletes all accounts.

  Returns `:ok` atom.

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
  Get total number of accounts.

  Gets total number of accounts.

  Returns `{:ok, count}` tuple.

  ## Examples

      {:ok, count} = Stripe.Accounts.count()

  """
  def count do
    Stripe.Util.count "#{@endpoint}"
  end

  @doc """
  Get total number of accounts. Accepts Stripe API key.

  Gets total number of accounts.

  Returns `{:ok, count}` tuple.

  ## Examples

      {:ok, count} = Stripe.Accounts.count("my_key")

  """
  def count key do
    Stripe.Util.count "#{@endpoint}", key
  end

  @doc """
  Get a list of accounts. Accepts Stripe API key.

  Gets a list of accounts for a given owner.

  Accepts the following parameters:

    * `limit` - a limit of items to be returned (optional; defaults to 10).

  Returns a `{:ok, accounts}` tuple, where `accounts` is a list of accounts.

  ## Examples

      {:ok, accounts} = Stripe.Accounts.list("my_key") # Get a list of 10 accounts
      {:ok, accounts} = Stripe.Accounts.list(20, "my_key") # Get a list of 20 accounts

  """
  def list(limit \\ 10) do
    list limit, Stripe.config_or_env_key
  end

  @doc """
  Get a list of accounts. Accepts Stripe API key.

  Gets a list of accounts for a given owner.

  Accepts the following parameters:

    * `limit` - a limit of items to be returned (optional; defaults to 10).

  Returns a `{:ok, accounts}` tuple, where `accounts` is a list of accounts.

  ## Examples

      {:ok, accounts} = Stripe.Accounts.list("my_key") # Get a list of 10 accounts
      {:ok, accounts} = Stripe.Accounts.list(20, "my_key") # Get a list of 20 accounts

  """
  def list(limit, key) do
    Stripe.make_request_with_key(:get, "#{@endpoint}?limit=#{limit}", key)
    |> Stripe.Util.handle_stripe_response
  end
end

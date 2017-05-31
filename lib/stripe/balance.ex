defmodule Stripe.Balance do
  @moduledoc """
  Main API for working with Balances at Stripe. Through this API you can:
  -get current balance
  -list balance history

  https://stripe.com/docs/api#balance_object
  """

  @endpoint "balance"

  @doc """
  Retrieves a given Balance for the user's current stripe account. Returns 404 if not found.
  ## Example

  ```
    {:ok, balance} = Stripe.Balance.get
  ```

  """
  def get do
    get Stripe.config_or_env_key
  end

  @doc """
    Retrieves a given Balance for the account associated with the key. Returns 404 if not found.
    Accepts a stripe api key (for connect workflow)
    ## Example

    ```
    {:ok, account} = Stripe.Accounts.get key
    ```
  """
  def get(key) do
    Stripe.make_request_with_key(:get, "#{@endpoint}", key)
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
    Retrieves Balance history for the current stripe account.  Returns 404 if not found.
    ## Example

    ```
      {:ok, balance_history} = Stripe.Balance.history
    ```

  """
  def history do
    history Stripe.config_or_env_key
  end

  @doc """
    Retrieves Balance history for the account associated with the key. Returns 404 if not found.
    Accepts a stripe api key (for connect workflow)
    ## Example

    ```
    {:ok, account} = Stripe.Accounts.history key
    ```
  """
  def history(key) do
    Stripe.make_request_with_key(:get, "#{@endpoint}/history", key)
    |> Stripe.Util.handle_stripe_response
  end
end

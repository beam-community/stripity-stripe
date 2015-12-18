defmodule Stripe.Events do
  @moduledoc """
  Main API for working with Events at Stripe. Through this API you can:
  -list/search events (last 30 days guaranteed to be available)
  -retrieve event from id
  -count number of events stored  currently on stripe 

  https://stripe.com/docs/api/curl#event_object
  """

  @endpoint "events"


  @doc """
  Retrieves a given Event with the specified ID. Returns 404 if not found.
  ## Example

  ```
  Stripe.Events.get "event_id"
  ```

  """
  def get(id) do
    get Stripe.config_or_env_key, id
  end

  @doc """
  Retrieves a given Event with the specified ID using that key(account).
  Returns 404 if not found.
  ## Example

  ```
  {:ok, event} = Stripe.Events.get  key, "event_id"
  ```

  """
  def get(key,id) do
    Stripe.make_request_with_key(:get, "#{@endpoint}/#{id}", key)
        |> Stripe.Util.handle_stripe_full_response
  end

  @doc """
  Count events.
  ## Example

  ```
  {:ok, count} = Stripe.Events.count
  ```
  """
  def count do
    count Stripe.config_or_env_key
  end

  @doc """
  Count events using given key.
  ## Example

  ```
  {:ok, count} = Stripe.Events.count key
  ```
  """
  def count(key) do
    Stripe.Util.count  "#{@endpoint}", key
  end

  @doc """
  Returns a list of events

  ## Example

  ```
  {:ok, events} = Stripe.Events.list "starting_after", limit // 10
  ```

  """
  def list(starting_after, limit \\ 10) do
    list Stripe.config_or_env_key, starting_after,limit
  end

  @doc """
  Returns a list of events using given stripe key
  
  ## Example

  ```
  {:ok, events} = Stripe.Events.list key, "starting_after", limit
  ```

  """
  def list(key, starting_after, limit) do
    Stripe.Util.list_raw( "#{@endpoint}", key, limit, starting_after) 
  end
end

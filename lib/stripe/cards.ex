defmodule Stripe.Cards do
  @moduledoc """
  Main API for working with Cards at Stripe. Through this API you can:
  -create cards for a customer
  -delete cards for a customer
  -delete all cards for a customer
  -list cards for a customer
  -count cards for a customer

  Supports Connect workflow by allowing to pass in any API key explicitely (vs using the one from env/config).

  (API ref: https://stripe.com/docs/api/curl#card_object
  """

  def endpoint_for_entity(entity_type, entity_id) do
    case entity_type do
      :customer -> "customers/#{entity_id}/sources"
      :account -> "accounts/#{entity_id}/external_accounts"
      :recipient -> "recipients/#{entity_id}/cards"
    end
  end


  @doc """
  Creates a Card with the given parameters.
  
  * owner_type must be either :customer, :account or :recipient
  * owner_id must be the ID of the owning object
  * params, must contain a "source" object, and inside it, the following parameters are required: 
  object, number, cvc, exp_month, exp-year

  ## Example

  ```

    new_card = [
      source: [
        object: "card",
        number: "4111111111111111",
        cvc: 123, 
        exp_month: 12,
        exp_year: 2020,
        metadata: [
          test_field: "test val"
        ]
      ]
    ]

    {:ok, res} = Stripe.Cards.create :customer, customer_id, new_card
  ```

  """
  def create(owner_type, owner_id, params) do
    create owner_type, owner_id, params, Stripe.config_or_env_key
  end

  @doc """
  Creates a Card with the given parameters.
  Using a given stripe key to apply against the account associated.

  
  * owner_type must be either :customer, :account or :recipient
  * owner_id must be the ID of the owning object
  * params, must contain a "source" object, and inside it, the following parameters are required:   object, number, cvc, exp_month, exp-year
  * key, the stripe key to use

  ## Example

  ```
    {:ok, res} = Stripe.Cards.create :customer, customer_id, new_card, key
  ```

  """

  def create(owner_type, owner_id, params, key) do
    Stripe.make_request_with_key(:post, endpoint_for_entity(owner_type, owner_id), key, params)
    |> Stripe.Util.handle_stripe_response
  end


  def update(owner_type, owner_id, id, params, key) do
    Stripe.make_request_with_key(:put, "#{endpoint_for_entity(owner_type, owner_id)}/#{id}", key, params)
    |> Stripe.Util.handle_stripe_response
  end


  @doc """
  Get a Card with the given id.
  
  * owner_type must be either :customer, :account or :recipient
  * owner_id must be the ID of the owning object
  * id,id of the card

  ## Example

  ```
    {:ok, res} = Stripe.Cards.get :customer, customer_id, id
  ```

  """
  def get(owner_type, owner_id, id) do
    get owner_type, owner_id, id, Stripe.config_or_env_key
  end

  @doc """
  Get a Card with the given id.
  Using a given stripe key to apply against the account associated.

  
  * owner_type must be either :customer, :account or :recipient
  * owner_id must be the ID of the owning object
  * id,id of the card
  * key, the stripe key to use

  ## Example

  ```
    {:ok, res} = Stripe.Cards.get :customer, customer_id, id, key
  ```

  """
  def get(owner_type, owner_id, id, key) do
    Stripe.make_request_with_key(:get, "#{endpoint_for_entity(owner_type, owner_id)}/#{id}", key)
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Returns a list of Cards with a default limit of 10 which you can override with `list/3`

  ## Example

  ```
    {:ok, cards} = Stripe.Cards.list(:customer, customer_id, starting_after, 20)
  ```
  """
  def list(owner_type, owner_id, starting_after, limit \\ 10) do
    list owner_type, owner_id, Stripe.config_or_env_key, "", limit
  end

  @doc """
  Returns a list of Cards with a default limit of 10 which you can override with `list/3`
  Using a given stripe key to apply against the account associated.

  ## Example

  ```
  {:ok, cards} = Stripe.Cards.list(:customer, customer_id, key, starting_after,20)
  ```
  """
  def list(owner_type, owner_id, key, starting_after, limit) do
    Stripe.Util.list endpoint_for_entity(owner_type, owner_id), key, starting_after, limit
  end

  @doc """
  Deletes a Card with the specified ID

  ## Example

  ```
  {:ok, resp} =  Stripe.Cards.delete :customer, customer_id, "card_id"
  ```
  """
  def delete(owner_type, owner_id, id) do
    delete owner_type, owner_id, id, Stripe.config_or_env_key
  end

  @doc """
  Deletes a Card with the specified ID
  Using a given stripe key to apply against the account associated.

  ## Example

  ```
  {:ok, resp} = Stripe.Cards.delete :customer, customer_id, "card_id", key
  ```
  """
  def delete(owner_type, owner_id, id,key) do
    Stripe.make_request_with_key(:delete, "#{endpoint_for_entity(owner_type, owner_id)}/#{id}", key)
    |> Stripe.Util.handle_stripe_response
  end
  
  @doc """
  Deletes all Cards owned by a particular entity

  ## Example

  ```
  Stripe.Cards.delete_all :customer, customer_id
  ```
  """
  def delete_all(owner_type, owner_id) do
    case all(owner_type, owner_id) do
      {:ok, cards} ->
        Enum.each cards, fn c -> delete(owner_type, owner_id, c["id"]) end
      {:error, err} -> raise err
    end
  end

  @doc """
  Deletes all Cards owned by a particular entity
  Using a given stripe key to apply against the account associated.

  ## Example

  ```
  Stripe.Cards.delete_all :customer, customer_id, key
  ```
  """
  def delete_all(owner_type, owner_id, key) do
    case all(owner_type, owner_id) do
      {:ok, customers} ->
        Enum.each customers, fn c -> delete(owner_type, owner_id, c["id"], key) end
      {:error, err} -> raise err
    end
  end

  @max_fetch_size 100

  @doc """
  List all Cards owned by a particular entity.

  ##Example

  ```
  {:ok, cards} = Stripe.Cards.all :customer, customer_id
  ```

  """  
  def all(owner_type, owner_id, accum \\ [], starting_after \\ "") do
    all owner_type, owner_id, Stripe.config_or_env_key, accum, starting_after
  end

  @doc """
  List all Cards owned by a particular entity.
  Using a given stripe key to apply against the account associated.

  ##Example

  ```
  {:ok, cards} = Stripe.Cards.all :customer, customer_id, key, accum, starting_after
  ```
  """  
  def all(owner_type, owner_id, key, accum, starting_after) do
    case Stripe.Util.list_raw("#{endpoint_for_entity(owner_type, owner_id)}",key, @max_fetch_size, starting_after) do
      {:ok, resp}  ->
        case resp[:has_more] do
          true ->
            last_sub = List.last( resp[:data] )
            all(owner_type, owner_id, key, resp[:data] ++ accum, last_sub["id"] )
          false ->
            result = resp[:data] ++ accum
            {:ok, result}
        end
      {:error, err} -> raise err
    end
  end

  @doc """
  Count total number of cards owned by a particular entity.

  ## Example
  ```
  {:ok, count} = Stripe.Cards.count :customer, customer_id
  ```
  """
  def count(owner_type, owner_id) do
    count owner_type, owner_id, Stripe.config_or_env_key
  end

  @doc """
  Count total number of cards owned by a particular entity.
  Using a given stripe key to apply against the account associated.

  ## Example
  ```
  {:ok, count} = Stripe.Cards.count :customer, customer_id, key
  ```
  """
  def count(owner_type, owner_id, key)do
    Stripe.Util.count "#{endpoint_for_entity(owner_type, owner_id)}", key
  end
end

defmodule Stripe.Cards do
  @moduledoc """
  Functions for working with cards at Stripe. Through this API you can:

    * create a card,
    * update a card,
    * get a card,
    * delete a card,
    * delete all cards,
    * list cards,
    * list all cards,
    * count cards.

  All requests require `owner_type` and `owner_id` parameters to be specified.

  `owner_type` must be one of the following:

    * `customer`,
    * `account`,
    * `recipient`.

  `owner_id` must be the ID of the owning object.

  Stripe API reference: https://stripe.com/docs/api/curl#card_object
  """

  def endpoint_for_entity(entity_type, entity_id) do
    case entity_type do
      :customer -> "customers/#{entity_id}/sources"
      :account -> "accounts/#{entity_id}/external_accounts"
      :recipient -> "recipients/#{entity_id}/cards"
    end
  end

  @doc """
  Create a card.
  
  Creates a card for given owner type, owner ID using params.

  `params` must contain a "source" object. Inside the "source" object, the following parameters are required:

    * object,
    * number,
    * cvs,
    * exp_month,
    * exp_year.

  Returns a `{:ok, card}` tuple.

  ## Examples

      params = [
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

      {:ok, card} = Stripe.Cards.create(:customer, customer_id, params)

  """
  def create(owner_type, owner_id, params) do
    create owner_type, owner_id, params, Stripe.config_or_env_key
  end

  @doc """
  Create a card. Accepts Stripe API key.

  Creates a card for given owner using params.

  `params` must contain a "source" object. Inside the "source" object, the following parameters are required:

    * object,
    * number,
    * cvs,
    * exp_month,
    * exp_year.

  Returns a `{:ok, card}` tuple.

  ## Examples

      {:ok, card} = Stripe.Cards.create(:customer, customer_id, params, key)

  """
  def create(owner_type, owner_id, params, key) do
    Stripe.make_request_with_key(:post, endpoint_for_entity(owner_type, owner_id), key, params)
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Update a card.

  Updates a card for given owner using card ID and params.

    * `owner_type` must be one of the following:

      * `customer`,
      * `account`,
      * `recipient`.

    * `owner_id` must be the ID of the owning object.

  Returns a `{:ok, card}` tuple.

  ## Examples

      {:ok, card} = Stripe.Cards.update(:customer, customer_id, card_id, params)

  """
  def update(owner_type, owner_id, id, params) do
    update(owner_type, owner_id, id, params, Stripe.config_or_env_key)
  end

  @doc """
  Update a card. Accepts Stripe API key.

  Updates a card for given owner using card ID and params.

  Returns a `{:ok, card}` tuple.

  ## Examples

      {:ok, card} = Stripe.Cards.update(:customer, customer_id, card_id, params, key)

  """
  def update(owner_type, owner_id, id, params, key) do
    Stripe.make_request_with_key(:post, "#{endpoint_for_entity(owner_type, owner_id)}/#{id}", key, params)
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Get a card.

  Gets a card for given owner using card ID.

  Returns a `{:ok, card}` tuple.

  ## Examples

      {:ok, card} = Stripe.Cards.get(:customer, customer_id, card_id)

  """
  def get(owner_type, owner_id, id) do
    get owner_type, owner_id, id, Stripe.config_or_env_key
  end

  @doc """
  Get a card. Accepts Stripe API key.

  Gets a card for given owner using card ID.

  Returns a `{:ok, card}` tuple.

  ## Examples

      {:ok, card} = Stripe.Cards.get(:customer, customer_id, card_id, key)

  """
  def get(owner_type, owner_id, id, key) do
    Stripe.make_request_with_key(:get, "#{endpoint_for_entity(owner_type, owner_id)}/#{id}", key)
    |> Stripe.Util.handle_stripe_response
  end

  @doc """
  Get a list of cards.

  Gets a list of cards for given owner.

  Accepts the following parameters:

    * `starting_after` - an offset (optional),
    * `limit` - a limit of items returned (optional; defaults to 10).

  Returns a `{:ok, cards}` tuple, where `cards` is a list of cards.

  ## Examples

      {:ok, cards} = Stripe.Cards.list(:customer, customer_id, 5) # Get a list of up to 10 cards, skipping first 5 cards
      {:ok, cards} = Stripe.Cards.list(:customer, customer_id, 5, 20) # Get a list of up to 20 cards, skipping first 5 cards

  """
  def list(owner_type, owner_id, starting_after, limit \\ 10) do
    list owner_type, owner_id, Stripe.config_or_env_key, "", limit
  end

  @doc """
  Get a list of cards. Accepts Stripe API key.

  Gets a list of cards for a given owner.

  Accepts the following parameters:

    * `starting_after` - an offset (optional),
    * `limit` - a limit of items returned (optional; defaults to 10).

  Returns a `{:ok, cards}` tuple, where `cards` is a list of cards.

  ## Examples

      {:ok, cards} = Stripe.Cards.list(:customer, customer_id, key, 5) # Get a list of up to 10 cards, skipping first 5 cards
      {:ok, cards} = Stripe.Cards.list(:customer, customer_id, key, 5, 20) # Get a list of up to 20 cards, skipping first 5 cards

  """
  def list(owner_type, owner_id, key, starting_after, limit) do
    Stripe.Util.list endpoint_for_entity(owner_type, owner_id), key, starting_after, limit
  end

  @doc """
  Delete a card.

  Deletes a card for given owner using card ID.

  Returns a `{:ok, card}` tuple.

  ## Examples

      {:ok, deleted_card} = Stripe.Cards.delete("card_id")

  """
  def delete(owner_type, owner_id, id) do
    delete owner_type, owner_id, id, Stripe.config_or_env_key
  end

  @doc """
  Delete a card. Accepts Stripe API key.

  Deletes a card for given owner using card ID.

  Returns a `{:ok, card}` tuple.

  ## Examples

      {:ok, deleted_card} = Stripe.Cards.delete("card_id", key)

  """
  def delete(owner_type, owner_id, id,key) do
    Stripe.make_request_with_key(:delete, "#{endpoint_for_entity(owner_type, owner_id)}/#{id}", key)
    |> Stripe.Util.handle_stripe_response
  end
  
  @doc """
  Delete all cards.

  Deletes all cards from given owner.

  Returns `:ok` atom.

  ## Examples

      :ok = Stripe.Cards.delete_all(:customer, customer_id)

  """
  def delete_all(owner_type, owner_id) do
    case all(owner_type, owner_id) do
      {:ok, cards} ->
        Enum.each cards, fn c -> delete(owner_type, owner_id, c["id"]) end
      {:error, err} -> raise err
    end
  end

  @doc """
  Delete all cards. Accepts Stripe API key.

  Deletes all cards from given owner.

  Returns `:ok` atom.

  ## Examples

      :ok = Stripe.Cards.delete_all(:customer, customer_id, key)

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
  List all cards.

  Lists all cards for a given owner.

  Accepts the following parameters:

    * `accum` - a list to start accumulating cards to (optional; defaults to `[]`).,
    * `starting_after` - an offset (optional; defaults to `""`).

  Returns `{:ok, cards}` tuple.

  ## Examples

      {:ok, cards} = Stripe.Cards.all(:customer, customer_id, accum, starting_after)

  """  
  def all(owner_type, owner_id, accum \\ [], starting_after \\ "") do
    all owner_type, owner_id, Stripe.config_or_env_key, accum, starting_after
  end

  @doc """
  List all cards. Accepts Stripe API key.

  Lists all cards for a given owner.

  Accepts the following parameters:

    * `accum` - a list to start accumulating cards to (optional; defaults to `[]`).,
    * `starting_after` - an offset (optional; defaults to `""`).

  Returns `{:ok, cards}` tuple.

  ## Examples

      {:ok, cards} = Stripe.Cards.all(:customer, customer_id, accum, starting_after, key)

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
  Get total number of cards.

  Gets total number of cards for a given owner.

  Returns `{:ok, count}` tuple.

  ## Examples

      {:ok, count} = Stripe.Cards.count(:customer, customer_id)

  """
  def count(owner_type, owner_id) do
    count owner_type, owner_id, Stripe.config_or_env_key
  end

  @doc """
  Get total number of cards. Accepts Stripe API key.

  Gets total number of cards for a given owner.

  Returns `{:ok, count}` tuple.

  ## Examples

      {:ok, count} = Stripe.Cards.count(:customer, customer_id, key)

  """
  def count(owner_type, owner_id, key)do
    Stripe.Util.count "#{endpoint_for_entity(owner_type, owner_id)}", key
  end
end

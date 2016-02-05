defmodule Stripe.CardTest do
  use ExUnit.Case

  #these tests are dependent on the execution order
  # ExUnit.configure w/ seed: 0 was set
  setup_all do
    Stripe.Customers.delete_all
    customer = Helper.create_test_customer "card_test1@localhost"
    on_exit fn ->
      Stripe.Customers.delete customer.id
    end

    {:ok, [customer: customer]}
  end


  @tag disabled: false
  test "Create w/opts  works", %{customer: customer} do
    token = Helper.create_test_token
    opts = [
      source: token.id
    ]
    case Stripe.Cards.create customer.id, opts do
      {:ok, card}   -> assert card.customer == customer.id
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "Create w/opts w/key works", %{customer: customer} do
    token = Helper.create_test_token
    opts = [
      source: token.id
    ]
    case Stripe.Cards.create customer.id, opts, Stripe.config_or_env_key do
      {:ok, card}   -> assert card.customer == customer.id
      {:error, err} -> flunk err
    end
  end

end

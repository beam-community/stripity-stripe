defmodule Stripe.TokensTest do
  use ExUnit.Case

  @tags disabled: false
  test "A bank account token is created"  do
    params = [
      bank_account: [
        country: "US",
        currency: "usd",
        routing_number: "110000000",
        account_number: "000123456789"
      ]
    ]
    case Stripe.Tokens.create(params) do
      {:ok, res} ->
        #Apex.ap res
        assert res.id
      assert res.type == "bank_account"
      {:error, err} -> flunk err
    end
  end

  @tags disabled: false
  test "A credit card token is created"  do
    params = [
      card: [
        number: "4242424242424242",
        exp_month: 8,
        exp_year: 2016,
        cvc: "314"
      ]
    ]
    case Stripe.Tokens.create(params) do
      {:ok, res} ->
        #Apex.ap res
        assert res.id
        assert res.type == "card"
      {:error, err} -> flunk err
    end
  end

  @tags disabled: false
  test "A token is retrieved by its id" do
    {:ok, token} = Stripe.Tokens.create [
      card: [
        number: "4242424242424242",
        exp_month: 8,
        exp_year: 2016,
        cvc: "314"
      ]
    ]
    #Apex.ap token
    case Stripe.Tokens.get token.id do
      {:ok, res} ->
        #Apex.ap res
        assert res.id
        assert res.type == "card"
        {:error, err} -> flunk err
    end
  end

  @tags disabled: false
  test "A token is used for a charge" do
    {:ok, token} = Stripe.Tokens.create [
      card: [
        number: "4242424242424242",
        exp_month: 8,
        exp_year: 2016,
        cvc: "314"
      ]
    ]
    #Apex.ap token
    params = [
      source: token.id
    ]
    case Stripe.Charges.create 100, params do
      {:ok, res} ->
        #Apex.ap res
        assert res.id
        assert res.status == "succeeded"
        assert res.paid == true
        assert res.object == "charge"
        {:error, err} -> flunk err
    end
  end
end

defmodule Stripe.BalanceTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.Balance{}} = Stripe.Balance.retrieve()
    assert_stripe_requested(:get, "/v1/balance")
  end

  test "is retrievable with Stripe-Version header" do
    assert {:ok, %Stripe.Balance{}} = Stripe.Balance.retrieve(%{}, [api_version: "2020-08-23"])
    assert_stripe_requested(:get, "/v1/balance", [headers: {"Stripe-Version", "2020-08-23"}])
  end
end

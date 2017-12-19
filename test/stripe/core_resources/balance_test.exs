defmodule Stripe.BalanceTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.Balance{}} = Stripe.Balance.retrieve()
    assert_stripe_requested(:get, "/v1/balance")
  end
end

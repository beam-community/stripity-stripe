defmodule Stripe.BalanceTest do
  use Stripe.StripeCase, async: true

  test "is listable" do
    assert {:ok, %Stripe.List{data: balances}} = Stripe.Balance.list()
    assert_stripe_requested(:get, "/v1/balance/history")
    assert is_list(balances)
    assert %Stripe.BalanceTransaction{} = hd(balances)
  end

  test "transaction is retrievable" do
    assert {:ok, %Stripe.BalanceTransaction{}} = Stripe.Balance.retrieve_transaction("b_123")
    assert_stripe_requested(:get, "/v1/balance/history/#{"b_123"}")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Balance{}} = Stripe.Balance.retrieve()
    assert_stripe_requested(:get, "/v1/balance")
  end
end

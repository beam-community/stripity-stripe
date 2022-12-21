defmodule Stripe.BalanceTransactionTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.BalanceTransaction{}} = Stripe.BalanceTransaction.retrieve("txn_123")
    assert_stripe_requested(:get, "/v1/balance_transactions/txn_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: txns}} = Stripe.BalanceTransaction.list()
    assert_stripe_requested(:get, "/v1/balance_transactions")
    assert is_list(txns)
    assert %Stripe.BalanceTransaction{} = hd(txns)
  end
end

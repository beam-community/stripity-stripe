defmodule Stripe.FinancialConnections.TransactionTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.FinancialConnections.Transaction{}} =
             Stripe.FinancialConnections.Transaction.retrieve("fct_123")

    assert_stripe_requested(:get, "/v1/financial_connections/transactions/fct_123")
  end

  test "is listable with account" do
    params = %{
      account: "fca_123"
    }

    assert {:ok, %Stripe.List{data: transactions}} =
             Stripe.FinancialConnections.Transaction.list(params)

    assert_stripe_requested(:get, "/v1/financial_connections/transactions", query: params)
    assert is_list(transactions)
    assert %Stripe.FinancialConnections.Transaction{} = hd(transactions)
  end

  test "is listable with transacted_at filter" do
    # Use a simple integer timestamp instead of a map for transacted_at
    params = %{
      account: "fca_123",
      # 2021-01-01
      transacted_at: 1_609_459_200
    }

    assert {:ok, %Stripe.List{data: transactions}} =
             Stripe.FinancialConnections.Transaction.list(params)

    assert_stripe_requested(:get, "/v1/financial_connections/transactions", query: params)
    assert is_list(transactions)
    assert %Stripe.FinancialConnections.Transaction{} = hd(transactions)
  end
end

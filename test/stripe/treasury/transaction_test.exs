defmodule Stripe.Treasury.TransactionTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.Treasury.Transaction{}} =
             Stripe.Treasury.Transaction.retrieve("trxn_123")

    assert_stripe_requested(:get, "/v1/treasury/transactions/trxn_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: transactions}} =
             Stripe.Treasury.Transaction.list(%{financial_account: "fa_123"})

    assert_stripe_requested(:get, "/v1/treasury/transactions",
      query: %{financial_account: "fa_123"}
    )

    assert is_list(transactions)
    assert %Stripe.Treasury.Transaction{} = hd(transactions)
  end

  test "is listable with status filter" do
    params = %{
      financial_account: "fa_123",
      status: :posted
    }

    assert {:ok, %Stripe.List{data: transactions}} =
             Stripe.Treasury.Transaction.list(params)

    assert_stripe_requested(:get, "/v1/treasury/transactions", query: params)
    assert is_list(transactions)
    assert %Stripe.Treasury.Transaction{} = hd(transactions)
  end

  test "is listable with order_by" do
    params = %{
      financial_account: "fa_123",
      order_by: :posted_at
    }

    assert {:ok, %Stripe.List{data: transactions}} =
             Stripe.Treasury.Transaction.list(params)

    assert_stripe_requested(:get, "/v1/treasury/transactions", query: params)
    assert is_list(transactions)
    assert %Stripe.Treasury.Transaction{} = hd(transactions)
  end
end

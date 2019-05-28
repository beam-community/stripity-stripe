defmodule Stripe.Issuing.TransactionTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.Issuing.Transaction{}} = Stripe.Issuing.Transaction.retrieve("ipi_123")
    assert_stripe_requested(:get, "/v1/issuing/transactions/ipi_123")
  end

  test "is updateable" do
    params = %{metadata: %{key: "value"}}

    assert {:ok, %Stripe.Issuing.Transaction{}} =
             Stripe.Issuing.Transaction.update("ipi_123", params)

    assert_stripe_requested(:post, "/v1/issuing/transactions/ipi_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: transactions}} = Stripe.Issuing.Transaction.list()
    assert_stripe_requested(:get, "/v1/issuing/transactions")
    assert is_list(transactions)
    assert %Stripe.Issuing.Transaction{} = hd(transactions)
  end
end

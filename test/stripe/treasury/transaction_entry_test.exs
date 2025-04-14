defmodule Stripe.Treasury.TransactionEntryTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.Treasury.TransactionEntry{}} =
             Stripe.Treasury.TransactionEntry.retrieve("trxne_123")

    assert_stripe_requested(:get, "/v1/treasury/transaction_entries/trxne_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: entries}} =
             Stripe.Treasury.TransactionEntry.list(%{financial_account: "fa_123"})

    assert_stripe_requested(:get, "/v1/treasury/transaction_entries",
      query: %{financial_account: "fa_123"}
    )

    assert is_list(entries)
    assert %Stripe.Treasury.TransactionEntry{} = hd(entries)
  end

  test "is listable with transaction filter" do
    params = %{
      financial_account: "fa_123",
      transaction: "trxn_123"
    }

    assert {:ok, %Stripe.List{data: entries}} =
             Stripe.Treasury.TransactionEntry.list(params)

    assert_stripe_requested(:get, "/v1/treasury/transaction_entries", query: params)
    assert is_list(entries)
    assert %Stripe.Treasury.TransactionEntry{} = hd(entries)
  end

  test "is listable with order_by" do
    params = %{
      financial_account: "fa_123",
      order_by: :effective_at
    }

    assert {:ok, %Stripe.List{data: entries}} =
             Stripe.Treasury.TransactionEntry.list(params)

    assert_stripe_requested(:get, "/v1/treasury/transaction_entries", query: params)
    assert is_list(entries)
    assert %Stripe.Treasury.TransactionEntry{} = hd(entries)
  end
end

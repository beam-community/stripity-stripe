defmodule Stripe.Tax.TransactionTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.Tax.Transaction{}} =
             Stripe.Tax.Transaction.retrieve("txn_123")

    assert_stripe_requested(:get, "/v1/tax/transactions/txn_123")
  end

  test "line items are listable" do
    assert {:ok, %Stripe.List{data: line_items}} =
             Stripe.Tax.Transaction.list_line_items("txn_123")

    assert_stripe_requested(:get, "/v1/tax/transactions/txn_123/line_items")
    assert is_list(line_items)
    assert %Stripe.Tax.TransactionLineItem{} = hd(line_items)
  end

  test "can be created from calculation" do
    params = %{
      calculation: "taxcalc_123",
      reference: "order_123"
    }

    assert {:ok, %Stripe.Tax.Transaction{}} =
             Stripe.Tax.Transaction.create_from_calculation(params)

    assert_stripe_requested(:post, "/v1/tax/transactions/create_from_calculation")
  end

  test "can create reversal" do
    params = %{
      original_transaction: "txn_123",
      reference: "refund_123",
      mode: :full
    }

    assert {:ok, %Stripe.Tax.Transaction{}} =
             Stripe.Tax.Transaction.create_reversal(params)

    assert_stripe_requested(:post, "/v1/tax/transactions/create_reversal")
  end

  test "can create partial reversal" do
    params = %{
      original_transaction: "txn_123",
      reference: "refund_123",
      mode: :partial,
      line_items: [
        %{
          original_line_item: "li_123",
          amount: 500,
          amount_tax: 50,
          reference: "item_123"
        }
      ]
    }

    assert {:ok, %Stripe.Tax.Transaction{}} =
             Stripe.Tax.Transaction.create_reversal(params)

    assert_stripe_requested(:post, "/v1/tax/transactions/create_reversal")
  end
end

defmodule Stripe.FeeRefundTest do
  use Stripe.StripeCase, async: true

  describe "retrieve/2" do
    test "retrieves a transfer" do
      assert {:ok, %Stripe.FeeRefund{}} = Stripe.FeeRefund.retrieve("transf_123", "rev_123")
      assert_stripe_requested(:get, "/v1/appliction_fees/trasnf_123/reversals/rev_123")
    end
  end

  describe "create/2" do
    test "creates a transfer" do
      params = %{
        amount: 123,
        destination: "dest_123"
      }
      assert {:ok, %Stripe.FeeRefund{}} = Stripe.FeeRefund.create("transf_123", params)
      assert_stripe_requested(:post, "/v1/appliction_fees/transf_123/reversals")
    end
  end

  describe "update/2" do
    test "updates a transfer" do
      params = %{metadata: %{foo: "bar"}}
      assert {:ok, transfer} = Stripe.FeeRefund.update("trasnf_123", "rev_123", params)
      assert_stripe_requested(:post, "/v1/appliction_fees/#{transfer.id}/reversals/rev_123")
    end
  end

  describe "list/2" do
    test "lists all appliction_fees refunds" do
      assert {:ok, %Stripe.List{data: appliction_fees}} = Stripe.FeeRefund.list("transf_123")
      assert_stripe_requested(:get, "/v1/appliction_fees/transf_123/reversals")
      assert is_list(appliction_fees)
      assert %Stripe.FeeRefund{} = hd(appliction_fees)
    end
  end
end

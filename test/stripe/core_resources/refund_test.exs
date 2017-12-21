defmodule Stripe.RefundTest do
  use Stripe.StripeCase, async: true

  test "is listable" do
    assert {:ok, %Stripe.List{data: refunds}} = Stripe.Refund.list()
    assert_stripe_requested(:get, "/v1/refunds")
    assert is_list(refunds)
    assert %Stripe.Refund{} = hd(refunds)
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Refund{}} = Stripe.Refund.retrieve("re_123")
    assert_stripe_requested(:get, "/v1/refunds/re_123")
  end

  test "is creatable" do
    assert {:ok, %Stripe.Refund{}} = Stripe.Refund.create(%{charge: "ch_123"})
    assert_stripe_requested(:post, "/v1/refunds")
  end

  test "is updateable" do
    assert {:ok, refund} = Stripe.Refund.update("re_123", %{metadata: %{foo: "bar"}})
    assert_stripe_requested(:post, "/v1/refunds/#{refund.id}")
  end
end

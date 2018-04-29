defmodule Stripe.ApplicationFeeTest do
  use Stripe.StripeCase, async: true

  test "is retrievable using plural endpoint" do
    assert {:ok, %Stripe.ApplicationFee{}} = Stripe.ApplicationFee.retrieve("acct_123")
    assert_stripe_requested(:get, "/v1/application_fees/acct_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: application_feess}} = Stripe.ApplicationFee.list()
    assert_stripe_requested(:get, "/v1/application_fees")
    assert is_list(application_feess)
    assert %Stripe.ApplicationFee{} = hd(application_feess)
  end
end

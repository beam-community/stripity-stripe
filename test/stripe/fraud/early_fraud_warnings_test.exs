defmodule Stripe.EarlyFraudWarningsTest do
  use Stripe.StripeCase, async: true

  describe "retrieve/2" do
    test "is retrievable" do
      assert {:ok, %Stripe.Fraud.EarlyFraudWarning{}} =
               Stripe.Fraud.EarlyFraudWarning.retrieve("issfr_123")

      assert_stripe_requested(:get, "/v1/radar/early_fraud_warnings/issfr_123")
    end
  end

  describe "list/2" do
    test "is listable" do
      assert {:ok, %Stripe.List{data: efws}} = Stripe.Fraud.EarlyFraudWarning.list()
      assert_stripe_requested(:get, "/v1/radar/early_fraud_warnings")
      assert is_list(efws)
      assert %Stripe.Fraud.EarlyFraudWarning{} = hd(efws)
    end
  end
end

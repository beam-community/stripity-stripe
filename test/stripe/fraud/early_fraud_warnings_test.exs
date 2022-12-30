defmodule Stripe.EarlyFraudWarningsTest do
  use Stripe.StripeCase, async: true

  describe "retrieve/2" do
    test "is retrievable" do
      assert {:ok, %Stripe.Radar.EarlyFraudWarning{}} =
               Stripe.Radar.EarlyFraudWarning.retrieve("issfr_123")

      assert_stripe_requested(:get, "/v1/radar/early_fraud_warnings/issfr_123")
    end
  end

  describe "list/2" do
    test "is listable" do
      assert {:ok, %Stripe.List{data: efws}} = Stripe.Radar.EarlyFraudWarning.list()
      assert_stripe_requested(:get, "/v1/radar/early_fraud_warnings")
      assert is_list(efws)
      assert %Stripe.Radar.EarlyFraudWarning{} = hd(efws)
    end
  end
end

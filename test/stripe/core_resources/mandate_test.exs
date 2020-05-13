defmodule Stripe.MandateTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.Mandate{} = mandate} = Stripe.Mandate.retrieve("mandate_123456789")
    assert_stripe_requested(:get, "/v1/mandates/mandate_123456789")
  end
end

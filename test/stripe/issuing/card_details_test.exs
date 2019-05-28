defmodule Stripe.Issuing.CardDetailsTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.Issuing.CardDetails{}} = Stripe.Issuing.CardDetails.retrieve("ic_123")
    assert_stripe_requested(:get, "/v1/issuing/cards/ic_123/details")
  end
end

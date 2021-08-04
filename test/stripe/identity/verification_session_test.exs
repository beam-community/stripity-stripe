defmodule Stripe.Identity.VerificationSessionTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    assert {:ok, %Stripe.Identity.VerificationSession{}} =
             Stripe.Identity.VerificationSession.create(%{type: "document"})

    assert_stripe_requested(:post, "/v1/identity/verification_sessions")
  end
end

"""
These tests are unable to be run until the endpoints needed are added to StripeMock
"""

defmodule Stripe.Identity.VerificationSessionTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    assert {:ok, %Stripe.Identity.VerificationSession{}} =
             Stripe.Identity.VerificationSession.create(%{type: "document"})

    assert_stripe_requested(:post, "/v1/identity/verification_sessions")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: verification_sessions}} =
             Stripe.Identity.VerificationSession.list()

    assert_stripe_requested(:get, "/v1/identity/verification_sessions")
    assert is_list(verification_sessions)
    assert %Stripe.Identity.VerificationSession{} = hd(verification_sessions)
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Identity.VerificationSession{}} =
             Stripe.Identity.VerificationSession.retrieve()

    assert_stripe_requested(:get, "/v1/identity/verification_sessions")
  end

  describe "update/2" do
    test "updates a capability" do
      assert {:ok, %Stripe.Identity.VerificationSession{}} =
               Stripe.Identity.VerificationSession.update("card_payments", %{account: "acct_123"})

      assert_stripe_requested(:post, "/v1/identity/verification_sessions")
    end

    test "passing an 'requested' does not result in an error" do
      assert {:ok, %Stripe.Identity.VerificationSession{}} =
               Stripe.Identity.VerificationSession.update("card_payments", %{
                 account: "acct_123",
                 requested: true
               })

      assert_stripe_requested(:post, "/v1/identity/verification_sessions")
    end
  end
end

defmodule Stripe.CapabilityTest do
  use Stripe.StripeCase, async: true

  describe "retrieve/2" do
    test "is retrievable" do
      assert {:ok, %Stripe.Capability{}} =
               Stripe.Capability.retrieve("card_payments", %{account: "acct_123"})

      assert_stripe_requested(:get, "/v1/accounts/acct_123/capabilities/card_payments")
    end
  end

  describe "update/2" do
    test "updates a capability" do
      assert {:ok, %Stripe.Capability{}} =
               Stripe.Capability.update("card_payments", %{account: "acct_123"})

      assert_stripe_requested(:post, "/v1/accounts/acct_123/capabilities/card_payments")
    end

    test "passing an 'requested' does not result in an error" do
      assert {:ok, %Stripe.Capability{}} =
               Stripe.Capability.update("card_payments", %{account: "acct_123", requested: true})

      assert_stripe_requested(:post, "/v1/accounts/acct_123/capabilities/card_payments")
    end
  end

  describe "list/2" do
    test "is listable" do
      assert {:ok, %Stripe.List{data: capabilities}} =
               Stripe.Capability.list(%{account: "acct_123"})

      assert_stripe_requested(:get, "/v1/accounts/acct_123/capabilities")
      assert is_list(capabilities)
      assert %Stripe.Capability{} = hd(capabilities)
    end
  end
end

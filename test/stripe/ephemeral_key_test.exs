defmodule Stripe.Issuing.EphemeralKeyTest do
  use Stripe.StripeCase, async: true

  @api_version ~s(2019-10-17)

  describe "create/2" do
    test "is creatable with issuing card id" do
      params = %{issuing_card: "ich_123"}

      assert {:ok, %Stripe.EphemeralKey{}} = Stripe.EphemeralKey.create(params, @api_version)

      assert_stripe_requested(:post, "/v1/ephemeral_keys")
    end

    test "is creatable with customer id" do
      params = %{customer: "ich_123"}

      assert {:ok, %Stripe.EphemeralKey{}} = Stripe.EphemeralKey.create(params, @api_version)

      assert_stripe_requested(:post, "/v1/ephemeral_keys")
    end
  end
end

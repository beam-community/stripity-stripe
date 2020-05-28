defmodule Stripe.Terminal.ConnectionTokenTest do
  use Stripe.StripeCase, async: true

  describe "Terminal" do
    test "sends the correct request" do
      assert {:ok, %Stripe.Terminal.ConnectionToken{}} =
               Stripe.Terminal.ConnectionToken.create(%{})

      assert_stripe_requested(:post, "/v1/terminal/connection_tokens")
    end
  end
end

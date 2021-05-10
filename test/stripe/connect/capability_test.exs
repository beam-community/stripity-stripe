defmodule Stripe.CapabilityTest do
  use Stripe.StripeCase, async: true

  test "is listable" do
    assert {:ok, %Stripe.List{data: capabilities}} =
             Stripe.Capability.list(%{account: "acct_123"})

    assert_stripe_requested(:get, "/v1/accounts/acct_123/capabilities")
    assert is_list(capabilities)
    assert %Stripe.Capability{} = hd(capabilities)
  end
end

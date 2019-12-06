defmodule Stripe.AccountLinkTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{
      account: "acct_123",
      failure_url: "https://stripe.com",
      success_url: "https://stripe.com",
      type: "custom_account_verification"
    }

    assert {:ok, %Stripe.AccountLink{}} = Stripe.AccountLink.create(params)
    assert_stripe_requested(:post, "/v1/account_links")
  end
end

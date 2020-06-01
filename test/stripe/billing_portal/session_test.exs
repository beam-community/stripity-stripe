defmodule Stripe.BillingPortal.SessionTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{
      customer: "cus_123",
      return_url: "https://stripe.com"
    }

    assert {:ok, %Stripe.BillingPortal.Session{}} = Stripe.BillingPortal.Session.create(params)
    assert_stripe_requested(:post, "/v1/billing_portal/sessions")
  end
end

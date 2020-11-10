defmodule Stripe.SessionTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{
      cancel_url: "https://stripe.com",
      payment_method_types: ["card"],
      success_url: "https://stripe.com"
    }

    assert {:ok, %Stripe.Session{}} = Stripe.Session.create(params)
    assert_stripe_requested(:post, "/v1/checkout/sessions")
  end

  describe "retrieve/2" do
    test "retrieves a session" do
      assert {:ok, session = %Stripe.Session{}} = Stripe.Session.retrieve("cs_123")
      assert_stripe_requested(:get, "/v1/checkout/sessions/cs_123")
    end
  end

  describe "list_line_items/2" do
    test "lists line items" do
      assert {:ok, %Stripe.List{}} = Stripe.Session.list_line_items("cs_123")
      assert_stripe_requested(:get, "/v1/checkout/sessions/cs_123/line_items")
    end
  end
end

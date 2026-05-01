defmodule Stripe.SessionTest do
  use Stripe.StripeCase, async: true

  alias Stripe.Checkout.Session

  test "is creatable" do
    params = %{
      cancel_url: "https://stripe.com",
      payment_method_types: ["card"],
      success_url: "https://stripe.com"
    }

    assert {:ok, %Session{}} = Session.create(params)
    assert_stripe_requested(:post, "/v1/checkout/sessions")
  end

  describe "retrieve/2" do
    test "retrieves a session" do
      assert {:ok, %Session{}} = Session.retrieve("cs_123")

      assert_stripe_requested(:get, "/v1/checkout/sessions/cs_123")
    end
  end

  describe "expire/2" do
    test "expires a session" do
      assert {:ok, %Session{}} = Session.expire("cs_123")

      assert_stripe_requested(:post, "/v1/checkout/sessions/cs_123/expire")
    end
  end

  describe "list_line_items/2" do
    test "lists line items" do
      assert {:ok, %Stripe.List{}} = Session.list_line_items("cs_123")
      assert_stripe_requested(:get, "/v1/checkout/sessions/cs_123/line_items")
    end
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: sessions}} = Session.list()
    assert_stripe_requested(:get, "/v1/checkout/sessions")
    assert is_list(sessions)
    assert %Session{} = hd(sessions)
  end
end

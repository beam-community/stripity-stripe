defmodule Stripe.WebhookEndpointTest do
  use Stripe.StripeCase, async: true

  test "is listable" do
    assert {:ok, %Stripe.List{data: webhook_endpoints}} = Stripe.WebhookEndpoint.list()
    assert_stripe_requested(:get, "/v1/webhook_endpoints")
    assert is_list(webhook_endpoints)
    assert %Stripe.WebhookEndpoint{} = hd(webhook_endpoints)
  end

  test "is retrievable" do
    assert {:ok, %Stripe.WebhookEndpoint{}} = Stripe.WebhookEndpoint.retrieve("we_123")
    assert_stripe_requested(:get, "/v1/webhook_endpoints/we_123")
  end

  test "is creatable" do
    params = %{
      enabled_events: ["charge.succeeded", "charge.failed"],
      url: "https://example.com/test"
    }

    assert {:ok, %Stripe.WebhookEndpoint{}} = Stripe.WebhookEndpoint.create(params)
    assert_stripe_requested(:post, "/v1/webhook_endpoints")
  end

  test "is updateable" do
    assert {:ok, %Stripe.WebhookEndpoint{}} =
             Stripe.WebhookEndpoint.update("we_123", %{metadata: %{foo: "bar"}})

    assert_stripe_requested(:post, "/v1/webhook_endpoints/we_123")
  end

  test "is deletable" do
    assert {:ok, %Stripe.WebhookEndpoint{}} = Stripe.WebhookEndpoint.delete("we_123")
    assert_stripe_requested(:delete, "/v1/webhook_endpoints/we_123")
  end
end

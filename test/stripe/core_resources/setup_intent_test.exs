defmodule Stripe.SetupIntentTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.SetupIntent{}} = Stripe.SetupIntent.retrieve("pi_123", %{})
    assert_stripe_requested(:get, "/v1/setup_intents/pi_123")
  end

  test "is creatable" do
    params = %{payment_method_types: ["card"]}
    assert {:ok, %Stripe.SetupIntent{}} = Stripe.SetupIntent.create(params)
    assert_stripe_requested(:post, "/v1/setup_intents")
  end

  test "is confirmable" do
    assert {:ok, %Stripe.SetupIntent{}} = Stripe.SetupIntent.confirm("pi_123", %{})

    assert_stripe_requested(:post, "/v1/setup_intents/pi_123/confirm")
  end

  test "is cancelable" do
    assert {:ok, %Stripe.SetupIntent{}} =
             Stripe.SetupIntent.cancel("pi_123", %{cancellation_reason: "requested_by_customer"})

    assert_stripe_requested(:post, "/v1/setup_intents/pi_123/cancel")
  end

  test "is updateable" do
    assert {:ok, %Stripe.SetupIntent{}} =
             Stripe.SetupIntent.update("pi_123", %{metadata: %{foo: "bar"}})

    assert_stripe_requested(:post, "/v1/setup_intents/pi_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: setup_intents}} = Stripe.SetupIntent.list()
    assert_stripe_requested(:get, "/v1/setup_intents")
    assert is_list(setup_intents)
    assert %Stripe.SetupIntent{} = hd(setup_intents)
  end
end

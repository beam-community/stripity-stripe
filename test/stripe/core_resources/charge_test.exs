defmodule Stripe.ChargeTest do
  use Stripe.StripeCase, async: true

  test "is listable" do
    assert {:ok, %Stripe.List{data: charges}} = Stripe.Charge.list()
    assert_stripe_requested :get, "/v1/charges"
    assert is_list(charges)
    assert %Stripe.Charge{} = hd(charges)
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Charge{}} = Stripe.Charge.retrieve("ch_123")
    assert_stripe_requested :get, "/v1/charges/ch_123"
  end

  test "is creatable" do
    assert {:ok, %Stripe.Charge{}} = Stripe.Charge.create(%{amount: 100, currency: "USD", source: "src_123"})
    assert_stripe_requested :post, "/v1/charges"
  end

  test "is updateable" do
    assert {:ok, %Stripe.Charge{}} = Stripe.Charge.update("ch_123", %{metadata: %{foo: "bar"}})
    assert_stripe_requested :post, "/v1/charges/ch_123"
  end

  test "is captureable" do
    {:ok, %Stripe.Charge{} = charge} = Stripe.Charge.retrieve("ch_123")
    assert {:ok, %Stripe.Charge{}} = Stripe.Charge.capture(charge, %{amount: 1000})
    assert_stripe_requested :post, "/v1/charges/ch_123/capture"
  end
end

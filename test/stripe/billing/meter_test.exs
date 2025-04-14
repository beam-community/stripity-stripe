defmodule Stripe.Billing.MeterTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.Billing.Meter{}} = Stripe.Billing.Meter.retrieve("meter_123")
    assert_stripe_requested(:get, "/v1/billing/meters/meter_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: meters}} = Stripe.Billing.Meter.list()
    assert_stripe_requested(:get, "/v1/billing/meters")
    assert is_list(meters)
    assert %Stripe.Billing.Meter{} = hd(meters)
  end

  test "is updateable" do
    assert {:ok, %Stripe.Billing.Meter{}} =
             Stripe.Billing.Meter.update("meter_123", %{display_name: "Updated Meter"})

    assert_stripe_requested(:post, "/v1/billing/meters/meter_123")
  end
end

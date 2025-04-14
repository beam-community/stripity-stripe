defmodule Stripe.Billing.MeterEventAdjustmentTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{
      event_name: "api_request",
      type: :cancel,
      cancel: %{
        identifier: "evt_123"
      }
    }

    assert {:ok, %Stripe.Billing.MeterEventAdjustment{}} =
             Stripe.Billing.MeterEventAdjustment.create(params)

    assert_stripe_requested(:post, "/v1/billing/meter_event_adjustments")
  end
end

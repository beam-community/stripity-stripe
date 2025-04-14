defmodule Stripe.Billing.MeterEventTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{
      event_name: "api_request",
      payload: %{
        stripe_customer_id: "cus_123",
        value: 10
      }
    }

    assert {:ok, %Stripe.Billing.MeterEvent{}} = Stripe.Billing.MeterEvent.create(params)
    assert_stripe_requested(:post, "/v1/billing/meter_events")
  end
end

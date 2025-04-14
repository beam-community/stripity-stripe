defmodule Stripe.Billing.AlertTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{
      alert_type: "usage_threshold",
      title: "High API Usage Alert",
      usage_threshold: %{
        meter: "meter_123",
        gte: 1000,
        recurrence: "one_time",
        filters: [
          %{
            type: "customer",
            customer: "cus_123"
          }
        ]
      }
    }

    assert {:ok, %Stripe.Billing.Alert{}} = Stripe.Billing.Alert.create(params)
    assert_stripe_requested(:post, "/v1/billing/alerts")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Billing.Alert{}} = Stripe.Billing.Alert.retrieve("alert_123")
    assert_stripe_requested(:get, "/v1/billing/alerts/alert_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: alerts}} = Stripe.Billing.Alert.list()
    assert_stripe_requested(:get, "/v1/billing/alerts")
    assert is_list(alerts)
    assert %Stripe.Billing.Alert{} = hd(alerts)
  end

  test "is activatable" do
    assert {:ok, %Stripe.Billing.Alert{}} = Stripe.Billing.Alert.activate("alert_123")
    assert_stripe_requested(:post, "/v1/billing/alerts/alert_123/activate")
  end

  test "is deactivatable" do
    assert {:ok, %Stripe.Billing.Alert{}} = Stripe.Billing.Alert.deactivate("alert_123")
    assert_stripe_requested(:post, "/v1/billing/alerts/alert_123/deactivate")
  end

  test "is archivable" do
    assert {:ok, %Stripe.Billing.Alert{}} = Stripe.Billing.Alert.archive("alert_123")
    assert_stripe_requested(:post, "/v1/billing/alerts/alert_123/archive")
  end
end

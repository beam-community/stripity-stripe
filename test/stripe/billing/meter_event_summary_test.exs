defmodule Stripe.Billing.MeterEventSummaryTest do
  use Stripe.StripeCase, async: true

  test "is listable" do
    params = %{
      customer: "cus_123",
      # 2021-01-01
      start_time: 1_609_459_200,
      # 2021-02-01
      end_time: 1_612_137_600
    }

    assert {:ok, %Stripe.List{data: summaries}} =
             Stripe.Billing.MeterEventSummary.list("meter_123", params)

    assert_stripe_requested(:get, "/v1/billing/meters/meter_123/event_summaries", query: params)

    assert is_list(summaries)
    assert %Stripe.Billing.MeterEventSummary{} = hd(summaries)
  end
end

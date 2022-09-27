defmodule Stripe.Reporting.ReportRunTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    assert {:ok, %Stripe.Reporting.ReportRun{}} =
             Stripe.Reporting.ReportRun.create(%{
               parameters: %{interval_start: 100, interval_end: 200},
               report_type: "balance.summary.1"
             })

    assert_stripe_requested(:post, "/v1/reporting/report_runs")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Reporting.ReportRun{}} = Stripe.Reporting.ReportRun.retrieve("frr_123")
    assert_stripe_requested(:get, "/v1/reporting/report_runs/frr_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: report_runs}} = Stripe.Reporting.ReportRun.list()
    assert_stripe_requested(:get, "/v1/reporting/report_runs")
    assert is_list(report_runs)
    assert %Stripe.Reporting.ReportRun{} = hd(report_runs)
  end
end

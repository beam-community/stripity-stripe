defmodule Stripe.Identity.VerificationReportTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.Identity.VerificationReport{}} =
             Stripe.Identity.VerificationReport.retrieve("vs_123xxx")

    assert_stripe_requested(:get, "/v1/identity/verification_reports/vs_123xxx")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: verification_reports}} =
             Stripe.Identity.VerificationReport.list()

    assert_stripe_requested(:get, "/v1/identity/verification_reports")
    assert is_list(verification_reports)
    assert %Stripe.Identity.VerificationReport{} = hd(verification_reports)
  end
end

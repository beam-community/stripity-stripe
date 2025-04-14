defmodule Stripe.Identity.VerificationReportTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.Identity.VerificationReport{}} =
             Stripe.Identity.VerificationReport.retrieve("vr_123")

    assert_stripe_requested(:get, "/v1/identity/verification_reports/vr_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: verification_reports}} =
             Stripe.Identity.VerificationReport.list()

    assert_stripe_requested(:get, "/v1/identity/verification_reports")
    assert is_list(verification_reports)
    assert %Stripe.Identity.VerificationReport{} = hd(verification_reports)
  end

  test "is listable with type filter" do
    params = %{
      type: :document
    }

    assert {:ok, %Stripe.List{data: reports}} =
             Stripe.Identity.VerificationReport.list(params)

    assert_stripe_requested(:get, "/v1/identity/verification_reports", query: params)
    assert is_list(reports)
    assert %Stripe.Identity.VerificationReport{} = hd(reports)
  end

  test "is listable with verification_session filter" do
    params = %{
      verification_session: "vs_123"
    }

    assert {:ok, %Stripe.List{data: reports}} =
             Stripe.Identity.VerificationReport.list(params)

    assert_stripe_requested(:get, "/v1/identity/verification_reports", query: params)
    assert is_list(reports)
    assert %Stripe.Identity.VerificationReport{} = hd(reports)
  end

  test "is listable with client_reference_id filter" do
    params = %{
      client_reference_id: "client_123"
    }

    assert {:ok, %Stripe.List{data: reports}} =
             Stripe.Identity.VerificationReport.list(params)

    assert_stripe_requested(:get, "/v1/identity/verification_reports", query: params)
    assert is_list(reports)
    assert %Stripe.Identity.VerificationReport{} = hd(reports)
  end
end

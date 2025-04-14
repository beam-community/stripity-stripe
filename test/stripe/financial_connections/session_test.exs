defmodule Stripe.FinancialConnections.SessionTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{
      account_holder: %{
        type: :customer,
        customer: "cus_123"
      },
      permissions: [:balances, :ownership, :payment_method, :transactions],
      filters: %{
        countries: ["US"],
        account_subcategories: [:checking, :savings]
      },
      return_url: "https://example.com/return"
    }

    assert {:ok, %Stripe.FinancialConnections.Session{}} =
             Stripe.FinancialConnections.Session.create(params)

    assert_stripe_requested(:post, "/v1/financial_connections/sessions")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.FinancialConnections.Session{}} =
             Stripe.FinancialConnections.Session.retrieve("fcs_123")

    assert_stripe_requested(:get, "/v1/financial_connections/sessions/fcs_123")
  end
end

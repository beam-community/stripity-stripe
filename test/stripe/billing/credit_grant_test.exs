defmodule Stripe.Billing.CreditGrantTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{
      customer: "cus_123",
      amount: %{
        type: "monetary",
        monetary: %{
          currency: "usd",
          value: 1000
        }
      },
      category: "promotional",
      applicability_config: %{
        scope: %{
          price_type: "metered",
          prices: [%{id: "price_123"}]
        }
      }
    }

    assert {:ok, %Stripe.Billing.CreditGrant{}} = Stripe.Billing.CreditGrant.create(params)
    assert_stripe_requested(:post, "/v1/billing/credit_grants")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Billing.CreditGrant{}} = Stripe.Billing.CreditGrant.retrieve("cg_123")
    assert_stripe_requested(:get, "/v1/billing/credit_grants/cg_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: grants}} = Stripe.Billing.CreditGrant.list()
    assert_stripe_requested(:get, "/v1/billing/credit_grants")
    assert is_list(grants)
    assert %Stripe.Billing.CreditGrant{} = hd(grants)
  end

  test "is updateable" do
    assert {:ok, %Stripe.Billing.CreditGrant{}} =
             Stripe.Billing.CreditGrant.update("cg_123", %{metadata: %{order_id: "6735"}})

    assert_stripe_requested(:post, "/v1/billing/credit_grants/cg_123")
  end

  test "is expirable" do
    assert {:ok, %Stripe.Billing.CreditGrant{}} = Stripe.Billing.CreditGrant.expire("cg_123")
    assert_stripe_requested(:post, "/v1/billing/credit_grants/cg_123/expire")
  end

  test "is voidable" do
    assert {:ok, %Stripe.Billing.CreditGrant{}} = Stripe.Billing.CreditGrant.void_grant("cg_123")
    assert_stripe_requested(:post, "/v1/billing/credit_grants/cg_123/void")
  end
end

defmodule Stripe.Treasury.FinancialAccountTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{
      supported_currencies: ["usd"],
      features: %{
        card_issuing: %{
          requested: true
        },
        deposit_insurance: %{
          requested: true
        },
        financial_addresses: %{
          aba: %{
            requested: true
          }
        },
        inbound_transfers: %{
          ach: %{
            requested: true
          }
        },
        outbound_payments: %{
          ach: %{
            requested: true
          },
          us_domestic_wire: %{
            requested: true
          }
        }
      }
    }

    assert {:ok, %Stripe.Treasury.FinancialAccount{}} =
             Stripe.Treasury.FinancialAccount.create(params)

    assert_stripe_requested(:post, "/v1/treasury/financial_accounts")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Treasury.FinancialAccount{}} =
             Stripe.Treasury.FinancialAccount.retrieve("fa_123")

    assert_stripe_requested(:get, "/v1/treasury/financial_accounts/fa_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: accounts}} = Stripe.Treasury.FinancialAccount.list()
    assert_stripe_requested(:get, "/v1/treasury/financial_accounts")
    assert is_list(accounts)
    assert %Stripe.Treasury.FinancialAccount{} = hd(accounts)
  end

  test "is updateable" do
    assert {:ok, %Stripe.Treasury.FinancialAccount{}} =
             Stripe.Treasury.FinancialAccount.update("fa_123", %{metadata: %{order_id: "6735"}})

    assert_stripe_requested(:post, "/v1/treasury/financial_accounts/fa_123")
  end

  test "is closable" do
    assert {:ok, %Stripe.Treasury.FinancialAccount{}} =
             Stripe.Treasury.FinancialAccount.close("fa_123")

    assert_stripe_requested(:post, "/v1/treasury/financial_accounts/fa_123/close")
  end

  test "features are retrievable" do
    assert {:ok, %Stripe.Treasury.FinancialAccountFeatures{}} =
             Stripe.Treasury.FinancialAccount.retrieve_features("fa_123")

    assert_stripe_requested(:get, "/v1/treasury/financial_accounts/fa_123/features")
  end

  test "features are updateable" do
    params = %{
      card_issuing: %{
        requested: true
      }
    }

    assert {:ok, %Stripe.Treasury.FinancialAccountFeatures{}} =
             Stripe.Treasury.FinancialAccount.update_features("fa_123", params)

    assert_stripe_requested(:post, "/v1/treasury/financial_accounts/fa_123/features")
  end
end

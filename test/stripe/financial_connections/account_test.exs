defmodule Stripe.FinancialConnections.AccountTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.FinancialConnections.Account{}} =
             Stripe.FinancialConnections.Account.retrieve("fca_123")

    assert_stripe_requested(:get, "/v1/financial_connections/accounts/fca_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: accounts}} =
             Stripe.FinancialConnections.Account.list()

    assert_stripe_requested(:get, "/v1/financial_connections/accounts")
    assert is_list(accounts)
    assert %Stripe.FinancialConnections.Account{} = hd(accounts)
  end

  test "is listable with session filter" do
    params = %{
      session: "fcs_123"
    }

    assert {:ok, %Stripe.List{data: accounts}} =
             Stripe.FinancialConnections.Account.list(params)

    assert_stripe_requested(:get, "/v1/financial_connections/accounts", query: params)
    assert is_list(accounts)
    assert %Stripe.FinancialConnections.Account{} = hd(accounts)
  end

  test "owners are listable" do
    params = %{
      ownership: "fcaown_123"
    }

    assert {:ok, %Stripe.List{data: owners}} =
             Stripe.FinancialConnections.Account.list_owners("fca_123", params)

    assert_stripe_requested(:get, "/v1/financial_connections/accounts/fca_123/owners",
      query: params
    )

    assert is_list(owners)
    assert %Stripe.FinancialConnections.AccountOwner{} = hd(owners)
  end

  test "can be disconnected" do
    assert {:ok, %Stripe.FinancialConnections.Account{}} =
             Stripe.FinancialConnections.Account.disconnect("fca_123")

    assert_stripe_requested(:post, "/v1/financial_connections/accounts/fca_123/disconnect")
  end

  test "can be refreshed" do
    params = %{
      features: [:balance, :ownership, :transactions]
    }

    assert {:ok, %Stripe.FinancialConnections.Account{}} =
             Stripe.FinancialConnections.Account.refresh("fca_123", params)

    assert_stripe_requested(:post, "/v1/financial_connections/accounts/fca_123/refresh")
  end

  test "can be subscribed to" do
    params = %{
      features: [:transactions]
    }

    assert {:ok, %Stripe.FinancialConnections.Account{}} =
             Stripe.FinancialConnections.Account.subscribe("fca_123", params)

    assert_stripe_requested(:post, "/v1/financial_connections/accounts/fca_123/subscribe")
  end

  test "can be unsubscribed from" do
    params = %{
      features: [:transactions]
    }

    assert {:ok, %Stripe.FinancialConnections.Account{}} =
             Stripe.FinancialConnections.Account.unsubscribe("fca_123", params)

    assert_stripe_requested(:post, "/v1/financial_connections/accounts/fca_123/unsubscribe")
  end
end

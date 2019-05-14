defmodule Stripe.Issuing.AuthorizationTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.Issuing.Authorization{}} =
             Stripe.Issuing.Authorization.retrieve("iauth_123")

    assert_stripe_requested(:get, "/v1/issuing/authorizations/iauth_123")
  end

  test "is updateable" do
    params = %{metadata: %{key: "value"}}

    assert {:ok, %Stripe.Issuing.Authorization{}} =
             Stripe.Issuing.Authorization.update("iauth_123", params)

    assert_stripe_requested(:post, "/v1/issuing/authorizations/iauth_123")
  end

  test "is approvable" do
    assert {:ok, %Stripe.Issuing.Authorization{}} =
             Stripe.Issuing.Authorization.approve("iauth_123")

    assert_stripe_requested(:post, "/v1/issuing/authorizations/iauth_123/approve")
  end

  test "is declinable" do
    assert {:ok, %Stripe.Issuing.Authorization{}} =
             Stripe.Issuing.Authorization.decline("iauth_123")

    assert_stripe_requested(:post, "/v1/issuing/authorizations/iauth_123/decline")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: authorizations}} = Stripe.Issuing.Authorization.list()
    assert_stripe_requested(:get, "/v1/issuing/authorizations")
    assert is_list(authorizations)
    assert %Stripe.Issuing.Authorization{} = hd(authorizations)
  end
end

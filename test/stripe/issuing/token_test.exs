defmodule Stripe.Issuing.TokenTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.Issuing.Token{}} =
             Stripe.Issuing.Token.retrieve("itoken_123")

    assert_stripe_requested(:get, "/v1/issuing/tokens/itoken_123")
  end

  test "is listable with required card parameter" do
    params = %{
      card: "ic_123"
    }

    assert {:ok, %Stripe.List{data: tokens}} =
             Stripe.Issuing.Token.list(params)

    assert_stripe_requested(:get, "/v1/issuing/tokens", query: params)
    assert is_list(tokens)
    assert %Stripe.Issuing.Token{} = hd(tokens)
  end

  test "is listable with card and status filter" do
    params = %{
      card: "ic_123",
      status: :active
    }

    assert {:ok, %Stripe.List{data: tokens}} =
             Stripe.Issuing.Token.list(params)

    assert_stripe_requested(:get, "/v1/issuing/tokens", query: params)
    assert is_list(tokens)
    assert %Stripe.Issuing.Token{} = hd(tokens)
  end

  test "is updateable" do
    params = %{
      status: :suspended
    }

    assert {:ok, %Stripe.Issuing.Token{}} =
             Stripe.Issuing.Token.update("itoken_123", params)

    assert_stripe_requested(:post, "/v1/issuing/tokens/itoken_123")
  end
end

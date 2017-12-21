defmodule Stripe.TokenTest do
  use Stripe.StripeCase, async: true

  @card %{
    number: "4242424242424242",
    exp_month: 11,
    exp_year: 2024,
    cvc: "123"
  }

  @bank_account %{
    country: "US",
    currency: "usd",
    account_holder_name: "Ella Garcia",
    account_holder_type: "individual",
    routing_number: "110000000",
    account_number: "000123456789"
  }

  @pii %{
    personal_id_number: "000000000"
  }

  describe "create/2" do
    test "creates a card token" do
      assert {:ok, %Stripe.Token{}} = Stripe.Token.create(%{card: @card})
      assert_stripe_requested(:post, "/v1/tokens")
    end

    test "creates a bank account token" do
      assert {:ok, %Stripe.Token{}} = Stripe.Token.create(%{bank_account: @bank_account})
      assert_stripe_requested(:post, "/v1/tokens")
    end

    test "creates a PII token" do
      assert {:ok, %Stripe.Token{}} = Stripe.Token.create(%{pii: @pii})
      assert_stripe_requested(:post, "/v1/tokens")
    end
  end

  describe "retrieve/2" do
    test "retrieves a token" do
      assert {:ok, %Stripe.Token{}} = Stripe.Token.retrieve("tok_123")
      assert_stripe_requested(:get, "/v1/tokens/tok_123")
    end
  end
end

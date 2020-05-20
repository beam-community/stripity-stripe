defmodule Stripe.PriceTest do
  use Stripe.StripeCase, async: true

  describe "create/2" do
    test "creates a one-time Price for a product" do
      params = %{
        currency: "usd",
        unit_amount: 5000,
        product: "abc_123"
      }

      assert {:ok, %Stripe.Price{}} = Stripe.Price.create(params)
      assert_stripe_requested(:post, "/v1/prices")
    end

    test "creates a recurring Price for a product" do
      params = %{
        currency: "usd",
        unit_amount: 5000,
        nickname: "Sapphire elite",
        product: "abc_123",
        recurring: %{
          interval: "month",
          trial_period_days: 10
        }
      }

      assert {:ok, %Stripe.Price{}} = Stripe.Price.create(params)
      assert_stripe_requested(:post, "/v1/prices")
    end

    test "creates a Price for a product with tiers" do
      params = %{
        currency: "usd",
        unit_amount: 5000,
        nickname: "Sapphire elite",
        product: "abc_123",
        recurring: %{
          interval: "month",
          trial_period_days: 10
        },
        billing_scheme: "tiered",
        tiers: [%{unit_amount: 10, up_to: 12}]
      }

      assert {:ok, %Stripe.Price{}} = Stripe.Price.create(params)
      assert_stripe_requested(:post, "/v1/prices")
    end
  end

  describe "retrieve/2" do
    test "retrieves a Price" do
      assert {:ok, %Stripe.Price{}} = Stripe.Price.retrieve("sapphire-elite")
      assert_stripe_requested(:get, "/v1/prices/sapphire-elite")
    end
  end

  describe "update/2" do
    test "updates a Price" do
      params = %{metadata: %{foo: "bar"}}
      assert {:ok, price} = Stripe.Price.update("sapphire-elite", params)
      assert_stripe_requested(:post, "/v1/prices/#{price.id}")
    end
  end

  describe "list/2" do
    test "lists all Prices" do
      assert {:ok, %Stripe.List{data: prices}} = Stripe.Price.list()
      assert_stripe_requested(:get, "/v1/prices")
      assert is_list(prices)
      assert %Stripe.Price{} = hd(prices)
    end
  end
end

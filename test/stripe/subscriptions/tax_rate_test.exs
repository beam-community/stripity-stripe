defmodule Stripe.TaxRateTest do
  use Stripe.StripeCase, async: true

  describe "create/2" do
    test "creates a TaxRate for a customer" do
      params = %{
        display_name: "VAT",
        description: "VAT Germany",
        jurisdiction: "DE",
        percentage: 19.0,
        inclusive: false
      }

      assert {:ok, %Stripe.TaxRate{}} = Stripe.TaxRate.create(params)
      assert_stripe_requested(:post, "/v1/tax_rates")
    end

    test "returns an error TaxRate" do
      params = %{
        display_name: "VAT",
        description: "VAT Germany",
        jurisdiction: "DE",
        inclusive: false
      }

      assert {:error, %Stripe.Error{}} = Stripe.TaxRate.create(params)
      assert_stripe_requested(:post, "/v1/tax_rates")
    end
  end

  describe "retrieve/2" do
    test "retrieves a TaxRate" do
      assert {:ok, %Stripe.TaxRate{}} = Stripe.TaxRate.retrieve("txr_1EXapq2eZvKYlo2CHmXqULaR")
      assert_stripe_requested(:get, "/v1/tax_rates/txr_1EXapq2eZvKYlo2CHmXqULaR")
    end
  end

  describe "update/2" do
    test "updates a TaxRate" do
      params = %{metadata: %{foo: "bar"}}
      assert {:ok, plan} = Stripe.TaxRate.update("txr_1EXapq2eZvKYlo2CHmXqULaR", params)
      assert_stripe_requested(:post, "/v1/tax_rates/#{plan.id}")
    end
  end

  describe "list/2" do
    test "lists all TaxRates" do
      assert {:ok, %Stripe.List{data: plans}} = Stripe.TaxRate.list()
      assert_stripe_requested(:get, "/v1/tax_rates")
      assert is_list(plans)
      assert %Stripe.TaxRate{} = hd(plans)
    end
  end
end

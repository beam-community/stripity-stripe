defmodule Stripe.Tax.CalculationTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{
      currency: "usd",
      customer: "cus_123",
      customer_details: %{
        address: %{
          line1: "354 Oyster Point Blvd",
          city: "South San Francisco",
          state: "CA",
          postal_code: "94080",
          country: "US"
        },
        address_source: :shipping
      },
      line_items: [
        %{
          amount: 1000,
          reference: "L1",
          tax_behavior: :exclusive,
          tax_code: "txcd_10000000"
        }
      ]
    }

    assert {:ok, %Stripe.Tax.Calculation{}} = Stripe.Tax.Calculation.create(params)
    assert_stripe_requested(:post, "/v1/tax/calculations")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Tax.Calculation{}} =
             Stripe.Tax.Calculation.retrieve("taxcalc_123")

    assert_stripe_requested(:get, "/v1/tax/calculations/taxcalc_123")
  end

  test "line items are listable" do
    assert {:ok, %Stripe.List{data: line_items}} =
             Stripe.Tax.Calculation.list_line_items("taxcalc_123")

    assert_stripe_requested(:get, "/v1/tax/calculations/taxcalc_123/line_items")
    assert is_list(line_items)
    assert %Stripe.Tax.CalculationLineItem{} = hd(line_items)
  end
end

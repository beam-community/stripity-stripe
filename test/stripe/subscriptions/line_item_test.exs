defmodule Stripe.LineItemTest do
  use Stripe.StripeCase, async: true

  describe "retrieve/2" do
    test "retrieves an invoice" do
      assert {:ok, %Stripe.Invoice{}} = Stripe.LineItem.retrieve("in_1234")
      assert_stripe_requested(:get, "/v1/invoices/in_1234/lines")
    end
  end
end

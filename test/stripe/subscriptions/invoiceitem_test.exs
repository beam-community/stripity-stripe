defmodule Stripe.InvoiceitemTest do
  use Stripe.StripeCase, async: true

  describe "create/2" do
    test "creates an invoice" do
      assert {:ok, %Stripe.Invoiceitem{}} = Stripe.Invoiceitem.create(%{customer: "cus_123", currency: "usd"})
      assert_stripe_requested(:post, "/v1/invoiceitems")
    end
  end

  describe "retrieve/2" do
    test "retrieves an invoice" do
      assert {:ok, %Stripe.Invoiceitem{}} = Stripe.Invoiceitem.retrieve("in_123")
      assert_stripe_requested(:get, "/v1/invoiceitems/in_123")
    end
  end

  describe "update/2" do
    test "updates an invoice" do
      params = %{metadata: %{key: "value"}}
      assert {:ok, %Stripe.Invoiceitem{}} = Stripe.Invoiceitem.update("in_123", params)
      assert_stripe_requested(:post, "/v1/invoiceitems/in_123")
    end
  end

  describe "list/2" do
    test "lists all invoiceitems" do
      assert {:ok, %Stripe.List{data: invoiceitems}} = Stripe.Invoiceitem.list()
      assert_stripe_requested(:get, "/v1/invoiceitems")
      assert is_list(invoiceitems)
      assert %Stripe.Invoiceitem{} = hd(invoiceitems)
    end
  end
end

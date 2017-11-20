defmodule Stripe.InvoiceTest do
  use Stripe.StripeCase, async: true

  describe "create/2" do
    test "creates an invoice" do
      assert {:ok, %Stripe.Invoice{}} = Stripe.Invoice.create(%{customer: "cus_123"})
      assert_stripe_requested :post, "/v1/invoices"
    end
  end

  describe "retrieve/2" do
    test "retrieves an invoice" do
      assert {:ok, %Stripe.Invoice{}} = Stripe.Invoice.retrieve("in_123")
      assert_stripe_requested :get, "/v1/invoices/in_123"
    end
  end

  describe "upcoming/2" do
    test "retrieves an upcoming invoice for a customer" do
      assert {:ok, %Stripe.Invoice{}} = Stripe.Invoice.upcoming(%{customer: "cus_123", subscription: "sub_123"})
      assert_stripe_requested :get, "/v1/invoices/upcoming", query: %{customer: "cust_123", subscription: "sub_123"}
    end

    test "retrieves an upcoming invoice for a customer with items" do
      items = [
        %{
          plan: "gold",
          quantity: 2
        }
      ]

      assert {:ok, %Stripe.Invoice{}} = Stripe.Invoice.upcoming(%{customer: "cus_123", subscription_items: items})
      assert_stripe_requested :get, "/v1/invoices/upcoming", query: %{:customer => "cust_123",
        :"susbscription_items[][plan]" => "gold",
        :"subscription_items[][quantity]" => 2}
    end

    test "can be called with an empty string" do
      assert {:ok, %Stripe.Invoice{}} = Stripe.Invoice.upcoming(%{coupon: "", customer: "cus_123"})
      assert_stripe_requested :get, "/v1/invoices/upcoming", query: %{customer: "cus_123", coupon: ""}
    end
  end

  describe "update/2" do
    test "updates an invoice" do
      assert {:ok, %Stripe.Invoice{}} = Stripe.Invoice.update("in_123", %{metadata: %{key: "value"}})
      assert_stripe_requested :post, "/v1/invoices/in_123"
    end
  end

  describe "pay/3" do
    test "pays an invoice" do
      {:ok, invoice} = Stripe.Invoice.retrieve("in_123")
      assert {:ok, %Stripe.Invoice{} = paid_invoice} = Stripe.Invoice.pay(invoice, %{})
      assert_stripe_requested :post, "/v1/invoices/#{invoice.id}/pay"
      assert paid_invoice.paid
    end

    test "pays an invoice with a specific source" do
      {:ok, invoice} = Stripe.Invoice.retrieve("in_123")
      assert {:ok, %Stripe.Invoice{} = paid_invoice} = Stripe.Invoice.pay(invoice, %{source: "src_123"})
      assert_stripe_requested :post, "/v1/invoices/#{invoice.id}/pay", body: %{source: "src_123"}
      assert paid_invoice.paid
    end
  end

  describe "list/2" do
    test "lists all invoices" do
      assert {:ok, %Stripe.List{data: invoices}} = Stripe.Invoice.list()
      assert_stripe_requested :get, "/v1/invoices"
      assert is_list(invoices)
      assert %Stripe.Invoice{} = hd(invoices)
    end
  end
end

defmodule Stripe.InvoiceTest do
  use ExUnit.Case
  
  setup do
     {:ok, [customer | _]} = Stripe.Customers.list(1)
     {:ok, [customer: customer]}
  end

  test "Listing invoices", %{customer: customer} do
    case Stripe.Customers.get_invoices(customer.id) do
      {:ok, invoices} -> assert invoices
      {:error, err} -> flunk err
    end
  end

  @tag disabled: true
  test "Creating an invoice", %{customer: customer} do
    sub = List.first(customer.subscriptions["data"])["id"]
    params = [subscription: sub, description: "Test Invoice"]
    case Stripe.Customers.create_invoice(customer.id, params) do
      {:ok, invoice} -> assert invoice.id
      {:error, err} -> flunk err
    end
  end
end

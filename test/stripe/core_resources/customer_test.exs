defmodule Stripe.CustomerTest do
  use Stripe.StripeCase, async: true

  test "is listable" do
    assert {:ok, %Stripe.List{data: customers}} = Stripe.Customer.list()
    assert_stripe_requested :get, "/v1/customers"
    assert is_list(customers)
    assert %Stripe.Customer{} = hd(customers)
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Customer{}} = Stripe.Customer.retrieve("cus_123")
    assert_stripe_requested :get, "/v1/customers/cus_123"
  end

  test "is creatable" do
    assert {:ok, %Stripe.Customer{}} = Stripe.Customer.create(%{})
    assert_stripe_requested :post, "/v1/customers"
  end

  @tag :disabled
  test "is saveable" do
    {:ok, customer} = Stripe.Customer.retrieve("cus_123")
    customer = put_in(customer.metadata["key"], "value")
    assert {:ok, %Stripe.Customer{} = scustomer} = Stripe.Customer.save(customer)
    assert scustomer.id == customer.id
    assert_stripe_requested :post, "/v1/customers/#{customer.id}"
  end

  test "is updateable" do
    assert {:ok, %Stripe.Customer{}} = Stripe.Customer.update("cus_123", %{metadata: %{key: "value"}})
    assert_stripe_requested :post, "/v1/customers/cus_123"
  end

  test "is deletable" do
    {:ok, customer} = Stripe.Customer.retrieve("cus_123")
    assert {:ok, %Stripe.Customer{}} = Stripe.Customer.delete(customer)
    assert_stripe_requested :delete, "/v1/customers/#{customer.id}"
  end

  test "create_subscription/3 creates a new subscription" do
    {:ok, customer} = Stripe.Customer.retrieve("cus_123")
    assert {:ok, %Stripe.Subscription{}} = Stripe.Customer.create_subscription(customer, %{plan: "silver"})
  end

  test "create_upcoming_invoice/2 creates a new invoice" do
    {:ok, customer} = Stripe.Customer.retrieve("cus_123")
    assert {:ok, %Stripe.Invoice{}} = Stripe.Customer.create_upcoming_invoice(customer)
  end

  describe "Customer.source" do
    test "can be updated using a token" do
      flunk "Changeset tests not yet implemented"
    end

    test "can be updated using a card" do
      flunk "Changeset tests not yet implemented"
    end
  end
end

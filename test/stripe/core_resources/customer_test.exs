defmodule Stripe.CustomerTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    assert {:ok, %Stripe.Customer{}} = Stripe.Customer.create(%{})
    assert_stripe_requested :post, "/v1/customers"
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Customer{}} = Stripe.Customer.retrieve("cus_123")
    assert_stripe_requested :get, "/v1/customers/cus_123"
  end

  test "is updateable" do
    assert {:ok, %Stripe.Customer{}} = Stripe.Customer.update("cus_123", %{metadata: %{key: "value"}})
    assert_stripe_requested :post, "/v1/customers/cus_123"
  end

  test "is deleteable" do
    {:ok, customer} = Stripe.Customer.retrieve("cus_123")
    assert {:ok, %Stripe.Customer{}} = Stripe.Customer.delete(customer)
    assert_stripe_requested :delete, "/v1/customers/#{customer.id}"
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: customers}} = Stripe.Customer.list()
    assert_stripe_requested :get, "/v1/customers"
    assert is_list(customers)
    assert %Stripe.Customer{} = hd(customers)
  end
end

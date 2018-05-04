defmodule Stripe.OrderTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    assert {:ok, %Stripe.Order{}} = Stripe.Order.create(%{currency: "USD"})
    assert_stripe_requested(:post, "/v1/orders")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Order{}} = Stripe.Order.retrieve("order_123")
    assert_stripe_requested(:get, "/v1/orders/order_123")
  end

  test "is updateable" do
    params = %{metadata: %{key: "value"}}
    assert {:ok, %Stripe.Order{}} = Stripe.Order.update("order_123", params)
    assert_stripe_requested(:post, "/v1/orders/order_123")
  end

  test "is payable" do
    assert {:ok, %Stripe.Order{}} = Stripe.Order.pay("order_123")
    assert_stripe_requested(:pay, "/v1/orders/order_123/pay")
  end

  test "is returnable" do
    assert {:ok, %Stripe.OrderReturn{}} = Stripe.Order.return("order_123")
    assert_stripe_requested(:pay, "/v1/orders/order_123/returns")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: orders}} = Stripe.Order.list()
    assert_stripe_requested(:get, "/v1/orders")
    assert is_list(orders)
    assert %Stripe.Order{} = hd(orders)
  end
end


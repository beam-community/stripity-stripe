defmodule Stripe.Climate.OrderTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{
      product: "climp_123",
      metric_tons: "10.0",
      beneficiary: %{public_name: "Test Company"}
    }

    assert {:ok, %Stripe.Climate.Order{}} = Stripe.Climate.Order.create(params)
    assert_stripe_requested(:post, "/v1/climate/orders")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Climate.Order{}} = Stripe.Climate.Order.retrieve("co_123")
    assert_stripe_requested(:get, "/v1/climate/orders/co_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: orders}} = Stripe.Climate.Order.list()
    assert_stripe_requested(:get, "/v1/climate/orders")
    assert is_list(orders)
    assert %Stripe.Climate.Order{} = hd(orders)
  end

  test "is updateable" do
    assert {:ok, %Stripe.Climate.Order{}} =
             Stripe.Climate.Order.update("co_123", %{metadata: %{order_id: "6735"}})

    assert_stripe_requested(:post, "/v1/climate/orders/co_123")
  end

  test "is cancelable" do
    assert {:ok, %Stripe.Climate.Order{}} = Stripe.Climate.Order.cancel("co_123")
    assert_stripe_requested(:post, "/v1/climate/orders/co_123/cancel")
  end
end

defmodule Stripe.OrderReturnTest do
  use Stripe.StripeCase, async: true

  describe "retrieve/2" do
    test "retrieves an order return" do
      assert {:ok, %Stripe.OrderReturn{}} = Stripe.OrderReturn.retrieve("orret_123")
      assert_stripe_requested(:get, "/v1/order_returns/orret_123")
    end
  end

  describe "list/2" do
    test "lists all order returns" do
      assert {:ok, %Stripe.List{data: order_returns}} = Stripe.OrderReturn.list()
      assert_stripe_requested(:get, "/v1/order_returns")
      assert is_list(order_returns)
      assert %Stripe.OrderReturn{} = hd(order_returns)
    end
  end
end

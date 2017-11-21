defmodule Stripe.SubscriptionTest do
  use Stripe.StripeCase, async: true

  describe "retrieve/2" do
    test "retrieves a subscription" do
      assert {:ok, %Stripe.Subscription{}} = Stripe.Subscription.retrieve("sub_123")
      assert_stripe_requested :get, "/v1/subscriptions/sub_123"
    end
  end

  describe "create/2" do
    test "creates a subscription" do
      assert {:ok, %Stripe.Subscription{}} = Stripe.Subscription.create(%{
        customer: "cus_123"
      })
      assert_stripe_requested :post, "/v1/subscriptions"
    end
  end

  describe "update/2" do
    test "updates a subscription" do
      assert {:ok, subscription} = Stripe.Subscription.update("sub_123", %{metadata: %{foo: "bar"}})
      assert_stripe_requested :post, "/v1/subscriptions/#{subscription.id}"
    end

  end
  describe "delete/2" do
    test "deletes a subscription" do
      assert {:ok, %Stripe.Subscription{} = subscription} = Stripe.Subscription.delete("sub_123")
      assert_stripe_requested :delete, "/v1/subscriptions/#{subscription.id}"
    end
  end

  describe "list/2" do
    test "lists all subscriptions" do
      assert {:ok, %Stripe.List{data: subscriptions}} = Stripe.Subscription.list()
      assert_stripe_requested :get, "/v1/subscriptions"
      assert is_list(subscriptions)
      assert %Stripe.Subscription{} = hd(subscriptions)
    end
  end

  describe "delete_discount/2" do
    test "deletes a subscription's discount" do
      {:ok, subscription} = Stripe.Subscription.retrieve("sub_123")
      assert {:ok, _} = Stripe.Subscription.delete_discount("sub_123")
      assert_stripe_requested :delete, "/v1/subscriptions/#{subscription.id}/discount"
    end
  end
end

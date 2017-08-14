defmodule Stripe.SubscriptionTest do
  use Stripe.StripeCase, async: false

    test "is listable" do
      assert {:ok, %Stripe.List{data: subscriptions}} = Stripe.Subscription.list()
      assert_stripe_requested :get, "/v1/subscriptions"
      assert is_list(subscriptions)
      assert %Stripe.Subscription{} = hd(subscriptions)
    end

    test "is retrievable" do
      assert {:ok, %Stripe.Subscription{}} = Stripe.Subscription.retrieve("sub_123")
      assert_stripe_requested :get, "/v1/subscriptions/sub_123"
    end

    test "is creatable" do
      assert {:ok, %Stripe.Subscription{}} = Stripe.Subscription.create(%{
        customer: "cus_123"
      })
      assert_stripe_requested :post, "/v1/subscriptions"
    end

    @tag :disabled
    test "is saveable" do
      {:ok, subscription} = Stripe.Subscription.retrieve("sub_123")
      subscription = put_in(subscription.metadata["key"], "value")
      assert {:ok, %Stripe.Subscription{} = ssubscription} = Stripe.Subscription.save(subscription)
      assert ssubscription.id == subscription.id
      assert_stripe_requested :post, "/v1/subscriptions/#{subscription.id}"
    end

    test "is updateable" do
      assert {:ok, subscription} = Stripe.Subscription.update("sub_123", %{metadata: %{foo: "bar"}})
      assert_stripe_requested :post, "/v1/subscriptions/#{subscription.id}"
    end

    test "is deletable" do
      {:ok, subscription} = Stripe.Subscription.retrieve("sub_123")
      assert {:ok, %Stripe.Subscription{}} = Stripe.Subscription.delete(subscription)
      assert_stripe_requested :delete, "/v1/subscriptions/#{subscription.id}"
    end

    test ".delete_discount deletes a subscription's discount" do
      {:ok, subscription} = Stripe.Subscription.retrieve("sub_123")
      assert {:ok, %Stripe.Subscription{discount: nil}} = Stripe.Subscription.delete_discount(subscription)
    end
end

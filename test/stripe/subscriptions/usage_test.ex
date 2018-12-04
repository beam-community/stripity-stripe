defmodule Stripe.SubscriptionItem.UsageTest do
  use Stripe.StripeCase, async: true
  
  describe "create/2" do
    test "create usage record" do
      item_id = Application.get_env(:stripity_stripe, :test_subscription_item)

      params = %{
        quantity: 10,
        subscription_item: item_id,
        timestamp: 1543335582
      }

      assert {:ok, record} = Stripe.SubscriptionItem.Usage.create(params)
      assert_stripe_requested(:post, "/v1/subscription_items/#{item_id}/usage_records")
    end
  end

  describe "list/2" do
    test "list usage records for subscription items" do
      item_id = Application.get_env(:stripity_stripe, :test_subscription_item)

      params = %{
        subscription_item: item_id
      }

      assert {:ok, %Stripe.List{data: usages}} = Stripe.SubscriptionItem.Usage.list(params)
      assert_stripe_requested(:get, "/v1/subscription_items")
      assert is_list(usages)
      assert %Stripe.SubscriptionItem.Usage{} = hd(usages)
    end
  end
end

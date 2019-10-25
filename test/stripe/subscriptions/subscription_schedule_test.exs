defmodule Stripe.SubscriptionScheduleTest do
  use Stripe.StripeCase, async: true

  @invalid_params %{
    customer: "cus_123",
    end_behavior: "release",
    phases: [
      %{
        coupon: nil,
        default_tax_rates: [],
        end_date: 1_557_566_037,
        start_date: 1_554_974_037,
        tax_percent: 0
      }
    ]
  }
  describe "retrieve/2" do
    test "retrieves a subscription" do
      assert {:ok, %Stripe.SubscriptionSchedule{}} =
               Stripe.SubscriptionSchedule.retrieve("sub_sched_123")

      assert_stripe_requested(:get, "/v1/subscription_schedules/sub_sched_123")
    end
  end

  describe "create/2" do
    test "creates a subscription schedule" do
      params = %{
        customer: "cus_123",
        end_behavior: "release",
        phases: [
          %{
            coupon: nil,
            default_tax_rates: [],
            end_date: 1_557_566_037,
            plans: [
              %{
                billing_thresholds: nil,
                plan: "some plan",
                quantity: 2,
                tax_rates: []
              }
            ],
            start_date: 1_554_974_037,
            tax_percent: 0
          }
        ]
      }

      assert {:ok, %Stripe.SubscriptionSchedule{}} = Stripe.SubscriptionSchedule.create(params)

      assert_stripe_requested(:post, "/v1/subscription_schedules")
    end

    test "fails with missing plans in phases" do
      assert {:error, %Stripe.Error{} = error} =
               Stripe.SubscriptionSchedule.create(@invalid_params)

      assert_stripe_requested(:post, "/v1/subscription_schedules")
    end
  end

  describe "update/2" do
    test "updates a subscription" do
      params = %{
        end_behavior: "release",
        phases: [
          %{
            coupon: nil,
            default_tax_rates: [],
            end_date: 1_557_566_037,
            plans: [
              %{
                billing_thresholds: nil,
                plan: "some plan",
                quantity: 2,
                tax_rates: []
              }
            ],
            start_date: 1_554_974_037,
            tax_percent: 0
          }
        ]
      }

      assert {:ok, subscription} = Stripe.SubscriptionSchedule.update("sub_sched_123", params)
      assert_stripe_requested(:post, "/v1/subscription_schedules/#{subscription.id}")
    end

    test "fails with missing plans in phases" do
      assert {:error, %Stripe.Error{}} =
               Stripe.SubscriptionSchedule.update("sub_sched_123", @invalid_params)

      assert_stripe_requested(:post, "/v1/subscription_schedules/sub_sched_123")
    end
  end

  describe "list/2" do
    test "lists all subscriptions" do
      assert {:ok, %Stripe.List{data: subscriptions}} = Stripe.SubscriptionSchedule.list()
      assert_stripe_requested(:get, "/v1/subscription_schedules")
      assert is_list(subscriptions)
      assert %Stripe.SubscriptionSchedule{} = hd(subscriptions)
    end
  end

  describe "cancel/2" do
    test "cancels a subscription schedule" do
      {:ok, subscription} = Stripe.SubscriptionSchedule.retrieve("sub_sched_123")
      assert_stripe_requested(:get, "/v1/subscription_schedules/#{subscription.id}")

      assert {:ok, _} = Stripe.SubscriptionSchedule.cancel("sub_sched_123")
      assert_stripe_requested(:post, "/v1/subscription_schedules/#{subscription.id}/cancel")
    end
  end

  describe "release/2" do
    test "releases a subscription schedule" do
      {:ok, subscription} = Stripe.SubscriptionSchedule.retrieve("sub_sched_123")
      assert_stripe_requested(:get, "/v1/subscription_schedules/#{subscription.id}")

      assert {:ok, _} = Stripe.SubscriptionSchedule.release("sub_sched_123")
      assert_stripe_requested(:post, "/v1/subscription_schedules/#{subscription.id}/release")
    end
  end
end

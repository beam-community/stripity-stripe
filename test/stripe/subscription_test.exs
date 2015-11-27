defmodule Stripe.SubscriptionTest do
  use ExUnit.Case

  setup do
    setup_plans
    register_teardown_plans
    setup_subscription
  end

    @tag disabled: false
  test "Listing subscriptions works", %{customer: customer, sub: sub} do
    case Stripe.Customers.get_subscriptions customer.id do
      {:ok, subs} -> assert subs
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "A sub is created", %{customer: customer, sub: sub} do
    assert sub["id"]
  end

  @tag disabled: false
  test "Retrieving the sub works", %{customer: customer, sub: sub} do
    case Stripe.Customers.get_subcription customer.id, sub["id"] do
      {:ok, found} -> assert found.id
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "Changing the sub works", %{customer: customer, sub: sub} do
    case Stripe.Customers.change_subscription customer.id, sub["id"], plan: "premium" do
      {:ok, changed} -> assert changed.plan["name"] == "premium"
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "Sub cancellation works", %{customer: customer, sub: sub} do
    case Stripe.Customers.cancel_subscription customer.id, sub["id"] do
      {:ok, canceled_sub} -> assert canceled_sub.id
      {:error, err} -> flunk err
    end
  end

  #create test plans: standard and premium
  defp setup_plans do
    case Stripe.Plans.create([id: "standard", name: "standard", amount: 1000]) do
      {:ok, plan} -> assert plan.id == "standard"
      {:error, err} -> flunk err
    end
    case Stripe.Plans.create([id: "premium", name: "premium", amount: 2000]) do
      {:ok, plan} -> assert plan.id == "premium"
      {:error, err} -> flunk err
    end
  end

  #cleanup test plans
  defp register_teardown_plans do
    on_exit fn ->
        case Stripe.Plans.delete "standard" do
            {:ok, plan} -> assert plan.deleted
            {:error, err} -> flunk err
        end
        case Stripe.Plans.delete "premium" do
            {:ok, plan} -> assert plan.deleted
            {:error, err} -> flunk err
        end
    end
   end

  #create a sub with nothing but a card
  defp setup_subscription do
    new_sub = [
      email: "jill@test.com",
      description: "Jill Test Account",
      plan: "standard",
      source: [
        object: "card",
        number: "4111111111111111",
        exp_month: 01,
        exp_year: 2018,
        cvc: 123,
        name: "Jill Subscriber"
      ]
    ]

    case Stripe.Customers.create_subscription new_sub do
      {:ok, customer} -> {:ok, [customer: customer, sub: List.first(customer.subscriptions["data"])]}
      {:error, err} -> flunk err
    end
  end
end

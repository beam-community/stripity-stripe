defmodule Stripe.SubscriptionTest do
  use ExUnit.Case

  setup do
    #create a sub with nothing but a card
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

  test "Listing subscriptions works", %{customer: customer, sub: sub} do
    case Stripe.Customers.get_subscriptions customer.id do
      {:ok, subs} -> assert subs
      {:error, err} -> flunk err
    end
  end

  test "A sub is created", %{customer: customer, sub: sub} do
    assert sub["id"]
  end

  test "Retrieving the sub works", %{customer: customer, sub: sub} do
    case Stripe.Customers.get_subcription customer.id, sub["id"] do
      {:ok, found} -> assert found.id
      {:error, err} -> flunk err
    end
  end

  test "Changing the sub works", %{customer: customer, sub: sub} do
    case Stripe.Customers.change_subscription customer.id, sub["id"], plan: "premium" do
      {:ok, changed} -> assert changed.plan["name"] == "Premium Plan"
      {:error, err} -> flunk err
    end
  end

  test "Sub cancellation works", %{customer: customer, sub: sub} do
    case Stripe.Customers.cancel_subscription customer.id, sub["id"] do
      {:ok, canceled_sub} -> assert canceled_sub.id
      {:error, err} -> flunk err
    end
  end

end

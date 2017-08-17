defmodule Stripe.PlanTest do
  use Stripe.StripeCase, async: true

  test "is listable" do
    assert {:ok, %Stripe.List{data: plans}} = Stripe.Plan.list()
    assert_stripe_requested :get, "/v1/plans"
    assert is_list(plans)
    assert %Stripe.Plan{} = hd(plans)
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Plan{}} = Stripe.Plan.retrieve("sapphire-elite")
    assert_stripe_requested :get, "/v1/plans/sapphire-elite"
  end

  test "is creatable" do
    assert {:ok, %Stripe.Plan{}} = Stripe.Plan.create(%{
      amount: 5000,
      interval: "month",
      name: "Sapphire elite",
      currency: "usd",
      id: "sapphire-elite"
    })
    assert_stripe_requested :post, "/v1/plans"
  end

  test "is updateable" do
    assert {:ok, plan} = Stripe.Plan.update("sapphire-elite", %{metadata: %{foo: "bar"}})
    assert_stripe_requested :post, "/v1/plans/#{plan.id}"
  end

  test "is deletable" do
    {:ok, plan} = Stripe.Plan.retrieve("sapphire-elite")
    assert {:ok, %Stripe.Plan{}} = Stripe.Plan.delete(plan)
    assert_stripe_requested :delete, "/v1/plans/#{plan.id}"
  end
end

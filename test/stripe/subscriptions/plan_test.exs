defmodule Stripe.PlanTest do
  use Stripe.StripeCase, async: true

  describe "create/2" do
    test "creates a Plan for a customer" do
      assert {:ok, %Stripe.Plan{}} = Stripe.Plan.create(%{
        amount: 5000,
        interval: "month",
        name: "Sapphire elite",
        currency: "usd",
        id: "sapphire-elite"})
      assert_stripe_requested :post, "/v1/plans"
    end
  end

  describe "retrieve/2" do
    test "retrieves a Plan" do
      assert {:ok, %Stripe.Plan{}} = Stripe.Plan.retrieve("sapphire-elite")
      assert_stripe_requested :get, "/v1/plans/sapphire-elite"
    end
  end

  describe "update/2" do
    test "updates a Plan" do
      assert {:ok, plan} = Stripe.Plan.update("sapphire-elite", %{metadata: %{foo: "bar"}})
      assert_stripe_requested :post, "/v1/plans/#{plan.id}"
    end
  end

  describe "delete/2" do
    test "deletes a Plan" do
      {:ok, plan} = Stripe.Plan.retrieve("sapphire-elite")
      assert {:ok, %Stripe.Plan{}} = Stripe.Plan.delete(plan)
      assert_stripe_requested :delete, "/v1/plans/#{plan.id}"
    end
  end

  describe "list/2" do
    test "lists all Plans" do
      assert {:ok, %Stripe.List{data: plans}} = Stripe.Plan.list()
      assert_stripe_requested :get, "/v1/plans"
      assert is_list(plans)
      assert %Stripe.Plan{} = hd(plans)
    end
  end
end
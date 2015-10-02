defmodule Stripe.PlanTest do
  use ExUnit.Case


  test "Plan creation works" do
    case Stripe.Plans.create([id: "test-plan", name: "Test Plan", amount: 1000]) do
      {:ok, plan} -> assert plan.id == "test-plan"
      {:error, err} -> flunk err
    end
  end

  test "Plan change works" do
    case Stripe.Plans.change("test-plan",[name: "Other Plan"]) do
      {:ok, plan} -> assert plan.name == "Other Plan"
      {:error, err} -> flunk err
    end
  end

  test "Listing plans" do
    case Stripe.Plans.list() do
      {:ok, plans} -> assert length(plans) > 0
      {:error, err} -> flunk err
    end
  end

  test "Plan deletion works" do
    case Stripe.Plans.delete "test-plan" do
      {:ok, plan} -> assert plan.deleted
      {:error, err} -> flunk err
    end
  end

end

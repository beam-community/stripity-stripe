defmodule Stripe.PlanTest do
  use ExUnit.Case

  setup_all do
    Stripe.Plans.delete_all
    :ok
end

  test "Creation" do
    case Stripe.Plans.create([id: "test-plan", name: "Test Plan", amount: 1000]) do
      {:ok, plan} -> assert plan.id == "test-plan"
      {:error, err} -> flunk err
    end
  end
  
  test "Creation w/key" do
    case Stripe.Plans.create([id: "test-plan2", name: "Test Plan 2", amount: 1000], Stripe.config_or_env_key) do
      {:ok, plan} -> assert plan.id == "test-plan2"
      {:error, err} -> flunk err
    end
  end

  test "Count" do
    case Stripe.Plans.count do
      {:ok, cnt} -> assert cnt == 2
      {:error, err} -> flunk err
    end
  end

  test "Count w/key" do
    case Stripe.Plans.count Stripe.config_or_env_key do
      {:ok, cnt} -> assert cnt == 2
      {:error, err} -> flunk err
    end
  end
  
  test "Plan change" do
    case Stripe.Plans.change("test-plan",[name: "Other Plan"]) do
      {:ok, plan} -> assert plan.name == "Other Plan"
      {:error, err} -> flunk err
    end
  end

  test "Plan change w/key" do
    case Stripe.Plans.change("test-plan",[name: "Other Plan2"], Stripe.config_or_env_key ) do
      {:ok, plan} -> assert plan.name == "Other Plan2"
      {:error, err} -> flunk err
    end
  end

  test "Listing plans" do
    case Stripe.Plans.list() do
      {:ok, plans} -> assert length(plans) > 0
      {:error, err} -> flunk err
    end
  end

  test "Listing plans w/key" do
    case Stripe.Plans.list(Stripe.config_or_env_key, 10) do
      {:ok, plans} -> assert length(plans) > 0
      {:error, err} -> flunk err
    end
  end

  test "Plan deletion" do
    case Stripe.Plans.delete "test-plan" do
      {:ok, plan} -> assert plan.deleted
      {:error, err} -> flunk err
    end
  end

  test "Plan deletion w/key" do
    case Stripe.Plans.delete "test-plan2" do
      {:ok, plan} -> assert plan.deleted
      {:error, err} -> flunk err
    end
  end

  test "All" do
    case Stripe.Plans.all  do
      {:ok, plans} -> assert plans
      {:error, err} -> flunk err
    end
  end

  test "All w/key" do
    case Stripe.Plans.all Stripe.config_or_env_key do
      {:ok, plans} -> assert plans
      {:error, err} -> flunk err
    end
  end

  test "Delete all" do
    case Stripe.Plans.delete_all  do
      {:ok} -> assert Stripe.Plans.count == {:ok,0}
      {:error, err} -> flunk err
    end
  end

  test "Delete all w/key" do
    Stripe.Plans.create([id: "test-plan1", name: "Test Plan1", amount: 1000])
    Stripe.Plans.create([id: "test-plan2", name: "Test Plan2", amount: 1000])

    case Stripe.Plans.delete_all Stripe.config_or_env_key do
      {:ok} -> assert Stripe.Plans.count == {:ok,0}
      {:error, err} -> flunk err
    end
    end
end

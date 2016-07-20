defmodule Stripe.PlanTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    use_cassette "plan_test/setup", match_requests_on: [:query, :request_body] do
      Stripe.Plans.delete_all
      :ok
    end
  end

  test "Creation" do
    use_cassette "plan_test/create", match_requests_on: [:query, :request_body] do
      case Stripe.Plans.create([id: "test-plan", name: "Test Plan", amount: 1000]) do
        {:ok, plan} -> assert plan.id == "test-plan"
        {:error, err} -> flunk err
      end
    end
  end

  test "Creation w/key" do
    use_cassette "plan_test/create_with_key", match_requests_on: [:query, :request_body] do
      case Stripe.Plans.create([id: "test-plan2", name: "Test Plan 2", amount: 1000], Stripe.config_or_env_key) do
        {:ok, plan} -> assert plan.id == "test-plan2"
        {:error, err} -> flunk err
      end
    end
  end

  test "Count" do
    use_cassette "plan_test/count", match_requests_on: [:query, :request_body] do
      case Stripe.Plans.count do
        {:ok, cnt} -> assert cnt == 2
        {:error, err} -> flunk err
      end
    end
  end

  test "Count w/key" do
    use_cassette "plan_test/count_with_key", match_requests_on: [:query, :request_body] do
      case Stripe.Plans.count Stripe.config_or_env_key do
        {:ok, cnt} -> assert cnt == 2
        {:error, err} -> flunk err
      end
    end
  end

  test "Plan change" do
    use_cassette "plan_test/change", match_requests_on: [:query, :request_body] do
      case Stripe.Plans.change("test-plan",[name: "Other Plan"]) do
        {:ok, plan} -> assert plan.name == "Other Plan"
        {:error, err} -> flunk err
      end
    end
  end

  test "Plan change w/key" do
    use_cassette "plan_test/change_with_key", match_requests_on: [:query, :request_body] do
      case Stripe.Plans.change("test-plan",[name: "Other Plan2"], Stripe.config_or_env_key ) do
        {:ok, plan} -> assert plan.name == "Other Plan2"
        {:error, err} -> flunk err
      end
    end
  end

  test "Listing plans" do
    use_cassette "plan_test/list", match_requests_on: [:query, :request_body] do
      case Stripe.Plans.list() do
        {:ok, plans} -> assert length(plans) > 0
        {:error, err} -> flunk err
      end
    end
  end

  test "Listing plans w/key" do
    use_cassette "plan_test/list_with_key", match_requests_on: [:query, :request_body] do
      case Stripe.Plans.list(Stripe.config_or_env_key, 10) do
        {:ok, plans} -> assert length(plans) > 0
        {:error, err} -> flunk err
      end
    end
  end

  test "Plan deletion" do
    use_cassette "plan_test/delete", match_requests_on: [:query, :request_body] do
      case Stripe.Plans.delete "test-plan" do
        {:ok, plan} -> assert plan.deleted
        {:error, err} -> flunk err
      end
    end
  end

  test "Plan deletion w/key" do
    use_cassette "plan_test/delete_with_key", match_requests_on: [:query, :request_body] do
      case Stripe.Plans.delete "test-plan2" do
        {:ok, plan} -> assert plan.deleted
        {:error, err} -> flunk err
      end
    end
  end

  test "All" do
    use_cassette "plan_test/all", match_requests_on: [:query, :request_body] do
      case Stripe.Plans.all  do
        {:ok, plans} -> assert plans
        {:error, err} -> flunk err
      end
    end
  end

  test "All w/key" do
    use_cassette "plan_test/all_with_key", match_requests_on: [:query, :request_body] do
      case Stripe.Plans.all Stripe.config_or_env_key do
        {:ok, plans} -> assert plans
        {:error, err} -> flunk err
      end
    end
  end

  test "Delete all" do
    use_cassette "plan_test/delete_all", match_requests_on: [:query, :request_body] do
      case Stripe.Plans.delete_all  do
        {:ok} -> assert Stripe.Plans.count == {:ok,0}
        {:error, err} -> flunk err
      end
    end
  end

  test "Delete all w/key" do
    use_cassette "plan_test/delete_all_with_key", match_requests_on: [:query, :request_body] do
      Stripe.Plans.create([id: "test-plan1", name: "Test Plan1", amount: 1000])
      Stripe.Plans.create([id: "test-plan2", name: "Test Plan2", amount: 1000])

      case Stripe.Plans.delete_all Stripe.config_or_env_key do
        {:ok} -> assert Stripe.Plans.count == {:ok,0}
        {:error, err} -> flunk err
      end
    end
  end
end

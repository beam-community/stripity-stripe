defmodule Stripe.UtilTest do
  use ExUnit.Case

  setup_all do
    Stripe.Plans.delete_all
    Helper.create_test_plans

    on_exit fn ->
      Stripe.Plans.delete_all
    end
    :ok
  end

  test "Count" do
    case Stripe.Util.count "plans" do
      {:ok, cnt} -> assert cnt == 2 
      {:error, err} -> flunk err
    end
  end
  test "Count w/key" do
    case Stripe.Util.count "plans", Stripe.config_or_env_key do
      {:ok, cnt} -> assert cnt == 2 
      {:error, err} -> flunk err
    end
  end
  test "list_raw" do
    case Stripe.Util.list_raw "plans" do
      {:ok, plans} -> assert plans 
      {:error, err} -> flunk err
    end
  end
  test "list_raw w/key" do
    case Stripe.Util.list_raw "plans", Stripe.config_or_env_key, 10, "" do
      {:ok, plans} -> assert plans
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "list works" do
    case Stripe.Util.list "plans" do
      {:ok, resp} ->
        assert Dict.size(resp[:data]) == 2
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "list w/key works" do
    case Stripe.Util.list "plans", Stripe.config_or_env_key,  "", 2  do
      {:ok, resp} -> assert Dict.size( resp[:data]) == 2 
      {:error, err} -> flunk err
    end
   end
end

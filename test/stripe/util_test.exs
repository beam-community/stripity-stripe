defmodule Stripe.UtilTest do
  use ExUnit.Case

  setup_all do
    Stripe.Plans.delete_all
    :ok
  end

  test "Count" do
    case Stripe.Util.count "plans" do
      {:ok, cnt} -> assert cnt == 0 
      {:error, err} -> flunk err
    end
  end
  test "Count w/key" do
    case Stripe.Util.count "plans", Stripe.config_or_env_key do
      {:ok, cnt} -> assert cnt == 0 
      {:error, err} -> flunk err
    end
  end
  test "list_raw" do
    case Stripe.Util.list_raw "plans" do
      {:ok, _} -> assert true 
      {:error, err} -> flunk err
    end
  end
  test "list_raw w/key" do
    case Stripe.Util.list_raw "plans", Stripe.config_or_env_key do
      {:ok, _} -> assert true 
      {:error, err} -> flunk err
    end
  end
end

defmodule Stripe.UtilTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    use_cassette "Stripe.UtilTest/setup" do
      Stripe.Plans.delete_all
      Helper.create_test_plans

      on_exit fn ->
        Stripe.Plans.delete_all
      end
      :ok
    end
  end

  test "Count" do
    use_cassette "Stripe.UtilTest/count" do
      case Stripe.Util.count "plans" do
        {:ok, cnt} -> assert cnt == 2
        {:error, err} -> flunk err
      end
    end
  end
  test "Count w/key" do
    use_cassette "Stripe.UtilTest/count_with_key" do
      case Stripe.Util.count "plans", Stripe.config_or_env_key do
        {:ok, cnt} -> assert cnt == 2
        {:error, err} -> flunk err
      end
    end
  end
  test "list_raw" do
    use_cassette "Stripe.UtilTest/list_raw" do
      case Stripe.Util.list_raw "plans" do
        {:ok, plans} -> assert plans
        {:error, err} -> flunk err
      end
    end
  end
  test "list_raw w/key" do
    use_cassette "Stripe.UtilTest/list_raw_with_key" do
      case Stripe.Util.list_raw "plans", Stripe.config_or_env_key, 10, "" do
        {:ok, plans} -> assert plans
        {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "list works" do
    use_cassette "Stripe.UtilTest/list" do
      case Stripe.Util.list "plans" do
        {:ok, resp} ->
          assert Dict.size(resp[:data]) == 2
          {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "list w/key works" do
    use_cassette "Stripe.UtilTest/list_with_key" do
      case Stripe.Util.list "plans", Stripe.config_or_env_key,  "", 2  do
        {:ok, resp} -> assert Dict.size( resp[:data]) == 2
        {:error, err} -> flunk err
      end
    end
  end
end

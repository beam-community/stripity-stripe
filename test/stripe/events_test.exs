defmodule Stripe.EventsTest do
  use ExUnit.Case

  setup_all do
    customer1 = Helper.create_test_customer "events_test1@localhost"
    customer2 = Helper.create_test_customer "events_test2@localhost"
    customer3 = Helper.create_test_customer "events_test3@localhost"
    customer4 = Helper.create_test_customer "events_test4@localhost"
    customer5 = Helper.create_test_customer "events_test5@localhost"
    customer6 = Helper.create_test_customer "events_test6@localhost"
    on_exit fn ->
      Stripe.Customers.delete customer1.id
      Stripe.Customers.delete customer2.id
      Stripe.Customers.delete customer3.id
      Stripe.Customers.delete customer4.id
      Stripe.Customers.delete customer5.id
      Stripe.Customers.delete customer6.id
    end
  end

  @tag disabled: false
  test "Count works" do
    case Stripe.Events.count do
      {:ok, cnt} -> assert cnt > 0
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "Count w/key works" do
    case Stripe.Events.count Stripe.config_or_env_key do
      {:ok, cnt} ->
        assert cnt > 0
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "List works" do
    case Stripe.Events.list "",5 do
      {:ok, events} ->
        assert Dict.size(events[:data]) > 0
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "List w/key works" do
    case Stripe.Events.list Stripe.config_or_env_key,"", 5 do
      {:ok, events} -> assert Dict.size(events[:data]) > 0
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "List w/paging works" do
    {:ok,events} = Stripe.Events.list Stripe.config_or_env_key,"", 1

    case events[:has_more] do
      true ->
        last = List.last( events[:data] )
        case Stripe.Events.list Stripe.config_or_env_key,last["id"], 1 do
          {:ok, events} -> assert Dict.size(events[:data]) > 0
          {:error,err} -> flunk err
        end
      false -> flunk "should have had more than 1 page. Check setup to make sure theres enough events for the test to run properly (5+)"
    end
  end
  
  @tag disabled: false
  test "Get works" do
    {:ok, events} = Stripe.Events.list "",1
    evt = hd events[:data]
    case Stripe.Events.get evt["id"]  do
      {:ok, event} ->
        assert event[:object] == "event"
      {:error, err} -> flunk err
    end
  end
  @tag disabled: false
  test "Get w/key works" do
    {:ok, events} = Stripe.Events.list "",1
    evt = hd events[:data]
    case Stripe.Events.get Stripe.config_or_env_key, evt["id"]   do
      {:ok, event} ->
        assert event[:object] == "event"
      {:error, err} -> flunk err
    end
    end
end

defmodule Stripe.CustomerTest do
  use ExUnit.Case

  setup_all do
    Stripe.Customers.delete_all
    customer2 = Helper.create_test_customer "customer_test1@localhost"

    new_customer = [
      email: "test@test.com",
      description: "An Elixir Test Account",
      metadata: [
        app_order_id: "ABC123",
        app_attr1: "xyz"
       ], 
      card: [
        number: "4111111111111111",
        exp_month: 01,
        exp_year: 2018,
        cvc: 123,
        name: "Joe Test User"
      ]  
    ]
    case Stripe.Customers.create new_customer do
      {:ok, customer} ->
        on_exit fn ->
          Stripe.Customers.delete customer.id
        end
        {:ok, [customer: customer, customer2: customer2]}

      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "Metadata works", %{customer: customer, customer2: _}  do
    assert customer.metadata["app_order_id"] == "ABC123"
    assert customer.metadata["app_attr1"] == "xyz"
  end
  
  @tag disabled: false
  test "Count works", %{customer: _, customer2: _}  do
    case Stripe.Customers.count do
      {:ok, cnt} -> assert cnt == 2
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "Count w/key works", %{customer: _, customer2: _}  do
    case Stripe.Customers.count Stripe.config_or_env_key do
      {:ok, cnt} -> assert cnt == 2
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "List works", %{customer: _, customer2: _}  do
    case Stripe.Customers.list "", 1 do
      {:ok, res} ->
        assert Dict.size(res[:data]) == 1
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "List w/key works", %{customer: _, customer2: _}  do
    case Stripe.Customers.list Stripe.config_or_env_key,"", 1 do
      {:ok, res} ->
        assert Dict.size(res[:data]) == 1
      {:error, err} -> flunk err
    end
  end
  
  @tag disabled: false
  test "Retrieve all works", %{customer: _, customer2: _} do
    case Stripe.Customers.all [],"" do
      {:ok, custs} ->
         assert Dict.size(custs) > 0
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "Retrieve w/key all works", %{customer: _, customer2: _} do
    case Stripe.Customers.all Stripe.config_or_env_key, [], "" do
      {:ok, custs} ->
       assert Dict.size(custs) > 0
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "Create works", %{customer: customer, customer2: _} do
    assert customer.id
  end

  @tag disabled: false
  test "Retrieve single works", %{customer: customer, customer2: _} do
    case Stripe.Customers.get customer.id do
      {:ok, found} -> assert found.id == customer.id
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "Delete works", %{customer: customer, customer2: _} do
    case Stripe.Customers.delete customer.id do
      {:ok, res} -> assert res.deleted
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "Delete w/key works", %{customer: _, customer2: customer2 } do
    case Stripe.Customers.delete customer2.id, Stripe.config_or_env_key do
      {:ok, res} -> assert res.deleted
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "Delete all works", %{customer: _, customer2: _} do
   Helper.create_test_customer "t1@localhost"
   Helper.create_test_customer "t2@localhost"
   Stripe.Customers.delete_all

    case Stripe.Customers.count do
      {:ok, cnt} -> assert cnt == 0
      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "Delete all w/key works", %{customer: _, customer2: _} do
    Helper.create_test_customer "t1@localhost"
    Helper.create_test_customer "t2@localhost"
    Stripe.Customers.delete_all Stripe.config_or_env_key

    case Stripe.Customers.count do
      {:ok, cnt} -> assert cnt == 0
      {:error, err} -> flunk err
    end
  end
end

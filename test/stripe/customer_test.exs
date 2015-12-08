defmodule Stripe.CustomerTest do
  use ExUnit.Case

  setup_all do
    Stripe.Customers.delete_all

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
        {:ok, [customer: customer]}

      {:error, err} -> flunk err
    end
  end

  @tag disabled: false
  test "Metadata works", %{customer: customer}  do
    assert customer.metadata["app_order_id"] == "ABC123"
    assert customer.metadata["app_attr1"] == "xyz"
  end
  
  
  @tag disabled: false
  test "Count works", %{customer: _}  do
    case Stripe.Customers.count do
      {:ok, cnt} -> assert cnt == 1
      {:error, err} -> flunk err
    end
  end
  
  @tag disabled: false
  test "Retrieve all works", %{customer: _} do
    case Stripe.Customers.all do
      {:ok, subs} ->
        assert Enum.count(subs) == 1
      {:error, err} -> flunk err
    end
  end
  
  @tag disabled: false
  test "Create works", %{customer: customer} do
    assert customer.id
  end

  test "Retrieve list works" do
    {:ok, customers} = Stripe.Customers.list
    assert length(customers) > 0
  end

  test "Retrieve single works", %{customer: customer} do
    case Stripe.Customers.get customer.id do
      {:ok, found} -> assert found.id == customer.id
      {:error, err} -> flunk err
    end
  end

  test "Delete single works", %{customer: customer} do
    case Stripe.Customers.delete customer.id do
      {:ok, res} -> assert res.deleted
      {:error, err} -> flunk err
    end
  end

  test "Delete all works", %{customer: _} do
   Helper.create_test_customer "t1@localhost"
   Helper.create_test_customer "t2@localhost"
   Stripe.Customers.delete_all

    case Stripe.Customers.count do
      {:ok, cnt} -> assert cnt == 0
      {:error, err} -> flunk err
    end
  end
end

defmodule Stripe.CustomerTest do
  use ExUnit.Case

  setup do
    new_customer = [
      email: "test@test.com",
      description: "An Elixir Test Account",
      card: [
        number: "4111111111111111",
        exp_month: 01,
        exp_year: 2018,
        cvc: 123,
        name: "Joe Test User"
      ]
    ]
    res = Stripe.Customers.create new_customer
    case res do
      {:ok, customer} -> {:ok, [res: customer]}
      {:error, err} -> flunk err
    end

  end
  test "Creating a customer with valid params succeeds", %{res: customer} do
    assert customer.id
  end

  test "Customers are listed" do
    {:ok, customers} = Stripe.Customers.list
    assert length(customers) > 0
  end

  test "Finding a customer by id works", %{res: customer} do
    case Stripe.Customers.get customer.id do
      {:ok, found} -> assert found.id == customer.id
      {:error, err} -> flunk err
    end
  end

  test "Deleting a customer succeeds", %{res: customer} do
    case Stripe.Customers.delete customer.id do
      {:ok, res} -> assert res.deleted
      {:error, err} -> flunk err
    end

  end


end

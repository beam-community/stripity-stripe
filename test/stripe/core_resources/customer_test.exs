defmodule Stripe.CustomerTest do
  use Stripe.StripeCase, async: true

  test "exports functions" do
    assert [
      {:__from_json__, 1},
      {:__struct__, 0},
      {:__struct__, 1},
      {:balance_transactions, 1},
      {:balance_transactions, 2},
      {:balance_transactions, 3},
      {:create, 0},
      {:create, 1},
      {:create, 2},
      {:create_funding_instructions, 1},
      {:create_funding_instructions, 2},
      {:create_funding_instructions, 3},
      {:delete, 1},
      {:delete, 2},
      {:delete_discount, 1},
      {:delete_discount, 2},
      {:fund_cash_balance, 1},
      {:fund_cash_balance, 2},
      {:fund_cash_balance, 3},
      {:list, 0},
      {:list, 1},
      {:list, 2},
      {:list_payment_methods, 1},
      {:list_payment_methods, 2},
      {:list_payment_methods, 3},
      {:retrieve, 1},
      {:retrieve, 2},
      {:retrieve, 3},
      {:retrieve_payment_method, 2},
      {:retrieve_payment_method, 3},
      {:retrieve_payment_method, 4},
      {:search, 0},
      {:search, 1},
      {:search, 2},
      {:update, 1},
      {:update, 2},
      {:update, 3},
    ] = Stripe.Customer.__info__(:functions)
  end

  test "is creatable" do
    assert {:ok, %Stripe.Customer{}} = Stripe.Customer.create(%{})
    assert_stripe_requested(:post, "/v1/customers")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Customer{}} = Stripe.Customer.retrieve("cus_123")
    assert_stripe_requested(:get, "/v1/customers/cus_123")
  end

  test "is updateable" do
    params = %{metadata: %{key: "value"}}
    assert {:ok, %Stripe.Customer{}} = Stripe.Customer.update("cus_123", params)
    assert_stripe_requested(:post, "/v1/customers/cus_123")
  end

  test "is deletable" do
    {:ok, customer} = Stripe.Customer.retrieve("cus_123")
    assert_stripe_requested(:get, "/v1/customers/#{customer.id}")

    assert {:ok, %Stripe.Customer{}} = Stripe.Customer.delete(customer.id)
    assert_stripe_requested(:delete, "/v1/customers/#{customer.id}")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: customers}} = Stripe.Customer.list()
    assert_stripe_requested(:get, "/v1/customers")
    assert is_list(customers)
    assert %Stripe.Customer{} = hd(customers)
  end

  test "is searchable" do
    search_query = "name:'fakename' AND metadata['foo']:'bar'"

    assert {:ok, %Stripe.SearchResult{data: customers}} =
             Stripe.Customer.search(%{query: search_query})

    assert_stripe_requested(:get, "/v1/customers/search", query: [query: search_query])
    assert is_list(customers)
    assert %Stripe.Customer{} = hd(customers)
  end

  describe "delete_discount/2" do
    test "deletes a customer's discount" do
      {:ok, customer} = Stripe.Customer.retrieve("sub_123")
      assert_stripe_requested(:get, "/v1/customers/#{customer.id}")

      assert {:ok, _} = Stripe.Customer.delete_discount("sub_123")
      assert_stripe_requested(:delete, "/v1/customers/#{customer.id}/discount")
    end
  end
end

defmodule Stripe.CustomerBalanceTransactionTest do
  use Stripe.StripeCase, async: true

  describe "create/3 creates a Customer Balance Transaction" do
    test "with a customer ID" do
      customer_id = "cust_123"

      params = %{
        amount: 500,
        currency: "usd"
      }

      assert {:ok, %Stripe.CustomerBalanceTransaction{}} =
               Stripe.CustomerBalanceTransaction.create(customer_id, params)

      assert_stripe_requested(:post, "/v1/customers/#{customer_id}/balance_transactions")
    end

    test "with a Customer struct" do
      customer_id = "cust_123"
      customer = %Stripe.Customer{id: customer_id}

      params = %{
        amount: 500,
        currency: "usd"
      }

      assert {:ok, %Stripe.CustomerBalanceTransaction{}} =
               Stripe.CustomerBalanceTransaction.create(customer, params)

      assert_stripe_requested(:post, "/v1/customers/#{customer_id}/balance_transactions")
    end
  end

  describe "retrieve/3" do
    test "retrieves a Customer Balance Transaction" do
      customer_id = "cust_123"
      balance_transaction_id = "trx_456"

      assert {:ok, %Stripe.CustomerBalanceTransaction{}} =
               Stripe.CustomerBalanceTransaction.retrieve(customer_id, balance_transaction_id)

      assert_stripe_requested(
        :get,
        "/v1/customers/#{customer_id}/balance_transactions/#{balance_transaction_id}"
      )
    end
  end

  describe "update/4" do
    test "updates a Customer Balance Transaction" do
      customer_id = "cust_123"
      balance_transaction_id = "trx_456"
      params = %{metadata: %{foo: "bar"}}

      assert {:ok, %Stripe.CustomerBalanceTransaction{}} =
               Stripe.CustomerBalanceTransaction.update(
                 customer_id,
                 balance_transaction_id,
                 params
               )

      assert_stripe_requested(
        :post,
        "/v1/customers/#{customer_id}/balance_transactions/#{balance_transaction_id}"
      )
    end
  end

  describe "list/3" do
    test "lists all Customer Balance Transactions" do
      customer_id = "cust_123"

      assert {:ok, %Stripe.List{data: [%Stripe.CustomerBalanceTransaction{} | _]}} =
               Stripe.CustomerBalanceTransaction.list(customer_id)

      assert_stripe_requested(:get, "/v1/customers/#{customer_id}/balance_transactions")
    end
  end
end

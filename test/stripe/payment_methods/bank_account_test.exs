defmodule Stripe.BankAccountTest do
  use Stripe.StripeCase, async: true

  describe "create/2" do
    test "creates a bank account for a customer" do
      assert {:ok, _} = Stripe.BankAccount.create(%{customer: "cus_123", source: "tok_amex"})
      assert_stripe_requested(:post, "/v1/customers/cus_123/sources")
    end
  end

  describe "retrieve/2" do
    test "retrieves a bank account" do
      assert {:ok, _} = Stripe.BankAccount.retrieve("ba_123", %{customer: "cus_123"})
      assert_stripe_requested(:get, "/v1/customers/cus_123/sources/ba_123")
    end
  end

  describe "update/2" do
    test "updates a bank account" do
      assert {:ok, _} = Stripe.BankAccount.update("ba_123", %{customer: "cus_123"})
      assert_stripe_requested(:post, "/v1/customers/cus_123/sources/ba_123")
    end
  end

  describe "delete/2" do
    test "deletes a bank account" do
      assert {:ok, _} = Stripe.BankAccount.delete("ba_123", %{customer: "cus_123"})
      assert_stripe_requested(:delete, "/v1/customers/cus_123/sources/ba_123")
    end
  end

  describe "verify/2" do
    test "verifys a bank account" do
      assert {:ok, _} = Stripe.BankAccount.verify("ba_123", %{customer: "cus_123"})
      assert_stripe_requested(:post, "/v1/customers/cus_123/sources/ba_123/verify")
    end
  end

  describe "list/2" do
    test "lists all bank accounts" do
      assert {:ok, %Stripe.List{data: bank_accounts}} =
               Stripe.BankAccount.list(%{customer: "cus_123"})

      assert_stripe_requested(:get, "/v1/customers/cus_123/sources?object=bank_account")
      assert is_list(bank_accounts)
    end
  end
end

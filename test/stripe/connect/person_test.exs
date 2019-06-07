defmodule Stripe.PersonTest do
  use Stripe.StripeCase, async: true

  describe "create/2" do
    test "creates a person for an account" do
      {:ok, _} = Stripe.Person.create(%{account: "acct_123", first_name: "Dennis"})

      assert_stripe_requested(:post, "/v1/accounts/acct_123/persons")
    end
  end

  describe "retrieve/2" do
    test "retrieves a person" do
      {:ok, _} = Stripe.Person.retrieve("person_123", %{account: "acct_123", id: "person_123"})
      assert_stripe_requested(:get, "/v1/accounts/acct_123/persons/person_123")
    end
  end

  describe "update/2" do
    test "updates a person" do
      {:ok, _} = Stripe.Person.update("person_123", %{account: "acct_123"})
      assert_stripe_requested(:post, "/v1/accounts/acct_123/persons/person_123")
    end
  end

  describe "delete/2" do
    test "deletes a person" do
      {:ok, _} = Stripe.Person.delete("person_123", %{account: "acct_123"})
      assert_stripe_requested(:delete, "/v1/accounts/acct_123/persons/person_123")
    end
  end

  describe "list/3" do
    test "lists all persons for an account" do
      {:ok, %Stripe.List{data: persons}} = Stripe.Person.list(%{account: "acct_123"})

      assert_stripe_requested(:get, "/v1/accounts/acct_123/persons")
      assert is_list(persons)
    end
  end
end

defmodule Stripe.SourceTest do
  use Stripe.StripeCase, async: true

  describe "source_transactions/1" do
    test "creates a source for a customer" do
      assert {:ok, %Stripe.List{data: _sources}} = Stripe.Source.source_transactions("src_123")
      assert_stripe_requested(:get, "/v1/sources/src_123/source_transactions")
    end
  end

  describe "create/1" do
    test "creates a source for a customer" do
      assert {:ok, %Stripe.Source{}} = Stripe.Source.create(%{type: "bitcoin"})
      assert_stripe_requested(:post, "/v1/sources")
    end
  end

  describe "retrieve/2" do
    test "retrieves a source" do
      assert {:ok, %Stripe.Source{}} = Stripe.Source.retrieve("src_123", %{})
      assert_stripe_requested(:get, "/v1/sources/src_123")
    end
  end

  describe "update/2" do
    test "updates a source" do
      assert {:ok, %Stripe.Source{}} = Stripe.Source.update("src_123", %{})
      assert_stripe_requested(:post, "/v1/sources/src_123")
    end
  end

  describe "verify/2" do
    test "verify a source to a customer" do
      assert {:ok, _} = Stripe.Source.verify("cus_123", %{values: ["123"]})

      assert_stripe_requested(:post, "/v1/sources/cus_123/verify")
    end
  end

  describe "detach/2" do
    test "detaches a source from a customer" do
      assert {:ok, %{id: "src_123"}} = Stripe.Source.detach("cus_123", "src_123")

      assert_stripe_requested(:delete, "/v1/customers/cus_123/sources/src_123")
    end
  end
end

defmodule Stripe.PaymentMethodTest do
  use Stripe.StripeCase, async: true

  describe "list/2" do
    test "lists all cards" do
      assert {:ok, %Stripe.List{data: cards}} =
               Stripe.PaymentMethod.list(%{customer: "cus_123", type: "card"})

      assert_stripe_requested(:get, "/v1/payment_methods?customer=cus_123&type=card")
      assert is_list(cards)
    end

    test "lists all cards with customer provided as struct" do
      assert {:ok, %Stripe.List{data: cards}} =
               Stripe.PaymentMethod.list(%{
                 customer: %Stripe.Customer{id: "cus_123"},
                 type: "card"
               })

      assert_stripe_requested(:get, "/v1/payment_methods?customer=cus_123&type=card")
      assert is_list(cards)
    end
  end

  describe "create/2" do
    test "creates a payment method" do
      assert {:ok, _} = Stripe.PaymentMethod.create(%{type: "card"})
      assert_stripe_requested(:post, "/v1/payment_methods")
    end
  end

  describe "retrieve/1" do
    test "retrieves a payment method" do
      assert {:ok, _} = Stripe.PaymentMethod.retrieve("pm_123")
      assert_stripe_requested(:get, "/v1/payment_methods/pm_123")
    end
  end

  describe "update/2" do
    test "updates a payment method" do
      assert {:ok, _} = Stripe.PaymentMethod.update("pm_123", %{})
      assert_stripe_requested(:post, "/v1/payment_methods/pm_123")
    end
  end

  describe "attach/2" do
    test "attaches payment method to customer" do
      assert {:ok, %Stripe.PaymentMethod{}} =
               Stripe.PaymentMethod.attach(%{customer: "cus_123", payment_method: "pm_123"})

      assert_stripe_requested(:post, "/v1/payment_methods/pm_123/attach",
        body: %{customer: "cus_123"}
      )
    end

    test "attaches payment method to customer with customer provided as struct" do
      assert {:ok, %Stripe.PaymentMethod{}} =
               Stripe.PaymentMethod.attach(%{
                 customer: %Stripe.Customer{id: "cus_123"},
                 payment_method: "pm_123"
               })

      assert_stripe_requested(:post, "/v1/payment_methods/pm_123/attach",
        body: %{customer: "cus_123"}
      )
    end

    test "attaches payment method to customer with payment method provided as struct" do
      assert {:ok, %Stripe.PaymentMethod{}} =
               Stripe.PaymentMethod.attach(%{
                 customer: "cus_123",
                 payment_method: %Stripe.PaymentMethod{id: "pm_123"}
               })

      assert_stripe_requested(:post, "/v1/payment_methods/pm_123/attach",
        body: %{customer: "cus_123"}
      )
    end
  end

  describe "detach/2" do
    test "detaches payment method from customer" do
      assert {:ok, %Stripe.PaymentMethod{}} =
               Stripe.PaymentMethod.detach(%{customer: "cus_123", payment_method: "pm_123"})

      assert_stripe_requested(:post, "/v1/payment_methods/pm_123/detach")
    end

    test "detaches payment method from customer with payment method provided as struct" do
      assert {:ok, %Stripe.PaymentMethod{}} =
               Stripe.PaymentMethod.detach(%{
                 customer: "cus_123",
                 payment_method: %Stripe.PaymentMethod{id: "pm_123"}
               })

      assert_stripe_requested(:post, "/v1/payment_methods/pm_123/detach")
    end
  end
end

defmodule Stripe.Terminal.ReaderTest do
  use Stripe.StripeCase, async: true

  describe "Retrieve" do
    test "retrieve reader" do
      assert {:ok, %Stripe.Terminal.Reader{}} =
               Stripe.Terminal.Reader.retrieve("tmr_P400-123-456-789")

      assert_stripe_requested(:get, "/v1/terminal/readers/tmr_P400-123-456-789")
    end
  end

  describe "Create" do
    test "create reader" do
      params = %{
        registration_code: "puppies-plug-could",
        label: "Blue Rabbit",
        location: "tml_1234"
      }

      assert {:ok, %Stripe.Terminal.Reader{}} = Stripe.Terminal.Reader.create(params)
      assert_stripe_requested(:post, "/v1/terminal/readers")
    end
  end

  describe "Delete" do
    test "delete reader" do
      assert {:ok, %Stripe.Terminal.Reader{}} =
               Stripe.Terminal.Reader.delete("tmr_P400-123-456-789")

      assert_stripe_requested(:delete, "/v1/terminal/readers/tmr_P400-123-456-789")
    end
  end

  describe "Update" do
    test "updates reader" do
      assert {:ok, %Stripe.Terminal.Reader{label: "Blue Rabbit"}} =
               Stripe.Terminal.Reader.update("tmr_P400-123-456-789", %{
                 label: "Blue Rabbit"
               })

      assert_stripe_requested(:post, "/v1/terminal/readers/tmr_P400-123-456-789")
    end
  end

  describe "List" do
    test "list readers" do
      assert {:ok, %Stripe.List{data: readers}} = Stripe.Terminal.Reader.list()

      assert_stripe_requested(:get, "/v1/terminal/readers")
      assert is_list(readers)
      assert %Stripe.Terminal.Reader{} = hd(readers)
    end
  end
end

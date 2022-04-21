defmodule Stripe.TestClockTest do
  use Stripe.StripeCase, async: true

  describe "create/2" do
    test "creates a test clock" do
      assert {:ok, %Stripe.TestClock{}} =
               Stripe.TestClock.create(%{frozen_time: unix_timestamp_now()})

      assert_stripe_requested(:post, "/v1/test_helpers/test_clocks")
    end
  end

  describe "retrieve/2" do
    test "retrieves a test clock" do
      assert {:ok, %Stripe.TestClock{}} = Stripe.TestClock.retrieve("clock_123")
      assert_stripe_requested(:get, "/v1/test_helpers/test_clocks/clock_123")
    end
  end

  describe "advance/2" do
    test "advances a test clock" do
      timestamp = DateTime.to_unix(DateTime.utc_now())

      assert {:ok, %Stripe.TestClock{}} =
               Stripe.TestClock.advance("clock_123", %{frozen_time: timestamp})

      assert_stripe_requested(:post, "/v1/test_helpers/test_clocks/clock_123/advance")
    end
  end

  describe "delete/2" do
    test "deletes a test clock" do
      assert {:ok, %Stripe.TestClock{}} = Stripe.TestClock.delete("clock_123")
      assert_stripe_requested(:delete, "/v1/test_helpers/test_clocks/clock_123")
    end
  end

  describe "list/2" do
    test "list all test clocks" do
      assert {:ok, %Stripe.List{data: test_clocks}} = Stripe.TestClock.list()
      assert_stripe_requested(:get, "/v1/test_helpers/test_clocks")
      assert is_list(test_clocks)
      assert %Stripe.TestClock{} = hd(test_clocks)
    end
  end

  defp unix_timestamp_now, do: DateTime.to_unix(DateTime.utc_now())
end

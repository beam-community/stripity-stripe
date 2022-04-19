defmodule Stripe.TestClockTest do
  use Stripe.StripeCase, async: true

  describe "create/2" do
    test "creates a test clock" do

      assert {:ok, %Stripe.TestClock{}} = Stripe.TestClock.create(%{frozen_time: unix_timestamp_now()})
      assert_stripe_requested(:post, "/v1/test_helpers/test_clocks")
    end
  end

  defp unix_timestamp_now, do: DateTime.to_unix(DateTime.utc_now())
end

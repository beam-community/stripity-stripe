defmodule Stripe.EventTest do
  use Stripe.StripeCase, async: true

  describe "retrieve/2" do
    test "retrieves an event" do
      assert {:ok, %Stripe.Event{}} = Stripe.Event.retrieve("evt_123")
      assert_stripe_requested(:get, "/v1/events/evt_123")
    end
  end

  describe "list/2" do
    test "lists all events" do
      assert {:ok, %Stripe.List{data: [%Stripe.Event{}]}} = Stripe.Event.list()
      assert_stripe_requested(:get, "/v1/events")
    end
  end
end

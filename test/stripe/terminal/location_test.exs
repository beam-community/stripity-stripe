defmodule Stripe.Terminal.LocationTest do
  use Stripe.StripeCase, async: true

  describe "Retrieve" do
    test "retrieve location" do
      assert {:ok, %Stripe.Terminal.Location{}} = Stripe.Terminal.Location.retrieve("loc_123")

      assert_stripe_requested(:get, "/v1/terminal/locations/loc_123")
    end
  end

  describe "Create" do
    test "create location" do
      params = %{
        address: %{
          line1: "123 Fake St",
          line2: "Apt 3",
          city: "Beverly Hills",
          state: "CA",
          postal_code: "90210",
          country: "US"
        },
        display_name: "My First Store"
      }

      assert {:ok, %Stripe.Terminal.Location{}} = Stripe.Terminal.Location.create(params)
      assert_stripe_requested(:post, "/v1/terminal/locations")
    end
  end

  describe "Delete" do
    test "delete location" do
      assert {:ok, %Stripe.Terminal.Location{}} = Stripe.Terminal.Location.delete("loc_123")
      assert_stripe_requested(:delete, "/v1/terminal/locations/loc_123")
    end
  end

  describe "Update" do
    test "updates location" do
      assert {:ok, %Stripe.Terminal.Location{display_name: "name"}} =
               Stripe.Terminal.Location.update("loc_123", %{
                 display_name: "name"
               })

      assert_stripe_requested(:post, "/v1/terminal/locations/loc_123")
    end
  end

  describe "List" do
    test "list locations" do
      assert {:ok, %Stripe.List{data: locations}} = Stripe.Terminal.Location.list()

      assert_stripe_requested(:get, "/v1/terminal/locations")
      assert is_list(locations)
      assert %Stripe.Terminal.Location{} = hd(locations)
    end
  end
end

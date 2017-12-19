defmodule Stripe.CountrySpecTest do
  use Stripe.StripeCase, async: true

  describe "retrieve/2" do
    test "retrieves a country spec" do
      assert {:ok, %Stripe.CountrySpec{}} = Stripe.CountrySpec.retrieve("US")
      assert_stripe_requested(:get, "/v1/country_specs/US")
    end
  end

  describe "list/2" do
    test "lists all country specs" do
      assert {:ok, %Stripe.List{data: country_specs}} = Stripe.CountrySpec.list()
      assert_stripe_requested(:get, "/v1/country_specs")
      assert is_list(country_specs)
      assert %Stripe.CountrySpec{} = hd(country_specs)
    end
  end
end

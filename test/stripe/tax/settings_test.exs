defmodule Stripe.Tax.SettingsTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.Tax.Settings{}} = Stripe.Tax.Settings.retrieve()
    assert_stripe_requested(:get, "/v1/tax/settings")
  end

  test "is updateable" do
    params = %{
      defaults: %{
        tax_code: "txcd_10000000",
        tax_behavior: :exclusive
      },
      head_office: %{
        address: %{
          line1: "354 Oyster Point Blvd",
          city: "South San Francisco",
          state: "CA",
          postal_code: "94080",
          country: "US"
        }
      }
    }

    assert {:ok, %Stripe.Tax.Settings{}} = Stripe.Tax.Settings.update(params)
    assert_stripe_requested(:post, "/v1/tax/settings")
  end
end

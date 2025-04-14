defmodule Stripe.Tax.RegistrationTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{
      country: "FR",
      country_options: %{
        fr: %{
          type: :standard
        }
      },
      active_from: :now
    }

    assert {:ok, %Stripe.Tax.Registration{}} = Stripe.Tax.Registration.create(params)
    assert_stripe_requested(:post, "/v1/tax/registrations")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Tax.Registration{}} =
             Stripe.Tax.Registration.retrieve("taxreg_123")

    assert_stripe_requested(:get, "/v1/tax/registrations/taxreg_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: registrations}} =
             Stripe.Tax.Registration.list()

    assert_stripe_requested(:get, "/v1/tax/registrations")
    assert is_list(registrations)
    assert %Stripe.Tax.Registration{} = hd(registrations)
  end

  test "is listable with status filter" do
    params = %{
      status: :active
    }

    assert {:ok, %Stripe.List{data: registrations}} =
             Stripe.Tax.Registration.list(params)

    assert_stripe_requested(:get, "/v1/tax/registrations", query: params)
    assert is_list(registrations)
    assert %Stripe.Tax.Registration{} = hd(registrations)
  end

  test "is updateable" do
    params = %{
      expires_at: :now
    }

    assert {:ok, %Stripe.Tax.Registration{}} =
             Stripe.Tax.Registration.update("taxreg_123", params)

    assert_stripe_requested(:post, "/v1/tax/registrations/taxreg_123")
  end
end

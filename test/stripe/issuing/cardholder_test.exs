defmodule Stripe.Issuing.CardholderTest do
  use Stripe.StripeCase, async: true

  alias Stripe.Issuing.Cardholder

  test "is creatable" do
    params = %{
      name: "Jenny Rosen",
      type: :individual,
      billing: %{
        address: %{
          line1: "123 Fake St",
          line2: "Apt 3",
          city: "Beverly Hills",
          state: "CA",
          postal_code: "90210",
          country: "US"
        }
      }
    }

    assert {:ok, %Cardholder{}} = Cardholder.create(params)

    assert_stripe_requested(:post, "/v1/issuing/cardholders")
  end

  test "is retrievable" do
    assert {:ok, %Cardholder{}} = Cardholder.retrieve("ich_123")
    assert_stripe_requested(:get, "/v1/issuing/cardholders/ich_123")
  end

  test "is updateable" do
    params = %{metadata: %{key: "value"}}

    assert {:ok, %Cardholder{}} =
             Cardholder.update("ich_123", params)

    assert_stripe_requested(:post, "/v1/issuing/cardholders/ich_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: cardholders}} = Cardholder.list()
    assert_stripe_requested(:get, "/v1/issuing/cardholders")
    assert is_list(cardholders)
    assert %Cardholder{} = hd(cardholders)
  end
end

defmodule Stripe.Issuing.CardTest do
  use Stripe.StripeCase, async: true

  describe "create/2" do
    test "is creatable" do
      params = %{
        currency: "usd",
        type: :virtual
      }

      assert {:ok, %Stripe.Issuing.Card{}} = Stripe.Issuing.Card.create(params)

      assert_stripe_requested(:post, "/v1/issuing/cards")
    end

    test "is creatable with cardholder id" do
      params = %{
        currency: "usd",
        type: :virtual,
        cardholder: "ich_123"
      }

      assert {:ok, %Stripe.Issuing.Card{}} = Stripe.Issuing.Card.create(params)

      assert_stripe_requested(:post, "/v1/issuing/cards")
    end

    test "is create with cardholder struct" do
      cardholder = %Stripe.Issuing.Cardholder{
        id: "ich_123",
        object: "issuing.cardholder",
        type: "individual"
      }

      params = %{
        currency: "usd",
        type: :virtual,
        cardholder: cardholder
      }

      assert {:ok, %Stripe.Issuing.Card{}} = Stripe.Issuing.Card.create(params)

      assert_stripe_requested(:post, "/v1/issuing/cards")
    end
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Issuing.Card{}} = Stripe.Issuing.Card.retrieve("ic_123")
    assert_stripe_requested(:get, "/v1/issuing/cards/ic_123")
  end

  test "is updateable" do
    params = %{metadata: %{key: "value"}}
    assert {:ok, %Stripe.Issuing.Card{}} = Stripe.Issuing.Card.update("ic_123", params)
    assert_stripe_requested(:post, "/v1/issuing/cards/ic_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: cards}} = Stripe.Issuing.Card.list()
    assert_stripe_requested(:get, "/v1/issuing/cards")
    assert is_list(cards)
    assert %Stripe.Issuing.Card{} = hd(cards)
  end
end

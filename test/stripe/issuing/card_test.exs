defmodule Stripe.Issuing.CardTest do
  use Stripe.StripeCase, async: true

  alias Stripe.Issuing.Card

  describe "create/2" do
    test "is creatable" do
      params = %{
        currency: "usd",
        type: :virtual
      }

      assert {:ok, %Card{}} = Card.create(params)

      assert_stripe_requested(:post, "/v1/issuing/cards")
    end

    test "is creatable with cardholder id" do
      params = %{
        currency: "usd",
        type: :virtual,
        cardholder: "ich_123"
      }

      assert {:ok, %Card{}} = Card.create(params)

      assert_stripe_requested(:post, "/v1/issuing/cards")
    end
  end

  test "is retrievable" do
    assert {:ok, %Card{}} = Card.retrieve("ic_123")
    assert_stripe_requested(:get, "/v1/issuing/cards/ic_123")
  end

  test "is updateable" do
    params = %{metadata: %{key: "value"}}
    assert {:ok, %Card{}} = Card.update("ic_123", params)
    assert_stripe_requested(:post, "/v1/issuing/cards/ic_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: cards}} = Card.list()
    assert_stripe_requested(:get, "/v1/issuing/cards")
    assert is_list(cards)
    assert %Card{} = hd(cards)
  end
end

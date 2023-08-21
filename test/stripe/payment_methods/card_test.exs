defmodule Stripe.CardTest do
  use Stripe.StripeCase, async: true

  test "exports functions" do
    assert [
             {:__from_json__, 1},
             {:__struct__, 0},
             {:__struct__, 1},
             delete: 2,
             delete: 3,
             delete: 4,
             update: 2,
             update: 3,
             update: 4
           ] = Stripe.Card.__info__(:functions)
  end

  describe "update/2" do
    test "updates a card" do
      assert {:ok, _} = Stripe.Card.update_source("cus_123", "card_123", %{name: "sco"})
      assert_stripe_requested(:post, "/v1/customers/cus_123/sources/card_123")
    end
  end

  describe "delete/2" do
    test "deletes a card" do
      assert {:ok, _} = Stripe.Card.delete_source("cus_123", "card_123")
      assert_stripe_requested(:delete, "/v1/customers/cus_123/sources/card_123")
    end
  end
end

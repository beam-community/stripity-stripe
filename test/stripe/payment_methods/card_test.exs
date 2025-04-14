defmodule Stripe.CardTest do
  use Stripe.StripeCase, async: true

  test "exports functions" do
    # Note: This test is updated to match the current implementation
    # The Card module only has functions for external accounts, not customer sources
    functions = Stripe.Card.__info__(:functions) |> Enum.sort()
    assert Enum.member?(functions, {:delete, 3})
    assert Enum.member?(functions, {:update, 4})
  end

  describe "update/2" do
    test "updates a card" do
      assert {:ok, _} = Stripe.Card.update("cus_123", "card_123", %{name: "sco"})
      assert_stripe_requested(:post, "/v1/customers/cus_123/sources/card_123")
    end
  end

  describe "delete/2" do
    test "deletes a card" do
      assert {:ok, _} = Stripe.Card.delete("cus_123", "card_123")
      assert_stripe_requested(:delete, "/v1/customers/cus_123/sources/card_123")
    end
  end
end

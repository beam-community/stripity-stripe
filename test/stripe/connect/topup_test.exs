defmodule Stripe.TopupTest do
  use Stripe.StripeCase, async: true

  describe "create/2" do
    test "is creatable" do
      params = %{
        amount: 100_000,
        currency: "usd"
      }

      assert {:ok, %Stripe.Topup{}} = Stripe.Topup.create(params)
      assert_stripe_requested(:post, "/v1/topups")
    end

    test "is creatable with source object" do
      params = %{
        amount: 100_000,
        currency: "usd",
        source: %Stripe.Source{
          id: "src_123"
        }
      }

      assert {:ok, %Stripe.Topup{}} = Stripe.Topup.create(params)
      assert_stripe_requested(:post, "/v1/topups")
    end
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Topup{}} = Stripe.Topup.retrieve("tu_123")
    assert_stripe_requested(:get, "/v1/topups/tu_123")
  end

  test "is updatable" do
    params = %{metadata: %{key: "value"}}
    assert {:ok, %Stripe.Topup{}} = Stripe.Topup.update("tu_123", params)
    assert_stripe_requested(:post, "/v1/topups/tu_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: topups}} = Stripe.Topup.list()
    assert_stripe_requested(:get, "/v1/topups")
    assert is_list(topups)
    assert %Stripe.Topup{} = hd(topups)
  end

  test "is cancelable" do
    assert {:ok, %Stripe.Topup{}} = Stripe.Topup.cancel("tu_123")
    assert_stripe_requested(:post, "/v1/topups/tu_123/cancel")
  end
end

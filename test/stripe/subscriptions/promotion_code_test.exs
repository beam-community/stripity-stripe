defmodule Stripe.PromotionCodeTest do
  use Stripe.StripeCase, async: true

  test "is listable" do
    assert {:ok, %Stripe.List{data: promotion_codes}} = Stripe.PromotionCode.list()
    assert_stripe_requested(:get, "/v1/promotion_codes")
    assert is_list(promotion_codes)
    assert %Stripe.PromotionCode{} = hd(promotion_codes)
  end

  test "is retrievable" do
    assert {:ok, %Stripe.PromotionCode{}} = Stripe.PromotionCode.retrieve("25OFF")
    assert_stripe_requested(:get, "/v1/promotion_codes/25OFF")
  end

  test "is creatable" do
    params = %{code: 25, coupon: "coupon_fake_id"}
    assert {:ok, %Stripe.PromotionCode{}} = Stripe.PromotionCode.create(params)
    assert_stripe_requested(:post, "/v1/promotion_codes")
  end

  test "is updateable" do
    assert {:ok, %Stripe.PromotionCode{}} =
             Stripe.PromotionCode.update("25OFF", %{metadata: %{key: "value"}})

    assert_stripe_requested(:post, "/v1/promotion_codes/25OFF")
  end
end

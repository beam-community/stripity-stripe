defmodule Stripe.PromotionCodeTest do
  use Stripe.StripeCase, async: true

  test "is listable" do
    assert {:ok, %Stripe.List{data: promotion_codes}} = Stripe.PromotionCode.list()
    assert_stripe_requested(:get, "/v1/promotion_codes")
    assert is_list(promotion_codes)
    assert %Stripe.PromotionCode{} = hd(promotion_codes)
  end

  test "is retrievable" do
    assert {:ok, %Stripe.PromotionCode{}} = Stripe.PromotionCode.retrieve("FALL20")
    assert_stripe_requested(:get, "/v1/promotion_codes/FALL20")
  end

  test "is creatable" do
    params = %{code: "FALL21", max_redemptions: 2, coupon: "25OFF"}
    assert {:ok, %Stripe.PromotionCode{}} = Stripe.PromotionCode.create(params)
    assert_stripe_requested(:post, "/v1/promotion_codes")
  end

  test "is updateable" do
    assert {:ok, %Stripe.PromotionCode{}} =
             Stripe.PromotionCode.update("FALL20", %{active: false, metadata: %{key: "value"}})

    assert_stripe_requested(:post, "/v1/promotion_codes/FALL20")
  end
end

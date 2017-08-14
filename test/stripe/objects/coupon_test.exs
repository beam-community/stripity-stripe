defmodule Stripe.CouponTest do
  use Stripe.StripeCase

  test "is listable" do
    assert {:ok, %Stripe.List{data: coupons}} = Stripe.Coupon.list()
    assert_stripe_requested :get, "/v1/coupons"
    assert is_list(coupons)
    assert %Stripe.Coupon{} = hd(coupons)
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Coupon{}} = Stripe.Coupon.retrieve("25OFF")
    assert_stripe_requested :get, "/v1/coupons/25OFF"
  end

  test "is creatable" do
    assert {:ok, %Stripe.Coupon{}} = Stripe.Coupon.create(%{
      percent_off: 25,
      duration: "repeating",
      duration_in_months: 3,
      id: "25OFF"
    })
    assert_stripe_requested :post, "/v1/coupons"
  end

  @tag :disabled
  test "is saveable" do
    {:ok, coupon} = Stripe.Coupon.retrieve("25OFF")
    coupon = put_in(coupon.metadata["key"], "value")
    assert {:ok, %Stripe.Coupon{} = scoupon} = Stripe.Coupon.save(coupon)
    assert coupon.id == scoupon.id
    assert_stripe_requested :post, "/v1/coupons/#{coupon.id}"
  end

  test "is updateable" do
    assert {:ok, %Stripe.Coupon{}} = Stripe.Coupon.update("25OFF", %{metadata: %{key: "value"}})
    assert_stripe_requested :post, "/v1/coupons/25OFF"
  end
end

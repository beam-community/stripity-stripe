defmodule Stripe.Climate.ProductTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.Climate.Product{}} = Stripe.Climate.Product.retrieve("prod_123")
    assert_stripe_requested(:get, "/v1/climate/products/prod_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: products}} = Stripe.Climate.Product.list()
    assert_stripe_requested(:get, "/v1/climate/products")
    assert is_list(products)
    assert %Stripe.Climate.Product{} = hd(products)
  end
end

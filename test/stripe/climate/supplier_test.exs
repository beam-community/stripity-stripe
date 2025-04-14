defmodule Stripe.Climate.SupplierTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.Climate.Supplier{}} = Stripe.Climate.Supplier.retrieve("sup_123")
    assert_stripe_requested(:get, "/v1/climate/suppliers/sup_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: suppliers}} = Stripe.Climate.Supplier.list()
    assert_stripe_requested(:get, "/v1/climate/suppliers")
    assert is_list(suppliers)
    assert %Stripe.Climate.Supplier{} = hd(suppliers)
  end
end

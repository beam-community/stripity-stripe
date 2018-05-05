defmodule Stripe.SkuTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    inventory = %{type: "finite", quantity: 500}
    assert {:ok, %Stripe.Sku{}} = Stripe.Sku.create(%{currency: "USD", product: "prod_123", price: 100, inventory: inventory})
    assert_stripe_requested(:post, "/v1/skus")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Sku{}} = Stripe.Sku.retrieve("sku_123")
    assert_stripe_requested(:get, "/v1/skus/sku_123")
  end

  test "is updateable" do
    params = %{metadata: %{key: "value"}}
    assert {:ok, %Stripe.Sku{}} = Stripe.Sku.update("sku_123", params)
    assert_stripe_requested(:post, "/v1/skus/sku_123")
  end

  test "is deleteable" do
    assert {:ok, %{deleted: deleted, id: _id}} = Stripe.Sku.delete("sku_123")
    assert_stripe_requested(:delete, "/v1/skus/sku_123/delete")
    assert deleted
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: _skus}} = Stripe.Sku.list()
    assert_stripe_requested(:get, "/v1/skus")
  end
end


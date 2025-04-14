defmodule Stripe.Issuing.PhysicalBundleTest do
  use Stripe.StripeCase, async: true

  test "is retrievable" do
    assert {:ok, %Stripe.Issuing.PhysicalBundle{}} =
             Stripe.Issuing.PhysicalBundle.retrieve("pb_123")

    assert_stripe_requested(:get, "/v1/issuing/physical_bundles/pb_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: bundles}} =
             Stripe.Issuing.PhysicalBundle.list()

    assert_stripe_requested(:get, "/v1/issuing/physical_bundles")
    assert is_list(bundles)
    assert %Stripe.Issuing.PhysicalBundle{} = hd(bundles)
  end

  test "is listable with status filter" do
    params = %{
      status: :active
    }

    assert {:ok, %Stripe.List{data: bundles}} =
             Stripe.Issuing.PhysicalBundle.list(params)

    assert_stripe_requested(:get, "/v1/issuing/physical_bundles", query: params)
    assert is_list(bundles)
    assert %Stripe.Issuing.PhysicalBundle{} = hd(bundles)
  end

  test "is listable with type filter" do
    params = %{
      type: :standard
    }

    assert {:ok, %Stripe.List{data: bundles}} =
             Stripe.Issuing.PhysicalBundle.list(params)

    assert_stripe_requested(:get, "/v1/issuing/physical_bundles", query: params)
    assert is_list(bundles)
    assert %Stripe.Issuing.PhysicalBundle{} = hd(bundles)
  end
end

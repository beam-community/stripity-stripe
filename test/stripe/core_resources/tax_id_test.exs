defmodule Stripe.TaxIDTest do
  use Stripe.StripeCase, async: true

  test "is listable" do
    assert {:ok, %Stripe.List{data: charges}} =
             Stripe.TaxID.list(%{customer: "cus_FDVoXj36NmFrao"})

    assert_stripe_requested(:get, "/v1/customers/cus_FDVoXj36NmFrao/tax_ids")
    assert is_list(charges)
    assert %Stripe.TaxID{} = hd(charges)
  end

  test "is retrievable" do
    assert {:ok, %Stripe.TaxID{}} =
             Stripe.TaxID.retrieve("txi_123456789", %{customer: "cus_FDVoXj36NmFrao"})

    assert_stripe_requested(:get, "/v1/customers/cus_FDVoXj36NmFrao/tax_ids/txi_123456789")
  end

  test "is creatable" do
    params = %{customer: "cus_FDVoXj36NmFrao", type: "eu_vat", value: "DE123456789"}
    assert {:ok, %Stripe.TaxID{}} = Stripe.TaxID.create(params)
    assert_stripe_requested(:post, "/v1/customers/cus_FDVoXj36NmFrao/tax_ids")
  end

  test "is deletable" do
    params = %{customer: "cus_FDVoXj36NmFrao"}
    assert {:ok, %Stripe.TaxID{}} = Stripe.TaxID.delete("txi_123456789", params)
    assert_stripe_requested(:delete, "/v1/customers/cus_FDVoXj36NmFrao/tax_ids/txi_123456789")
  end
end

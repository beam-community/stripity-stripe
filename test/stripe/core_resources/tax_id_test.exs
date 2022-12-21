defmodule Stripe.TaxIdTest do
  use Stripe.StripeCase, async: true

  test "is listable" do
    assert {:ok, %Stripe.List{data: charges}} =
             Stripe.TaxId.list(%{customer: "cus_FDVoXj36NmFrao"})

    assert_stripe_requested(:get, "/v1/customers/cus_FDVoXj36NmFrao/tax_ids")
    assert is_list(charges)
    assert %Stripe.TaxId{} = hd(charges)
  end

  test "is retrievable" do
    assert {:ok, %Stripe.TaxId{}} =
             Stripe.TaxId.retrieve("txi_123456789", %{customer: "cus_FDVoXj36NmFrao"})

    assert_stripe_requested(:get, "/v1/customers/cus_FDVoXj36NmFrao/tax_ids/txi_123456789")
  end

  test "is creatable" do
    params = %{type: "jp_cn", value: "DE123456789"}
    assert {:ok, %Stripe.TaxId{}} = Stripe.TaxId.create("cus_FDVoXj36NmFrao", params)
    assert_stripe_requested(:post, "/v1/customers/cus_FDVoXj36NmFrao/tax_ids")
  end

  test "is deletable" do
    assert {:ok, %Stripe.TaxId{}} = Stripe.TaxId.delete("cus_FDVoXj36NmFrao", "txi_123456789")
    assert_stripe_requested(:delete, "/v1/customers/cus_FDVoXj36NmFrao/tax_ids/txi_123456789")
  end
end

defmodule Stripe.Issuing.DisputeTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{
      disputed_transaction: "ipi_123",
      reason: :fraudulent
    }

    assert {:ok, %Stripe.Issuing.Dispute{}} = Stripe.Issuing.Dispute.create(params)

    assert_stripe_requested(:post, "/v1/issuing/disputes")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Issuing.Dispute{}} = Stripe.Issuing.Dispute.retrieve("idp_123")
    assert_stripe_requested(:get, "/v1/issuing/disputes/idp_123")
  end

  test "is updateable" do
    params = %{metadata: %{key: "value"}}
    assert {:ok, %Stripe.Issuing.Dispute{}} = Stripe.Issuing.Dispute.update("idp_123", params)
    assert_stripe_requested(:post, "/v1/issuing/disputes/idp_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: disputes}} = Stripe.Issuing.Dispute.list()
    assert_stripe_requested(:get, "/v1/issuing/disputes")
    assert is_list(disputes)
    assert %Stripe.Issuing.Dispute{} = hd(disputes)
  end
end

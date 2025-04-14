defmodule Stripe.Issuing.DisputeTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{
      transaction: "istr_123",
      evidence: %{
        reason: :fraudulent,
        fraudulent: %{
          explanation: "Purchase was not made by cardholder"
        }
      }
    }

    assert {:ok, %Stripe.Issuing.Dispute{}} = Stripe.Issuing.Dispute.create(params)
    assert_stripe_requested(:post, "/v1/issuing/disputes")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Issuing.Dispute{}} =
             Stripe.Issuing.Dispute.retrieve("idp_123")

    assert_stripe_requested(:get, "/v1/issuing/disputes/idp_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: disputes}} =
             Stripe.Issuing.Dispute.list()

    assert_stripe_requested(:get, "/v1/issuing/disputes")
    assert is_list(disputes)
    assert %Stripe.Issuing.Dispute{} = hd(disputes)
  end

  test "is listable with status filter" do
    params = %{
      status: :submitted
    }

    assert {:ok, %Stripe.List{data: disputes}} =
             Stripe.Issuing.Dispute.list(params)

    assert_stripe_requested(:get, "/v1/issuing/disputes", query: params)
    assert is_list(disputes)
    assert %Stripe.Issuing.Dispute{} = hd(disputes)
  end

  test "is updateable" do
    params = %{
      evidence: %{
        reason: :fraudulent,
        fraudulent: %{
          explanation: "Updated explanation"
        }
      }
    }

    assert {:ok, %Stripe.Issuing.Dispute{}} =
             Stripe.Issuing.Dispute.update("idp_123", params)

    assert_stripe_requested(:post, "/v1/issuing/disputes/idp_123")
  end

  test "is submittable" do
    assert {:ok, %Stripe.Issuing.Dispute{}} =
             Stripe.Issuing.Dispute.submit("idp_123")

    assert_stripe_requested(:post, "/v1/issuing/disputes/idp_123/submit")
  end
end

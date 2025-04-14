defmodule Stripe.Treasury.OutboundTransferTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{
      financial_account: "fa_123",
      destination_payment_method: "pm_123",
      amount: 10000,
      currency: "usd",
      description: "Outbound transfer for Treasury",
      statement_descriptor: "Treasury transfer"
    }

    assert {:ok, %Stripe.Treasury.OutboundTransfer{}} =
             Stripe.Treasury.OutboundTransfer.create(params)

    assert_stripe_requested(:post, "/v1/treasury/outbound_transfers")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Treasury.OutboundTransfer{}} =
             Stripe.Treasury.OutboundTransfer.retrieve("obt_123")

    assert_stripe_requested(:get, "/v1/treasury/outbound_transfers/obt_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: transfers}} =
             Stripe.Treasury.OutboundTransfer.list(%{financial_account: "fa_123"})

    assert_stripe_requested(:get, "/v1/treasury/outbound_transfers",
      query: %{financial_account: "fa_123"}
    )

    assert is_list(transfers)
    assert %Stripe.Treasury.OutboundTransfer{} = hd(transfers)
  end

  test "is cancelable" do
    assert {:ok, %Stripe.Treasury.OutboundTransfer{}} =
             Stripe.Treasury.OutboundTransfer.cancel("obt_123")

    assert_stripe_requested(:post, "/v1/treasury/outbound_transfers/obt_123/cancel")
  end

  test "test helpers: can be updated with tracking details" do
    params = %{
      tracking_details: %{
        type: "ach",
        ach: %{
          trace_id: "123456789"
        }
      }
    }

    assert {:ok, %Stripe.Treasury.OutboundTransfer{}} =
             Stripe.Treasury.OutboundTransfer.update("obt_123", params)

    assert_stripe_requested(:post, "/v1/test_helpers/treasury/outbound_transfers/obt_123")
  end

  test "test helpers: can be failed" do
    assert {:ok, %Stripe.Treasury.OutboundTransfer{}} =
             Stripe.Treasury.OutboundTransfer.fail("obt_123")

    assert_stripe_requested(:post, "/v1/test_helpers/treasury/outbound_transfers/obt_123/fail")
  end

  test "test helpers: can be posted" do
    assert {:ok, %Stripe.Treasury.OutboundTransfer{}} =
             Stripe.Treasury.OutboundTransfer.post("obt_123")

    assert_stripe_requested(:post, "/v1/test_helpers/treasury/outbound_transfers/obt_123/post")
  end

  test "test helpers: can be returned" do
    params = %{
      returned_details: %{
        code: :account_closed
      }
    }

    assert {:ok, %Stripe.Treasury.OutboundTransfer{}} =
             Stripe.Treasury.OutboundTransfer.return_outbound_transfer("obt_123", params)

    assert_stripe_requested(:post, "/v1/test_helpers/treasury/outbound_transfers/obt_123/return")
  end
end

defmodule Stripe.Treasury.InboundTransferTest do
  use Stripe.StripeCase, async: true

  test "is creatable" do
    params = %{
      financial_account: "fa_123",
      amount: 10000,
      currency: "usd",
      origin_payment_method: "pm_123",
      description: "Inbound transfer for Treasury",
      statement_descriptor: "Treasury transfer"
    }

    assert {:ok, %Stripe.Treasury.InboundTransfer{}} =
             Stripe.Treasury.InboundTransfer.create(params)

    assert_stripe_requested(:post, "/v1/treasury/inbound_transfers")
  end

  test "is retrievable" do
    assert {:ok, %Stripe.Treasury.InboundTransfer{}} =
             Stripe.Treasury.InboundTransfer.retrieve("ibt_123")

    assert_stripe_requested(:get, "/v1/treasury/inbound_transfers/ibt_123")
  end

  test "is listable" do
    assert {:ok, %Stripe.List{data: transfers}} =
             Stripe.Treasury.InboundTransfer.list(%{financial_account: "fa_123"})

    assert_stripe_requested(:get, "/v1/treasury/inbound_transfers",
      query: %{financial_account: "fa_123"}
    )

    assert is_list(transfers)
    assert %Stripe.Treasury.InboundTransfer{} = hd(transfers)
  end

  test "is cancelable" do
    assert {:ok, %Stripe.Treasury.InboundTransfer{}} =
             Stripe.Treasury.InboundTransfer.cancel("ibt_123")

    assert_stripe_requested(:post, "/v1/treasury/inbound_transfers/ibt_123/cancel")
  end

  test "test helpers: can be failed" do
    assert {:ok, %Stripe.Treasury.InboundTransfer{}} =
             Stripe.Treasury.InboundTransfer.fail("ibt_123", %{
               failure_details: %{
                 code: "insufficient_funds"
               }
             })

    assert_stripe_requested(:post, "/v1/test_helpers/treasury/inbound_transfers/ibt_123/fail")
  end

  test "test helpers: can be succeeded" do
    assert {:ok, %Stripe.Treasury.InboundTransfer{}} =
             Stripe.Treasury.InboundTransfer.succeed("ibt_123")

    assert_stripe_requested(:post, "/v1/test_helpers/treasury/inbound_transfers/ibt_123/succeed")
  end

  test "test helpers: can be returned" do
    assert {:ok, %Stripe.Treasury.InboundTransfer{}} =
             Stripe.Treasury.InboundTransfer.return_inbound_transfer("ibt_123")

    assert_stripe_requested(:post, "/v1/test_helpers/treasury/inbound_transfers/ibt_123/return")
  end
end

defmodule Stripe.CreditNoteLineItemTest do
  use Stripe.StripeCase, async: true

  describe "retrieve/2" do
    test "retrieves Credit Note Line Items" do
      credit_note_id = "cn_1EXwJk4Wq104wst7IISdh9ed"

      assert {:ok, %Stripe.List{data: [%Stripe.CreditNoteLineItem{} | _]}} =
               Stripe.CreditNoteLineItem.retrieve(credit_note_id)

      assert_stripe_requested(:get, "/v1/credit_notes/#{credit_note_id}/lines")
    end
  end
end

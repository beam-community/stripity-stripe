defmodule Stripe.CreditNoteTest do
  use Stripe.StripeCase, async: true
  doctest Stripe.CreditNote

  describe "create/2" do
    test "creates a Credit Note for a customer" do
      params = %{
        invoice: "in_173uNd4Wq104wst7Gf4dgq1Y",
        amount: 500
      }

      assert {:ok, %Stripe.CreditNote{}} = Stripe.CreditNote.create(params)
      assert_stripe_requested(:post, "/v1/credit_notes")
    end
  end

  describe "retrieve/2" do
    test "retrieves a Credit Note" do
      assert {:ok, %Stripe.CreditNote{}} =
               Stripe.CreditNote.retrieve("cn_1EXwJk4Wq104wst7IISdh9ed")

      assert_stripe_requested(:get, "/v1/credit_notes/cn_1EXwJk4Wq104wst7IISdh9ed")
    end
  end

  describe "update/2" do
    test "updates a Credit Note" do
      params = %{metadata: %{foo: "bar"}}
      assert {:ok, credit_note} = Stripe.CreditNote.update("cn_1EXwJk4Wq104wst7IISdh9ed", params)
      assert_stripe_requested(:post, "/v1/credit_notes/#{credit_note.id}")
    end
  end

  describe "void/2" do
    test "voids a CreditNote" do
      {:ok, credit_note} = Stripe.CreditNote.retrieve("cn_1EXwJk4Wq104wst7IISdh9ed")
      assert_stripe_requested(:get, "/v1/credit_notes/#{credit_note.id}")

      assert {:ok, %Stripe.CreditNote{}} = Stripe.CreditNote.void(credit_note)
      assert_stripe_requested(:post, "/v1/credit_notes/#{credit_note.id}/void")
    end
  end

  describe "list/2" do
    test "lists all Credit Notes" do
      assert {:ok, %Stripe.List{data: credit_notes}} = Stripe.CreditNote.list()
      assert_stripe_requested(:get, "/v1/credit_notes")
      assert is_list(credit_notes)
      assert %Stripe.CreditNote{} = hd(credit_notes)
    end
  end
end

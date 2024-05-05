defmodule Stripe.FileTest do
  use Stripe.StripeCase, async: true

  describe "create/2" do
    test "creates a file" do
      assert {:ok, %Stripe.File{}} =
               Stripe.File.create(%{
                 file: Path.join(__DIR__, "../../fixtures/upload.txt"),
                 purpose: "dispute_evidence"
               })

      assert_stripe_requested(:post, "/v1/files")
    end
  end

  describe "retrieve/2" do
    test "retrieves an file" do
      assert {:ok, _} = Stripe.File.retrieve("file_19yVPO2eZvKYlo2CIrGjfyCO")
      assert_stripe_requested(:get, "/v1/files/file_19yVPO2eZvKYlo2CIrGjfyCO")
    end
  end

  describe "list/2" do
    test "lists all files" do
      assert {:ok, _} = Stripe.File.list()
      assert_stripe_requested(:get, "/v1/files")
    end
  end
end

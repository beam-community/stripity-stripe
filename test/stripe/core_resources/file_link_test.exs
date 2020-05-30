defmodule Stripe.FileLinkTest do
  use Stripe.StripeCase, async: true

  describe "create/2" do
    test "creates a file with FileUpload ID" do
      assert {:ok, %Stripe.FileLink{}} = Stripe.FileLink.create(%{file: "file_123"})
      assert_stripe_requested(:post, "/v1/file_links")
    end

    test "creates a file with FileUpload struct" do
      file_upload = %Stripe.FileUpload{id: "file_123"}

      assert {:ok, %Stripe.FileLink{}} = Stripe.FileLink.create(%{file: file_upload})
      assert_stripe_requested(:post, "/v1/file_links")
    end
  end

  describe "retrieve/2" do
    test "retrieves a file link by ID" do
      assert {:ok, %Stripe.FileLink{}} = Stripe.FileLink.retrieve("filelink_123")
      assert_stripe_requested(:get, "/v1/file_links/filelink_123")
    end

    test "retrieves a file link by FileLink struct" do
      file_link = %Stripe.FileLink{id: "filelink_123"}

      assert {:ok, %Stripe.FileLink{}} = Stripe.FileLink.retrieve(file_link)
      assert_stripe_requested(:get, "/v1/file_links/filelink_123")
    end
  end

  describe "update/3" do
    test "updates file_link" do
      assert {:ok, %Stripe.FileLink{}} =
               Stripe.FileLink.update("filelink_123", %{metadata: %{foo: "bar"}})

      assert_stripe_requested(:post, "/v1/file_links/filelink_123")
    end
  end

  describe "list/2" do
    test "lists all files" do
      assert {:ok, %Stripe.List{data: [%Stripe.FileLink{} | _]}} = Stripe.FileLink.list()
      assert_stripe_requested(:get, "/v1/file_links")
    end
  end
end

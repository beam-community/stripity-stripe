defmodule Stripe.UtilTest do
  use ExUnit.Case

  import Stripe.Util

  describe "object_name_to_module/1" do
  	test "converts all object names to their proper modules" do
      assert object_name_to_module("account") == Stripe.Account
      assert object_name_to_module("bank_account") == Stripe.ExternalAccount
      assert object_name_to_module("card") == Stripe.Card
      assert object_name_to_module("customer") == Stripe.Customer
      assert object_name_to_module("event") == Stripe.Event
      assert object_name_to_module("external_account") == Stripe.ExternalAccount
      assert object_name_to_module("file_upload") == Stripe.FileUpload
      assert object_name_to_module("invoice") == Stripe.Invoice
      assert object_name_to_module("list") == Stripe.List
      assert object_name_to_module("plan") == Stripe.Plan
      assert object_name_to_module("refund") == Stripe.Refund
      assert object_name_to_module("subscription") == Stripe.Subscription
      assert object_name_to_module("token") == Stripe.Token
    end
  end
end

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
      assert object_name_to_module("subscription") == Stripe.Subscription
      assert object_name_to_module("token") == Stripe.Token
    end
  end

  describe "put_if_non_nil_opt/3" do
    test "Puts if non nil" do
      map = %{}
      opt = :opt
      opts = [opt: :non_nil]

      result = put_if_non_nil_opt(map, opt, opts)
      assert :opt in Map.keys(result)
    end

    test "Puts if false" do
      map = %{}
      opt = :opt
      opts = [opt: false]

      result = put_if_non_nil_opt(map, opt, opts)
      assert :opt in Map.keys(result)
    end

    test "Does not put if absent" do
      map = %{}
      opt = :opt
      opts = []

      result = put_if_non_nil_opt(map, opt, opts)
      assert not :opt in Map.keys(result)
    end

    test "Does not put if nil" do
      map = %{}
      opt = :opt
      opts = [opt: nil]

      result = put_if_non_nil_opt(map, opt, opts)
      assert not :opt in Map.keys(result)
    end
  end
end

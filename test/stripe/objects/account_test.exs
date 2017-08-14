defmodule Stripe.AccountTest do
  use Stripe.StripeCase, async: true

  test "is listable" do
    assert {:ok, %Stripe.List{data: accounts}} = Stripe.Account.list()
    assert_stripe_requested :get, "/v1/accounts"
    assert is_list(accounts)
    assert %Stripe.Account{} = hd(accounts)
  end

  test "is retrievable using singular endpoint" do
    assert {:ok, %Stripe.Account{}} = Stripe.Account.retrieve()
    assert_stripe_requested :get, "/v1/account"
  end

  test "is retrievable using plural endpoint" do
    assert {:ok, %Stripe.Account{}} = Stripe.Account.retrieve("acct_123")
    assert_stripe_requested :get, "/v1/accounts/acct_123"
  end

  test "is rejectable" do
    {:ok, account} = Stripe.Account.create(%{metadata: %{}, type: "standard"})
    assert {:ok, %Stripe.Account{} = raccount} = Stripe.Account.reject(account)
    assert_stripe_requested :post, "/v1/accounts/#{account.id}/reject"
    assert account.id == raccount.id
    refute raccount.transfers_enabled
    refute raccount.charges_enabled
  end

  test "is creatable" do
    assert {:ok, %Stripe.Account{}} = Stripe.Account.create(%{metadata: %{}, type: "standard"})
    assert_stripe_requested :post, "/v1/accounts"
  end

  @tag :disabled
  test "is saveable" do
    {:ok, account} = Stripe.Account.retrieve("acct_123")
    account = put_in(account.metadata["key"], "value")
    assert {:ok, %Stripe.Account{} = saccount} = Stripe.Account.save(account)
    assert saccount.id == account.id
    assert_stripe_requested :post, "/v1/accounts/#{account.id}"
  end

  test "is updateable" do
    assert {:ok, %Stripe.Account{id: id}} = Stripe.Account.update("acct_123", %{metadata: %{foo: "bar"}})
    assert_stripe_requested :post, "/v1/accounts/#{id}"
  end

  test "is deletable" do
    assert {:ok, %Stripe.Account{}} = Stripe.Account.delete("acct_123")
    assert_stripe_requested :delete, "/v1/accounts/acct_123"
  end

  test "can be deauthorized" do
    flunk "Connect calls not tested"
  end

  test "serialization of params (additional owners)" do
    flunk "todo: check if this is applicable"
  end
end

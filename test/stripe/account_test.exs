defmodule Stripe.AccountTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    new_account = [
      email: "test@example.com",
      managed: true,
      legal_entity: [
        type: "individual"
      ]
    ]

    { :ok, account } =
      use_cassette "Stripe.AccountTest/create" do
        Stripe.Accounts.create(new_account)
      end

    { :ok, %{ account: account } }
  end

  @tag disabled: false
  test "Creating an account", %{account: account} do
    assert account.id
  end

  @tag disabled: false
  test "Retrieving a list of accounts" do
    { :ok, accounts } =
      use_cassette "Stripe.AccountTest/list" do
        Stripe.Accounts.list
      end

    assert length(accounts) == 2
  end

  @tag disabled: false
  test "Retrieving an account", %{account: account} do
    { :ok, found_account } =
      use_cassette "Stripe.AccountTest/get" do
        Stripe.Accounts.get(account.id)
      end

    assert found_account.id == account.id
  end

  @tag disabled: false
  test "Deleting an account", %{account: account} do
    { :ok, deleted_account } =
      use_cassette "Stripe.AccountTest/delete" do
        Stripe.Accounts.delete(account.id)
      end

    assert deleted_account.id == account.id
    assert deleted_account.deleted
  end

  @tag disabled: false
  test "Deleting all accounts" do
    use_cassette "Stripe.AccountTest/delete_all" do
      Stripe.Accounts.delete_all
    end

    assert { :ok, 0 } == Stripe.Accounts.count
  end
end

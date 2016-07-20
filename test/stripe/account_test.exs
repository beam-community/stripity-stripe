defmodule Stripe.AccountTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    use_cassette "Stripe.AccountTest/setup", match_requests_on: [:query, :request_body] do
      Stripe.Accounts.delete_all

      new_account = [
        email: "test@example.com",
        managed: true
      ]
      case Stripe.Accounts.create new_account do
        {:ok, account} ->
        on_exit fn ->
          use_cassette "Stripe.AccountTest/teardown", match_requests_on: [:query, :request_body] do
            Stripe.Accounts.delete account.id
          end
        end
        {:ok, [account: account]}

        {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "Create works", %{account: account} do
    assert account.id
  end

  @tag disabled: false
  test "Retrieve list works" do
    use_cassette "Stripe.AccountTest/list", match_requests_on: [:query, :request_body] do
      {:ok, accounts} = Stripe.Accounts.list
      assert length(accounts) > 0
    end
  end

  @tag disabled: false
  test "Retrieve single works", %{account: account} do
    use_cassette "Stripe.AccountTest/get", match_requests_on: [:query, :request_body] do
      case Stripe.Accounts.get account.id do
        {:ok, found} -> assert found.id == account.id
        {:error, err} -> flunk err
      end
    end
  end

  test "Delete single works", %{account: account} do
    use_cassette "Stripe.AccountTest/delete", match_requests_on: [:query, :request_body] do
      case Stripe.Accounts.delete account.id do
        {:ok, res} -> assert res.deleted
        {:error, err} -> flunk err
      end
    end
  end

  test "Delete all works", %{account: _} do
    use_cassette "Stripe.AccountTest/delete_all", match_requests_on: [:query, :request_body] do
      Helper.create_test_account "test1@example.com"
      Helper.create_test_account "test2@example.com"
      Stripe.Accounts.delete_all

      case Stripe.Accounts.count do
        {:ok, cnt} -> assert cnt == 0
        {:error, err} -> flunk err
      end
    end
  end
end

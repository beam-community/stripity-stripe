defmodule Stripe.AccountTest do
  use ExUnit.Case

  setup_all do
    Stripe.Accounts.delete_all

    new_account = [
      email: "test@example.com",
      managed: true,
      tos_acceptance: [
        date: :os.system_time(:seconds),
        ip: "127.0.0.1"
      ],
      legal_entity: [
        type: "individual",
        address: [
          city: "Los Angeles",
          country: "US",
          line1: "1st Ave",
          postal_code: "90001",
          state: "CA"
        ],
        dob: [
          day: 1,
          month: 1,
          year: 1991
        ],
        first_name: "John",
        last_name: "Doe"
      ],
      external_account: [
        object: "bank_account",
        country: "US",
        currency: "usd",
        routing_number: "110000000",
        account_number: "000123456789"
      ]
    ]
    case Stripe.Accounts.create new_account do
      {:ok, account} ->
        on_exit fn ->
          Stripe.Accounts.delete account.id
        end
        {:ok, [account: account]}

      {:error, err} -> inspect(err) |> flunk
    end
  end

  @tag disabled: false
  test "Create works", %{account: account} do
    assert account.id
  end

  @tag disabled: false
  test "Retrieve list works" do
    {:ok, accounts} = Stripe.Accounts.list
    assert length(accounts) > 0
  end

  @tag disabled: false
  test "Retrieve single works", %{account: account} do
    case Stripe.Accounts.get account.id do
      {:ok, found} -> assert found.id == account.id
      {:error, err} -> flunk err
    end
  end

  test "Delete single works", %{account: account} do
    case Stripe.Accounts.delete account.id do
      {:ok, res} -> assert res.deleted
      {:error, err} -> flunk err
    end
  end

  test "Delete all works", %{account: _} do
   Helper.create_test_account "test1@example.com"
   Helper.create_test_account "test2@example.com"
   Stripe.Accounts.delete_all

    case Stripe.Accounts.count do
      {:ok, cnt} -> assert cnt == 0
      {:error, err} -> flunk err
    end
  end
end

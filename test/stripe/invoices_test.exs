defmodule Stripe.InvoicesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  require Helper

  setup_all do
    use_cassette "Stripe.InvoicesTest/setup", match_requests_on: [:query, :request_body] do
      Helper.create_test_plans
      customer1 = Helper.create_test_customer "invoices_test1@localhost"
      {:ok, sub1} = Stripe.Subscriptions.create customer1.id, [plan: "test-std"]

      params = [
        customer: customer1.id,
        amount: 10,
        currency: "usd",
        subscription: sub1.id
      ]
      {:ok, _ } = Stripe.InvoiceItems.create params
      on_exit fn ->
        use_cassette "Stripe.InvoicesTest/teardown", match_requests_on: [:query, :request_body] do
          Stripe.Subscriptions.cancel customer1.id, sub1.id
          Stripe.Customers.delete customer1.id
          Helper.delete_test_plans
        end
      end
      {:ok, [customer1: customer1, sub1: sub1]}
    end
  end

  @tag disabled: false
  test "Metadata works", %{customer1: customer1, sub1: sub1}  do
    use_cassette "Stripe.InvoicesTest/metadata", match_requests_on: [:query, :request_body] do
      params = [
        subscription: sub1.id,
        metadata: [
          app_order_id: "ABC123",
          app_attr1: "xyz"
        ]
      ]
      case Stripe.Invoices.create customer1.id, params do
        {:ok, invoice} ->
          assert invoice[:customer] == customer1.id
          assert invoice.metadata["app_order_id"] == "ABC123"
          assert invoice.metadata["app_attr1"] == "xyz"
          {:error, err} -> flunk err
      end
    end
  end


  @tag disabled: false
  test "Count works", %{}  do
    use_cassette "Stripe.InvoicesTest/count", match_requests_on: [:query, :request_body] do
      case Stripe.Invoices.count do
        {:ok, cnt} -> assert cnt > 0
        {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "Count w/key works", %{}  do
    use_cassette "Stripe.InvoicesTest/count_with_key", match_requests_on: [:query, :request_body] do
      case Stripe.Invoices.count Stripe.config_or_env_key do
        {:ok, cnt} -> assert cnt > 0
        {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "List works", %{}  do
    use_cassette "Stripe.InvoicesTest/list", match_requests_on: [:query, :request_body] do
      case Stripe.Invoices.list "",1 do
        {:ok, res} ->
          assert Dict.size(res[:data]) == 1
          {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "List w/key works", %{}  do
    use_cassette "Stripe.InvoicesTest/list_with_key", match_requests_on: [:query, :request_body] do
      case Stripe.Invoices.list Stripe.config_or_env_key, "", 1 do
        {:ok, lst} -> assert Dict.size(lst[:data]) == 1
        {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "List w/paging works" do
    use_cassette "Stripe.InvoicesTest/list_with_key_and_paging" do
      {:ok,invoices} = Stripe.Invoices.list Stripe.config_or_env_key,"", 1
      case invoices[:has_more] do
        true ->
          last = List.last( invoices[:data] )
          case Stripe.Invoices.list Stripe.config_or_env_key,last["id"], 1 do
            {:ok, invoices} -> assert Dict.size(invoices[:data]) > 0
            {:error,err} -> flunk err
          end
          _ -> flunk "should have had more than 1 page. Check setup to make sure theres enough invoices for the test to run properly (5+)"
      end
    end
  end

  test "Get works", %{customer1: _, sub1: _} do
    use_cassette "Stripe.InvoicesTest/get", match_requests_on: [:query, :request_body] do
      {:ok,invoices} = Stripe.Invoices.list Stripe.config_or_env_key,"", 1
      first = Enum.at invoices[:data], 0
      case Stripe.Invoices.get first["id"] do
        {:ok, invoice} -> assert invoice.id == first["id"]
        err -> flunk err
      end
    end
  end

  test "Get w/key works", %{customer1: _, sub1: _} do
    use_cassette "Stripe.InvoicesTest/get_with_key", match_requests_on: [:query, :request_body] do
      {:ok,invoices} = Stripe.Invoices.list Stripe.config_or_env_key,"", 1
      first = Enum.at invoices[:data], 0
      case Stripe.Invoices.get first["id"], Stripe.config_or_env_key do
        {:ok, invoice} ->
          assert invoice.id == first["id"]
          err -> flunk err
      end
    end
  end

  @tag disabled: false
  test "Upcoming works", %{customer1: customer1, sub1: sub1} do
    use_cassette "Stripe.InvoicesTest/upcoming", match_requests_on: [:query, :request_body] do
      {:ok, upcoming_invoice} = Stripe.Invoices.upcoming customer1.id, [subscription: sub1.id]
      assert upcoming_invoice[:object] == "invoice"
      assert upcoming_invoice[:customer] == customer1.id
      assert upcoming_invoice[:subscription] == sub1.id
    end
  end

  @tag disabled: false
  test "Upcoming w/key works", %{customer1: customer1} do
    use_cassette "Stripe.InvoicesTest/upcoming_with_key", match_requests_on: [:query, :request_body] do
      {:ok, upcoming_invoice} = Stripe.Invoices.upcoming customer1.id, nil, Stripe.config_or_env_key
      assert upcoming_invoice[:object] == "invoice"
      assert upcoming_invoice[:customer] == customer1.id
    end
  end
end

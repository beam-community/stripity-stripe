defmodule Stripe.CardTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    use_cassette "card_test/setup", match_requests_on: [:query, :request_body] do
      Stripe.Customers.delete_all
      customer = Helper.create_test_customer "customer_test1@localhost"

      on_exit fn ->
        use_cassette "card_test/teardown1", match_requests_on: [:query, :request_body] do
          Stripe.Customers.delete customer.id
        end
      end

      new_card = [
        source: [
          object: "card",
          number: "4111111111111111",
          cvc: 123,
          exp_month: 12,
          exp_year: 2020,
          metadata: [
            test_field: "test val"
          ]
        ]
      ]
      new_card2 = [
        source: [
          object: "card",
          number: "4242424242424242",
          cvc: 123,
          exp_month: 12,
          exp_year: 2020,
          metadata: [
            test_field: "test val"
          ]
        ]
      ]
      case Stripe.Cards.create :customer, customer.id, new_card2 do
        {:ok, card2} ->
          case Stripe.Cards.create :customer, customer.id, new_card do
            {:ok, card} ->
            on_exit fn ->
              use_cassette "card_test/teardown2", match_requests_on: [:query, :request_body] do
                Stripe.Cards.delete :customer, customer.id, card.id
              end
            end
            {:ok, [customer: customer, card: card, card2: card2]}
            {:error, err} -> flunk err
          end
          {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "Metadata works", %{customer: _, card: card, card2: _}  do
    assert card.metadata["test_field"] == "test val"
  end

  @tag disabled: false
  test "Count works", %{customer: customer, card: _, card2: _}  do
    use_cassette "card_test/count", match_requests_on: [:query, :request_body] do
      case Stripe.Cards.count :customer, customer.id do
        {:ok, cnt} -> assert cnt == 3
        {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "Count w/key works", %{customer: customer, card: _, card2: _}  do
    use_cassette "card_test/count_with_key", match_requests_on: [:query, :request_body] do
      case Stripe.Cards.count :customer, customer.id, Stripe.config_or_env_key do
        {:ok, cnt} -> assert cnt == 3
        {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "List works", %{customer: customer, card: _, card2: _}  do
    use_cassette "card_test/list", match_requests_on: [:query, :request_body] do
      case Stripe.Cards.list :customer, customer.id, "", 1 do
        {:ok, res} ->
          assert Dict.size(res[:data]) == 1
          {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "List w/key works", %{customer: customer, card: _, card2: _}  do
    use_cassette "card_test/list_with_key", match_requests_on: [:query, :request_body] do
      case Stripe.Cards.list :customer, customer.id, Stripe.config_or_env_key,"", 1 do
        {:ok, res} ->
          assert Dict.size(res[:data]) == 1
          {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "Retrieve all works", %{customer: customer, card: _, card2: _} do
    use_cassette "card_test/all", match_requests_on: [:query, :request_body] do
      case Stripe.Cards.all :customer, customer.id, [],"" do
        {:ok, cards} ->
          assert Dict.size(cards) > 0
          {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "Retrieve w/key all works", %{customer: customer, card: _, card2: _} do
    use_cassette "card_test/all_with_key", match_requests_on: [:query, :request_body] do
      case Stripe.Cards.all :customer, customer.id, Stripe.config_or_env_key, [], "" do
        {:ok, cards} ->
          assert Dict.size(cards) > 0
          {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "Create works", %{customer: _, card: card, card2: _} do
    assert card.id
  end

  @tag disabled: false
  test "Create w/opts  works", %{customer: customer} do
    use_cassette "card_test/create_with_options", match_requests_on: [:query, :request_body] do
      token = Helper.create_test_token
      opts = [
        source: token.id
      ]
      case Stripe.Cards.create :customer, customer.id, opts do
        {:ok, card}   ->
          assert card.customer == customer.id
          assert card.id
          {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "Create w/opts w/key works", %{customer: customer} do
    use_cassette "card_test/create_with_options_with_key", match_requests_on: [:query, :request_body] do
      token = Helper.create_test_token
      opts = [
        source: token.id
      ]
      case Stripe.Cards.create :customer, customer.id, opts, Stripe.config_or_env_key do
        {:ok, card}   ->
          assert card.customer == customer.id
          assert card.id
          {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "Retrieve single works", %{customer: customer, card: card, card2: _} do
    use_cassette "card_test/get", match_requests_on: [:query, :request_body] do
      case Stripe.Cards.get :customer, customer.id, card.id do
        {:ok, found} -> assert found.id == card.id
        {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false

  test "Delete works", %{customer: customer, card: card, card2: _} do
    use_cassette "card_test/delete", match_requests_on: [:query, :request_body] do
      case Stripe.Cards.delete :customer, customer.id, card.id do
        {:ok, res} -> assert res.deleted
        {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "Delete w/key works", %{customer: customer, card: _, card2: card2} do
    use_cassette "card_test/delete_with_key", match_requests_on: [:query, :request_body] do
      case Stripe.Cards.delete :customer, customer.id, card2.id, Stripe.config_or_env_key do
        {:ok, res} -> assert res.deleted
        {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "Delete all works", %{customer: customer, card: _, card2: _} do
    use_cassette "card_test/delete_all", match_requests_on: [:query, :request_body] do
      Stripe.Cards.delete_all :customer, customer.id

      case Stripe.Cards.count :customer, customer.id do
        {:ok, cnt} -> assert cnt == 0
        {:error, err} -> flunk err
      end
    end
  end

  @tag disabled: false
  test "Delete all w/key works", %{customer: customer, card: _, card2: _} do
    use_cassette "card_test/delete_all_with_key", match_requests_on: [:query, :request_body] do
      Stripe.Cards.delete_all :customer, customer.id, Stripe.config_or_env_key

      case Stripe.Cards.count :customer, customer.id do
        {:ok, cnt} -> assert cnt == 0
        {:error, err} -> flunk err
      end
    end
  end
end

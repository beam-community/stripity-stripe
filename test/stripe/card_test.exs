defmodule Stripe.CardTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    customer =
      use_cassette "Shared/create_customer" do
        Helper.create_test_customer "customer_test1@localhost"
      end

    new_card1 = [
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

    [ { :ok, card1 }, { :ok, card2 } ] =
      use_cassette "Stripe.CardTest/create_test_cards" do
        [
          Stripe.Cards.create(:customer, customer.id, new_card1),
          Stripe.Cards.create(:customer, customer.id, new_card2)
        ]
      end

    { :ok, %{ customer: customer, card: card1, card2: card2 } }
  end

  @tag disabled: false
  test "Metadata works", %{customer: _, card: card, card2: _}  do
    assert card.metadata["test_field"] == "test val"
  end

  @tag disabled: false
  test "Count works", %{customer: customer}  do
    use_cassette "Stripe.CardTest/count_works" do
      assert { :ok, 2 } == Stripe.Cards.count(:customer, customer.id)
    end
  end

  @tag disabled: false
  test "Count w/key works", %{customer: customer}  do
    use_cassette "Stripe.CardTest/count_works_with_key" do
      assert { :ok, 2 } == Stripe.Cards.count(:customer, customer.id, Stripe.config_or_env_key)
    end
  end

  @tag disabled: false
  test "List works", %{customer: customer}  do
    use_cassette "Stripe.CardTest/list_works" do
      { :ok, resp } = Stripe.Cards.list(:customer, customer.id, "", 1)
      assert length(resp[:data]) == 1
    end
  end

  @tag disabled: false
  test "List w/key works", %{customer: customer}  do
    use_cassette "Stripe.CardTest/list_works_with_key" do
      { :ok, resp } = Stripe.Cards.list(:customer, customer.id, Stripe.config_or_env_key, "", 1)
      assert length(resp[:data]) == 1
    end
  end

  @tag disabled: false
  test "Retrieve all works", %{customer: customer} do
    use_cassette "Stripe.CardTest/retrieve_all" do
      { :ok, cards } = Stripe.Cards.all(:customer, customer.id, [], "")
      assert length(cards) == 2
    end
  end

  @tag disabled: false
  test "Retrieve w/key all works", %{customer: customer, card: _, card2: _} do
    use_cassette "Stripe.CardTest/retrieve_all_with_key" do
      { :ok, cards } = Stripe.Cards.all(:customer, customer.id, Stripe.config_or_env_key, [], "")
      assert length(cards) == 2
    end
  end

  @tag disabled: false
  test "Create works", %{card: card} do
    assert card.id
  end

  @tag disabled: false
  test "Create w/opts works", %{customer: customer} do
    use_cassette "Stripe.CardTest/create_with_opts" do
      token = Helper.create_test_token
      { :ok, card } = Stripe.Cards.create(:customer, customer.id, [source: token.id])

      assert card.customer == customer.id
      assert card.id
    end
  end

  @tag disabled: false
  test "Create w/opts w/key works", %{customer: customer} do
    use_cassette "Stripe.CardTest/create_with_opts_with_key" do
      token = Helper.create_test_token
      { :ok, card } = Stripe.Cards.create(:customer, customer.id, [source: token.id], Stripe.config_or_env_key)

      assert card.customer == customer.id
      assert card.id
    end
  end

  @tag disabled: false
  test "Retrieve single works", %{customer: customer, card: card} do
    use_cassette "Stripe.CardTest/retrieve_single" do
      { :ok, found } = Stripe.Cards.get(:customer, customer.id, card.id)
      assert found.id == card.id
    end
  end

  @tag disabled: false
  test "Delete works", %{customer: customer, card: card} do
    use_cassette "Stripe.CardTest/delete" do
      { :ok, res } = Stripe.Cards.delete(:customer, customer.id, card.id)
      assert res.deleted
    end
  end

  @tag disabled: false
  test "Delete w/key works", %{customer: customer, card2: card2} do
    use_cassette "Stripe.CardTest/delete_with_key" do
      { :ok, res } = Stripe.Cards.delete(:customer, customer.id, card2.id, Stripe.config_or_env_key)
      assert res.deleted
    end
  end

  @tag disabled: false
  test "Delete all works", %{customer: customer} do
    use_cassette "Stripe.CardTest/delete_all" do
      Stripe.Cards.delete_all(:customer, customer.id)
    end

    use_cassette "Stripe.CardTest/delete_all_and_count" do
      { :ok, cnt } = Stripe.Cards.count(:customer, customer.id)
      assert cnt == 0
    end
  end

  @tag disabled: false
  test "Delete all w/key works", %{customer: customer} do
    use_cassette "Stripe.CardTest/delete_all_with_key" do
      Stripe.Cards.delete_all(:customer, customer.id, Stripe.config_or_env_key)
    end

    use_cassette "Stripe.CardTest/delete_all_with_key_and_count" do
      { :ok, cnt } = Stripe.Cards.count(:customer, customer.id)
      assert cnt == 0
    end
  end
end

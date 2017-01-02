defmodule Stripe.ChangesetTest do
  use ExUnit.Case

  alias Stripe.Changeset

  @json_params %{
    "email" => nil,
    "external_account" => "btok_123",
    "legal_entity" => %{
      "ssn_last_4" => "1234",
      "ssn_last_4_provided" => true
    }
  }

  @map_params %{
    email: nil,
    external_account: "btok_123",
    legal_entity: %{
      ssn_last_4: "1234",
      ssn_last_4_provided: true
    }
  }

  @schema %{
    email: [:create, :retrieve, :update],
    external_account: [:create, :retrieve, :update],
    legal_entity: %{
      ssn_last_4: [:create, :update]
    },
    managed: [:create, :retrieve]
  }

  @expected_map %{
    external_account: "btok_123",
    legal_entity: %{
      ssn_last_4: "1234"
    }
  }

  test "works for JSON" do
    result = Changeset.cast(@json_params, @schema, :create)
    assert result == @expected_map
  end

  test "works for maps" do
    result = Changeset.cast(@map_params, @schema, :create)
    assert result == @expected_map
  end

  test "works with nullable keys" do
    nullable_keys = [:email]
    result = Changeset.cast(@map_params, @schema, :create, nullable_keys)
    expected_map = @expected_map |> Map.merge(%{email: nil})
    assert result == expected_map
  end

  test "removes attributes that are not expected for the operation" do
    map_params = @map_params |> Map.merge(%{managed: true})
    result = Changeset.cast(map_params, @schema, :update)
    assert result == @expected_map
  end
end

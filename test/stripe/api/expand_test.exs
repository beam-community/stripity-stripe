defmodule Stripe.API.ExpandTest do
  use Stripe.StripeCase

  alias Stripe.API.Expand

  setup {Req.Test, :verify_on_exit!}

  setup do
    parent = self()

    Req.Test.expect(__MODULE__, fn conn ->
      send(parent, {:query_params, conn.query_params})

      Req.Test.json(conn, %{})
    end)

    {:ok, client: Req.new(plug: {Req.Test, __MODULE__}, url: "https://api.stripe.test/v1/products")}
  end

  test "adds the expansions to the query params", %{client: client} do
    assert {:ok, %Req.Response{}} =
             client |> Expand.attach() |> Req.request(expand: ["balance_transaction", "customer"])

    assert_received {:query_params, %{"expand" => %{"0" => "balance_transaction", "1" => "customer"}}}
  end

  test "keeps the existing params", %{client: client} do
    assert {:ok, %Req.Response{}} =
             client
             |> Expand.attach()
             |> Req.request(params: [limit: 3], expand: ["data.customer"])

    assert_received {:query_params, %{"limit" => "3", "expand" => %{"0" => "data.customer"}}}
  end

  test "accepts params given as a map", %{client: client} do
    assert {:ok, %Req.Response{}} =
             client
             |> Expand.attach()
             |> Req.request(params: %{limit: 3}, expand: ["data.customer"])

    assert_received {:query_params, %{"limit" => "3", "expand" => %{"0" => "data.customer"}}}
  end

  test "does not add expansions when the option is missing", %{client: client} do
    assert {:ok, %Req.Response{}} = client |> Expand.attach() |> Req.request(params: [limit: 3])

    assert_received {:query_params, %{"limit" => "3"} = params}
    refute Map.has_key?(params, "expand")
  end

  test "does not touch the query params when not attached", %{client: client} do
    assert {:ok, %Req.Response{}} = Req.request(client, params: [limit: 3])

    assert_received {:query_params, %{"limit" => "3"} = params}
    refute Map.has_key?(params, "expand")
  end
end

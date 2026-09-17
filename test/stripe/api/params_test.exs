defmodule Stripe.API.ParamsTest do
  use Stripe.StripeCase

  alias Stripe.API.Params

  setup {Req.Test, :verify_on_exit!}

  setup do
    parent = self()

    Req.Test.stub(__MODULE__, fn conn ->
      send(parent, {:request, conn.query_params, conn.body_params})

      Req.Test.json(conn, %{})
    end)

    {:ok, client: Req.new(plug: {Req.Test, __MODULE__}, url: "https://api.stripe.test/v1/products")}
  end

  test "flattens nested params into the query string", %{client: client} do
    assert {:ok, %Req.Response{}} =
             client
             |> Params.attach()
             |> Req.request(params: %{limit: 3, metadata: %{key: "value"}})

    assert_received {:request, %{"limit" => "3", "metadata" => %{"key" => "value"}}, %{}}
  end

  test "flattens nested form bodies", %{client: client} do
    assert {:ok, %Req.Response{}} =
             client
             |> Params.attach()
             |> Req.request(method: :post, form: %{metadata: %{key: "value"}})

    assert_received {:request, %{}, %{"metadata" => %{"key" => "value"}}}
  end

  test "indexes list values", %{client: client} do
    assert {:ok, %Req.Response{}} =
             client
             |> Params.attach()
             |> Req.request(method: :post, form: %{expand: ["customer", "data.customer"]})

    assert_received {:request, %{}, %{"expand" => %{"0" => "customer", "1" => "data.customer"}}}
  end

  test "accepts params and form given as keyword lists", %{client: client} do
    assert {:ok, %Req.Response{}} =
             client
             |> Params.attach()
             |> Req.request(method: :post, params: [limit: 3], form: [metadata: [key: "value"]])

    assert_received {:request, %{"limit" => "3"}, %{"metadata" => %{"key" => "value"}}}
  end

  test "leaves flat values untouched", %{client: client} do
    assert {:ok, %Req.Response{}} =
             client
             |> Params.attach()
             |> Req.request(method: :post, params: %{limit: 3}, form: %{name: "Widget"})

    assert_received {:request, %{"limit" => "3"}, %{"name" => "Widget"}}
  end

  test "sends nothing when neither option is given", %{client: client} do
    assert {:ok, %Req.Response{}} = client |> Params.attach() |> Req.request(method: :post)

    assert_received {:request, params, body} when params == %{} and body == %{}
  end

  test "nested values are not encodable when not attached", %{client: client} do
    assert_raise Protocol.UndefinedError, fn ->
      Req.request(client, method: :post, form: %{metadata: %{key: "value"}})
    end
  end
end

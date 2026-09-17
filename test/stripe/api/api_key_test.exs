defmodule Stripe.API.APIKeyTest do
  use Stripe.StripeCase

  alias Stripe.API.APIKey

  setup {Req.Test, :verify_on_exit!}

  setup do
    api_key = Application.get_env(:stripity_stripe, :api_key)
    on_exit(fn -> Application.put_env(:stripity_stripe, :api_key, api_key) end)

    parent = self()

    Req.Test.expect(__MODULE__, fn conn ->
      send(parent, {:authorization, Plug.Conn.get_req_header(conn, "authorization")})

      Req.Test.json(conn, %{})
    end)

    {:ok, client: Req.new(plug: {Req.Test, __MODULE__}, url: "https://api.stripe.test/v1/products")}
  end

  test "sets the authorization header from the :api_key option", %{client: client} do
    assert {:ok, %Req.Response{}} = client |> APIKey.attach() |> Req.request(api_key: "sk_test_option")

    assert_received {:authorization, ["Bearer sk_test_option"]}
  end

  test "falls back to the configured api key", %{client: client} do
    assert {:ok, %Req.Response{}} = client |> APIKey.attach() |> Req.request()

    assert_received {:authorization, ["Bearer sk_test_123"]}
  end

  test "falls back to the configured api key when the option is nil", %{client: client} do
    assert {:ok, %Req.Response{}} = client |> APIKey.attach() |> Req.request(api_key: nil)

    assert_received {:authorization, ["Bearer sk_test_123"]}
  end

  test "resolves a function api key configuration", %{client: client} do
    Application.put_env(:stripity_stripe, :api_key, fn -> "sk_test_resolved" end)

    assert {:ok, %Req.Response{}} = client |> APIKey.attach() |> Req.request()

    assert_received {:authorization, ["Bearer sk_test_resolved"]}
  end

  test "sends an empty bearer token when no api key is configured", %{client: client} do
    Application.delete_env(:stripity_stripe, :api_key)

    assert {:ok, %Req.Response{}} = client |> APIKey.attach() |> Req.request()

    assert_received {:authorization, ["Bearer "]}
  end

  test "leaves the request unauthenticated when the option is false", %{client: client} do
    assert {:ok, %Req.Response{}} = client |> APIKey.attach() |> Req.request(api_key: false)

    assert_received {:authorization, []}
  end

  test "does not set the authorization header when not attached", %{client: client} do
    assert {:ok, %Req.Response{}} = Req.request(client)

    assert_received {:authorization, []}
  end
end

defmodule Stripe.API.APIVersionTest do
  use Stripe.StripeCase

  alias Stripe.API.APIVersion

  @default_api_version "2025-11-17.clover"

  setup {Req.Test, :verify_on_exit!}

  setup do
    api_version = Application.fetch_env(:stripity_stripe, :api_version)

    on_exit(fn ->
      case api_version do
        {:ok, api_version} -> Application.put_env(:stripity_stripe, :api_version, api_version)
        :error -> Application.delete_env(:stripity_stripe, :api_version)
      end
    end)

    parent = self()

    Req.Test.expect(__MODULE__, fn conn ->
      send(parent, {:user_agent, Plug.Conn.get_req_header(conn, "user-agent")})
      send(parent, {:stripe_version, Plug.Conn.get_req_header(conn, "stripe-version")})

      Req.Test.json(conn, %{})
    end)

    {:ok, client: Req.new(plug: {Req.Test, __MODULE__}, url: "https://api.stripe.test/v1/products")}
  end

  test "sets the version headers from the :api_version option", %{client: client} do
    assert {:ok, %Req.Response{}} =
             client |> APIVersion.attach() |> Req.request(api_version: "2018-11-04")

    assert_received {:user_agent, ["Stripe/v1 stripe-elixir/2018-11-04"]}
    assert_received {:stripe_version, ["2018-11-04"]}
  end

  test "falls back to the configured api version", %{client: client} do
    Application.put_env(:stripity_stripe, :api_version, "2019-05-16")

    assert {:ok, %Req.Response{}} = client |> APIVersion.attach() |> Req.request()

    assert_received {:user_agent, ["Stripe/v1 stripe-elixir/2019-05-16"]}
    assert_received {:stripe_version, ["2019-05-16"]}
  end

  test "resolves a function api version configuration", %{client: client} do
    Application.put_env(:stripity_stripe, :api_version, fn -> "2020-08-27" end)

    assert {:ok, %Req.Response{}} = client |> APIVersion.attach() |> Req.request()

    assert_received {:user_agent, ["Stripe/v1 stripe-elixir/2020-08-27"]}
    assert_received {:stripe_version, ["2020-08-27"]}
  end

  test "falls back to the pinned version when nothing is configured", %{client: client} do
    Application.delete_env(:stripity_stripe, :api_version)

    assert {:ok, %Req.Response{}} = client |> APIVersion.attach() |> Req.request()

    assert_received {:user_agent, ["Stripe/v1 stripe-elixir/" <> @default_api_version]}
    assert_received {:stripe_version, [@default_api_version]}
  end

  test "the :api_version option takes precedence over the configuration", %{client: client} do
    Application.put_env(:stripity_stripe, :api_version, "2019-05-16")

    assert {:ok, %Req.Response{}} =
             client |> APIVersion.attach() |> Req.request(api_version: "2018-11-04")

    assert_received {:user_agent, ["Stripe/v1 stripe-elixir/2018-11-04"]}
    assert_received {:stripe_version, ["2018-11-04"]}
  end

  test "falls back to the configuration when the option is nil", %{client: client} do
    Application.put_env(:stripity_stripe, :api_version, "2019-05-16")

    assert {:ok, %Req.Response{}} = client |> APIVersion.attach() |> Req.request(api_version: nil)

    assert_received {:user_agent, ["Stripe/v1 stripe-elixir/2019-05-16"]}
    assert_received {:stripe_version, ["2019-05-16"]}
  end

  test "does not set the stripe version header when not attached", %{client: client} do
    assert {:ok, %Req.Response{}} = Req.request(client)

    assert_received {:stripe_version, []}
  end
end

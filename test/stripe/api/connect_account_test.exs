defmodule Stripe.API.ConnectAccountTest do
  use Stripe.StripeCase

  alias Stripe.API.ConnectAccount

  setup {Req.Test, :verify_on_exit!}

  setup do
    parent = self()

    Req.Test.expect(__MODULE__, fn conn ->
      send(parent, {:stripe_account, Plug.Conn.get_req_header(conn, "stripe-account")})

      Req.Test.json(conn, %{})
    end)

    {:ok, client: Req.new(plug: {Req.Test, __MODULE__}, url: "https://api.stripe.test/v1/products")}
  end

  test "sets the stripe account header from the :connect_account option", %{client: client} do
    assert {:ok, %Req.Response{}} =
             client |> ConnectAccount.attach() |> Req.request(connect_account: "acct_134151")

    assert_received {:stripe_account, ["acct_134151"]}
  end

  test "does not set the stripe account header when the option is missing", %{client: client} do
    assert {:ok, %Req.Response{}} = client |> ConnectAccount.attach() |> Req.request()

    assert_received {:stripe_account, []}
  end

  test "does not set the stripe account header when the option is nil", %{client: client} do
    assert {:ok, %Req.Response{}} =
             client |> ConnectAccount.attach() |> Req.request(connect_account: nil)

    assert_received {:stripe_account, []}
  end

  test "does not set the stripe account header when not attached", %{client: client} do
    assert {:ok, %Req.Response{}} = Req.request(client)

    assert_received {:stripe_account, []}
  end
end

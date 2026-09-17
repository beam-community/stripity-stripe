defmodule Stripe.Connect.OAuthTest do
  use ExUnit.Case

  alias Stripe.Connect.OAuth

  setup {Req.Test, :verify_on_exit!}

  test "oauth methods works" do
    Req.Test.expect(Stripe.API, fn conn ->
      assert conn.method == "POST"
      assert conn.host == "connect.stripe.com"
      assert conn.request_path == "/oauth/token"

      {:ok, body, conn} = Plug.Conn.read_body(conn)
      assert body =~ "code=1234"
      assert body =~ "grant_type=authorization_code"

      Req.Test.json(conn, %{"access_token" => "sk_test_123"})
    end)

    assert {:ok, %{access_token: "sk_test_123"}} =
             OAuth.token("1234", plug: {Req.Test, Stripe.API})
  end

  describe "authorize_url/2" do
    test "retrurn standard account by default" do
      assert OAuth.authorize_url() =~ ~r/^https:\/\/connect.stripe.com/
    end

    test "retrurn express account url" do
      assert OAuth.authorize_url(%{}, :express) =~
               ~r/^https:\/\/connect.stripe.com\/express/
    end
  end
end

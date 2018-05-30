defmodule Stripe.Connect.OAuthTest do
  use ExUnit.Case

  import Mox

  test "oauth token works" do
    Stripe.APIMock
    |> expect(:oauth_request, fn(method, _endpoint, _body) -> method end)

    Stripe.Connect.OAuthMock
    |> expect(:token, fn(url) -> Stripe.APIMock.oauth_request(:post, url, %{body: "body"}) end)
    |> expect(:deauthorize_url, fn(url) -> url end)

    assert Stripe.Connect.OAuthMock.token("1234") == :post
    assert Stripe.Connect.OAuthMock.deauthorize_url("www.google.com") == "www.google.com"
  end
end


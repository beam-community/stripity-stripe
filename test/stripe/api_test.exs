defmodule Stripe.APITest do
  use ExUnit.Case

  import Mox

  test "works with 301 responses without issue" do
    {:error, %Stripe.Error{extra: %{http_status: 301}}} =
      Stripe.API.request(%{}, :get, "/", %{}, [])
  end

  test "oauth_request works" do
    verify_on_exit!()

    Stripe.APIMock
    |> expect(:oauth_request, fn(method, _endpoint, _body) -> method end)

    assert Stripe.APIMock.oauth_request(:post, "www", %{body: "body"}) == :post
  end

  describe "generate_idempotency_key" do
    test "returns string value" do
      key = Stripe.API.generate_idempotency_key()

      assert key
      assert is_binary(key)
    end

    test "returns unique value" do
      key1 = Stripe.API.generate_idempotency_key()
      key2 = Stripe.API.generate_idempotency_key()

      assert key1 != key2
    end
  end
end

defmodule Stripe.APITest do
  import Mox
  use Stripe.StripeCase

  test "works with non existent responses without issue" do
    {:error, %Stripe.Error{extra: %{http_status: 404}}} =
      Stripe.API.request(%{}, :get, "/", %{}, [])
  end

  test "oauth_request works" do
    verify_on_exit!()

    Stripe.APIMock
    |> expect(:oauth_request, fn method, _endpoint, _body -> method end)

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

  describe "should_retry?" do
    test "given timeout error" do
      assert Stripe.API.should_retry?({:error, :timeout})
    end

    test "given connection timeout error" do
      assert Stripe.API.should_retry?({:error, :connect_timeout})
    end

    test "given connection refused error" do
      assert Stripe.API.should_retry?({:error, :econnrefused})
    end

    test "given other error" do
      refute Stripe.API.should_retry?({:error, :unknown})
    end

    test "given HTTP 200 response" do
      refute Stripe.API.should_retry?({:ok, 200, [], ""})
    end

    test "given attempts greater than max_attempts" do
      refute Stripe.API.should_retry?({:error, :timeout}, 2, max_attempts: 1)
    end

    test "given attempts less than max_attempts" do
      assert Stripe.API.should_retry?({:error, :timeout}, 0, max_attempts: 1)
    end

    test "given attempts equals to max_attempts" do
      refute Stripe.API.should_retry?({:error, :timeout}, 1, max_attempts: 1)
    end
  end

  describe "backoff" do
    test "given attempts = 0" do
      backoff = Stripe.API.backoff(0, base_backoff: 10, max_backoff: 100)
      assert backoff == 10
    end

    test "given attempts = 1" do
      backoff = Stripe.API.backoff(1, base_backoff: 10, max_backoff: 100)
      assert backoff in 10..20
    end

    test "given attempts = 2" do
      backoff = Stripe.API.backoff(2, base_backoff: 10, max_backoff: 100)
      assert backoff in 20..40
    end
  end

  test "gets default api version" do
    Stripe.API.request(%{}, :get, "products", %{}, [])
    assert_stripe_requested(:get, "/v1/products", headers: {"Stripe-Version", "2019-12-03"})
  end

  test "can set custom api version" do
    Stripe.API.request(%{}, :get, "products", %{},
      api_version: "2019-05-16; checkout_sessions_beta=v1"
    )

    assert_stripe_requested(:get, "/v1/products",
      headers: {"Stripe-Version", "2019-05-16; checkout_sessions_beta=v1"}
    )
  end

  test "oauth_request sets authorization header for deauthorize request" do
    defmodule HackneyMock do
      def request(_, _, headers, _, _) do
        kv_headers =
          headers
          |> Enum.reduce(%{}, fn {k, v}, acc -> Map.put(acc, k, v) end)

        {:ok, 200, headers, Jason.encode!(kv_headers)}
      end
    end

    Application.put_env(:stripity_stripe, :http_module, HackneyMock)

    {:ok, body} = Stripe.API.oauth_request(:post, "deauthorize", %{})
    assert body["Authorization"] == "Bearer sk_test_123"

    {:ok, body} = Stripe.API.oauth_request(:post, "deauthorize", %{}, "1234")
    assert body["Authorization"] == "Bearer 1234"

    {:ok, body} = Stripe.API.oauth_request(:post, "token", %{})
    assert Map.keys(body) |> Enum.member?("Authorization") == false
  end

  @tag :wip
  test "reads hackney timeout opts from config" do
    # Return request opts as response body
    defmodule HackneyMock do
      def request(_, _, headers, _, opts) do
        kv_opts =
          opts
          |> Enum.reduce(%{}, fn opt, acc ->
            case opt do
              {k, v} ->
                Map.put(acc, k, v)

              _ ->
                Map.put(acc, opt, opt)
            end
          end)

        {:ok, 200, headers, Jason.encode!(kv_opts)}
      end
    end

    Application.put_env(:stripity_stripe, :http_module, HackneyMock)

    {:ok, request_opts} = Stripe.API.request(%{}, :get, "/", %{}, [])
    refute Map.has_key?(request_opts, "connect_timeout")
    refute Map.has_key?(request_opts, "recv_timeout")

    Application.put_env(:stripity_stripe, :hackney_opts, [
      {:connect_timeout, 1000},
      {:recv_timeout, 5000}
    ])

    {:ok, request_opts} = Stripe.API.oauth_request(:post, "token", %{})
    assert request_opts["connect_timeout"] == 1000
    assert request_opts["recv_timeout"] == 5000

    {:ok, request_opts} = Stripe.API.request(%{}, :get, "/", %{}, [])
    assert request_opts["connect_timeout"] == 1000
    assert request_opts["recv_timeout"] == 5000
  end
end

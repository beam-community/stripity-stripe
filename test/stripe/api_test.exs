defmodule Stripe.APITest do
  import Mox
  use Stripe.StripeCase

  def telemetry_handler_fn(name, measurements, metadata, _config) do
    send(self(), {:telemetry_event, name, measurements, metadata})
  end

  test "works with non existent responses without issue" do
    {:error, %Stripe.Error{extra: %{http_status: 404}}} =
      Stripe.API.request(%{}, :get, "/", %{}, [])
  end

  test "request_id is a string" do
    {:error, %Stripe.Error{request_id: "req_123"}} = Stripe.API.request(%{}, :get, "/", %{}, [])
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

  describe "telemetry" do
    test "requests emit :start, :stop telemetry events", %{test: test} do
      :telemetry.attach_many(
        "#{test}",
        [[:stripe, :request, :start], [:stripe, :request, :stop]],
        &__MODULE__.telemetry_handler_fn/4,
        nil
      )

      %{query: ~s|email: "test@example.com"|}
      |> Stripe.API.request(:get, "/v1/customers/search", %{}, [])

      assert_received({
        :telemetry_event,
        [:stripe, :request, :start],
        %{monotonic_time: _},
        %{telemetry_span_context: _}
      })

      assert_received({
        :telemetry_event,
        [:stripe, :request, :stop],
        %{monotonic_time: _, duration: _},
        %{
          http_method: :get,
          http_retry_count: 0,
          http_status_code: 200,
          http_url: http_url,
          stripe_api_version: _,
          stripe_api_endpoint: "/v1/customers/search",
          telemetry_span_context: _
        }
      })

      assert String.ends_with?(http_url, "/v1/customers/search")
      assert not String.contains?(http_url, "test@example.com")
    end
  end

  @tag :skip
  test "gets default api version" do
    Stripe.API.request(%{}, :get, "products", %{}, [])
    assert_stripe_requested(:get, "/v1/products", headers: {"Stripe-Version", "2022-11-15"})
  end

  @tag :skip
  test "can set custom api version" do
    Stripe.API.request(%{}, :get, "products", %{},
      api_version: "2019-05-16; checkout_sessions_beta=v1"
    )

    assert_stripe_requested(:get, "/v1/products",
      headers: {"Stripe-Version", "2019-05-16; checkout_sessions_beta=v1"}
    )
  end

  test "oauth_request sets authorization header for deauthorize request" do
    defmodule HackneyMock1 do
      def request(_, _, headers, _, _) do
        kv_headers =
          headers
          |> Enum.reduce(%{}, fn {k, v}, acc -> Map.put(acc, k, v) end)

        {:ok, 200, headers, Jason.encode!(kv_headers)}
      end
    end

    Application.put_env(:stripity_stripe, :http_module, HackneyMock1)

    {:ok, body} = Stripe.API.oauth_request(:post, "deauthorize", %{})
    assert body["Authorization"] == "Bearer sk_test_123"

    {:ok, body} = Stripe.API.oauth_request(:post, "deauthorize", %{}, "1234")
    assert body["Authorization"] == "Bearer 1234"

    {:ok, body} = Stripe.API.oauth_request(:post, "token", %{})
    assert Map.keys(body) |> Enum.member?("Authorization") == false
  end

  test "reads hackney timeout opts from config" do
    # Return request opts as response body
    defmodule HackneyMock2 do
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

    Application.put_env(:stripity_stripe, :http_module, HackneyMock2)

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

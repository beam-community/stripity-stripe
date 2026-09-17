defmodule Stripe.APITest do
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
    Req.Test.verify_on_exit!()

    Req.Test.expect(Stripe.API, fn conn ->
      assert conn.method == "POST"
      assert conn.host == "connect.stripe.com"
      assert conn.request_path == "/oauth/token"

      {:ok, body, conn} = Plug.Conn.read_body(conn)
      assert body == "code=abc"

      Req.Test.json(conn, %{"access_token" => "sk_test_123"})
    end)

    assert {:ok, %{"access_token" => "sk_test_123"}} =
             Stripe.API.oauth_request(:post, "token", %{code: "abc"}, nil, plug: {Req.Test, Stripe.API})
  end

  describe "retries" do
    test "retries idempotent requests on HTTP 429" do
      Req.Test.verify_on_exit!()

      Req.Test.expect(Stripe.API, fn conn -> Plug.Conn.send_resp(conn, 429, "") end)
      Req.Test.expect(Stripe.API, fn conn -> Req.Test.json(conn, %{}) end)

      assert {:ok, %{}} =
               Stripe.API.request(%{}, :post, "/v1/products", %{},
                 plug: {Req.Test, Stripe.API},
                 retry_delay: 0
               )
    end

    test "does not retry requests without an idempotency key" do
      Req.Test.verify_on_exit!()

      Req.Test.expect(Stripe.API, fn conn -> Plug.Conn.send_resp(conn, 429, "") end)

      assert {:error, %Stripe.Error{extra: %{http_status: 429}}} =
               Stripe.API.request(%{}, :get, "/v1/products", %{},
                 plug: {Req.Test, Stripe.API},
                 retry_delay: 0
               )
    end
  end

  describe "telemetry" do
    test "requests emit :start, :stop telemetry events", %{test: test} do
      handler_id = "#{test}"

      :telemetry.attach_many(
        handler_id,
        [[:stripe, :request, :start], [:stripe, :request, :stop]],
        &__MODULE__.telemetry_handler_fn/4,
        nil
      )

      on_exit(fn -> :telemetry.detach(handler_id) end)

      Stripe.API.request(%{query: ~s|email: "test@example.com"|}, :get, "/v1/customers/search", %{}, [])

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

  test "gets default api version" do
    Stripe.API.request(%{}, :get, "/v1/products", %{}, [])
    assert_stripe_requested(:get, "/v1/products", headers: {"Stripe-Version", "2025-11-17.clover"})
  end

  test "can set custom api version" do
    Stripe.API.request(%{}, :get, "/v1/products", %{}, api_version: "2019-05-16; checkout_sessions_beta=v1")

    assert_stripe_requested(:get, "/v1/products", headers: {"Stripe-Version", "2019-05-16; checkout_sessions_beta=v1"})
  end

  test "oauth_request sets authorization header for deauthorize request" do
    Req.Test.verify_on_exit!()
    opts = [plug: {Req.Test, Stripe.API}]

    Req.Test.expect(Stripe.API, fn conn ->
      assert Plug.Conn.get_req_header(conn, "authorization") == ["Bearer sk_test_123"]
      Req.Test.json(conn, %{})
    end)

    assert {:ok, %{}} = Stripe.API.oauth_request(:post, "deauthorize", %{}, nil, opts)

    Req.Test.expect(Stripe.API, fn conn ->
      assert Plug.Conn.get_req_header(conn, "authorization") == ["Bearer 1234"]
      Req.Test.json(conn, %{})
    end)

    assert {:ok, %{}} = Stripe.API.oauth_request(:post, "deauthorize", %{}, "1234", opts)

    Req.Test.expect(Stripe.API, fn conn ->
      assert Plug.Conn.get_req_header(conn, "authorization") == []
      Req.Test.json(conn, %{})
    end)

    assert {:ok, %{}} = Stripe.API.oauth_request(:post, "token", %{}, nil, opts)
  end

  test "requests do not set the connection header" do
    Req.Test.verify_on_exit!()

    Req.Test.expect(Stripe.API, fn conn ->
      assert Plug.Conn.get_req_header(conn, "connection") == []
      assert [accept_encoding] = Plug.Conn.get_req_header(conn, "accept-encoding")
      assert accept_encoding =~ "gzip"

      Req.Test.json(conn, %{})
    end)

    assert {:ok, %{}} =
             Stripe.API.request(%{}, :get, "/v1/products", %{}, plug: {Req.Test, Stripe.API})
  end

  test "reads req options from config" do
    Req.Test.verify_on_exit!()

    Application.put_env(:stripity_stripe, :req_options,
      plug: {Req.Test, Stripe.API},
      headers: %{"X-Custom" => "1"}
    )

    on_exit(fn -> Application.delete_env(:stripity_stripe, :req_options) end)

    Req.Test.expect(Stripe.API, 2, fn conn ->
      assert Plug.Conn.get_req_header(conn, "x-custom") == ["1"]
      Req.Test.json(conn, %{})
    end)

    assert {:ok, %{}} = Stripe.API.oauth_request(:post, "token", %{})
    assert {:ok, %{}} = Stripe.API.request(%{}, :get, "/", %{}, [])
  end
end

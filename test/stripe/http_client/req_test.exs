defmodule Stripe.HTTPClient.ReqTest do
  use Stripe.StripeCase

  alias Stripe.HTTPClient.Req, as: ReqClient

  @url "http://stripe.test/v1/customers"

  defp put_env(key, value) do
    previous = Application.fetch_env(:stripity_stripe, key)

    Application.put_env(:stripity_stripe, key, value)

    on_exit(fn ->
      case previous do
        {:ok, previous_value} -> Application.put_env(:stripity_stripe, key, previous_value)
        :error -> Application.delete_env(:stripity_stripe, key)
      end
    end)
  end

  describe "request/5" do
    test "sends the request and returns the response with a list of headers" do
      test_pid = self()

      plug = fn conn ->
        {:ok, body, conn} = Plug.Conn.read_body(conn)
        send(test_pid, {:plug_request, conn.method, conn.request_path, conn.query_string, conn.req_headers, body})

        conn
        |> Plug.Conn.put_resp_header("request-id", "req_123")
        |> Plug.Conn.send_resp(201, ~s({"id":"cus_123"}))
      end

      assert {:ok, 201, headers, ~s({"id":"cus_123"})} =
               ReqClient.request(
                 :post,
                 @url <> "?expand[]=default_source",
                 [{"Content-Type", "application/x-www-form-urlencoded"}],
                 "email=jane%40example.com",
                 plug: plug
               )

      assert {"request-id", "req_123"} in headers

      assert_received {:plug_request, "POST", "/v1/customers", "expand[]=default_source", req_headers,
                       "email=jane%40example.com"}

      assert {"content-type", "application/x-www-form-urlencoded"} in req_headers
    end

    test "returns compressed bodies as received" do
      gzipped = :zlib.gzip(~s({"id":"cus_123"}))

      plug = fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-encoding", "gzip")
        |> Plug.Conn.send_resp(200, gzipped)
      end

      assert {:ok, 200, headers, ^gzipped} =
               ReqClient.request(:get, @url, [{"Accept-Encoding", "gzip"}], "", plug: plug)

      assert {"content-encoding", "gzip"} in headers
    end

    test "encodes multipart bodies, sending the file as the \"file\" field" do
      test_pid = self()
      path = Path.join(__DIR__, "../../fixtures/upload.txt")

      plug = fn conn ->
        {:ok, body, conn} = Plug.Conn.read_body(conn)
        send(test_pid, {:plug_request, Plug.Conn.get_req_header(conn, "content-type"), body})
        Plug.Conn.send_resp(conn, 200, "{}")
      end

      assert {:ok, 200, _headers, "{}"} =
               ReqClient.request(
                 :post,
                 @url,
                 [{"Content-Type", "multipart/form-data"}],
                 {:multipart, [{:file, path}, {"purpose", "dispute_evidence"}]},
                 plug: plug
               )

      assert_received {:plug_request, [content_type], body}
      assert "multipart/form-data; boundary=" <> _boundary = content_type
      assert body =~ ~s(name="file"; filename="upload.txt")
      assert body =~ File.read!(path)
      assert body =~ ~s(name="purpose")
      assert body =~ "dispute_evidence"
    end

    test "returns the reason of transport errors" do
      assert {:error, :timeout} =
               ReqClient.request(:get, @url, [], "", plug: &Req.Test.transport_error(&1, :timeout))
    end

    test "doesn't retry or follow redirects" do
      test_pid = self()

      plug = fn conn ->
        send(test_pid, :plug_called)

        case conn.request_path do
          "/v1/unavailable" ->
            Plug.Conn.send_resp(conn, 503, "")

          _ ->
            conn
            |> Plug.Conn.put_resp_header("location", "/v1/unavailable")
            |> Plug.Conn.send_resp(302, "")
        end
      end

      assert {:ok, 503, _headers, ""} = ReqClient.request(:get, "http://stripe.test/v1/unavailable", [], "", plug: plug)
      assert_received :plug_called
      refute_received :plug_called

      assert {:ok, 302, _headers, ""} = ReqClient.request(:get, @url, [], "", plug: plug)
      assert_received :plug_called
      refute_received :plug_called
    end

    test "uses req_opts from config, with per-request options taking precedence" do
      put_env(:req_opts, plug: fn conn -> Plug.Conn.send_resp(conn, 200, "config") end)

      assert {:ok, 200, _headers, "config"} = ReqClient.request(:get, @url, [], "", [])

      assert {:ok, 200, _headers, "request"} =
               ReqClient.request(:get, @url, [], "", plug: fn conn -> Plug.Conn.send_resp(conn, 200, "request") end)
    end

    test "works with connect_options, which Req doesn't allow with a named pool" do
      put_env(:req_opts, connect_options: [timeout: 1_000])

      assert {:ok, 200, _headers, _body} =
               ReqClient.request(
                 :get,
                 stripe_base_url() <> "/v1/customers",
                 [{"Authorization", "Bearer sk_test_123"}],
                 "",
                 []
               )
    end
  end

  describe "supervisor_children/0" do
    test "returns a Finch pool configured from pool_options" do
      put_env(:pool_options, timeout: 5_000, max_connections: 10)

      assert [{Finch, opts}] = ReqClient.supervisor_children()
      assert opts[:name] == Stripe.Finch
      assert opts[:pools] == %{default: [size: 10, conn_max_idle_time: 5_000]}

      start_supervised!({Finch, Keyword.put(opts, :name, __MODULE__.Finch)})
    end

    test "returns nothing when the connection pool is disabled" do
      put_env(:use_connection_pool, false)

      assert ReqClient.supervisor_children() == []
    end
  end
end

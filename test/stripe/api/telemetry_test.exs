defmodule Stripe.API.TelemetryTest do
  use Stripe.StripeCase

  alias Stripe.API.Telemetry

  @start [:stripe, :request, :start]
  @stop [:stripe, :request, :stop]

  setup do
    ref = :telemetry_test.attach_event_handlers(self(), [@start, @stop])
    on_exit(fn -> :telemetry.detach(ref) end)

    client =
      Req.new(
        plug: {Req.Test, __MODULE__},
        url: "https://api.stripe.test/v1/products",
        headers: [{"stripe-version", "2025-11-17.clover"}]
      )

    {:ok, ref: ref, client: client}
  end

  test "emits a start and a stop event", %{ref: ref, client: client} do
    stub_status(200)

    assert {:ok, %Req.Response{}} = client |> Telemetry.attach() |> Req.request(method: :get)

    assert_received {@start, ^ref, _measurements, metadata}

    assert %{
             http_method: :get,
             http_retry_count: 0,
             http_status_code: nil,
             http_url: "https://api.stripe.test/v1/products",
             stripe_api_endpoint: "/v1/products",
             stripe_api_version: "2025-11-17.clover",
             telemetry_span_context: span
           } = metadata

    assert_received {@stop, ^ref, _measurements, stop_metadata}
    assert %{http_status_code: 200, telemetry_span_context: ^span} = stop_metadata
  end

  test "strips the query string from the URL", %{ref: ref, client: client} do
    stub_status(200)

    assert {:ok, %Req.Response{}} =
             client
             |> Telemetry.attach()
             |> Req.request(method: :get, params: [email: "test@example.com"])

    assert_received {@start, ^ref, _measurements, %{http_url: http_url}}
    assert http_url == "https://api.stripe.test/v1/products"
  end

  test "reports the response status on stop", %{ref: ref, client: client} do
    stub_status(404)

    assert {:ok, %Req.Response{status: 404}} =
             client |> Telemetry.attach() |> Req.request(method: :get)

    assert_received {@stop, ^ref, _measurements, %{http_status_code: 404}}
  end

  test "emits a stop event on a transport error", %{ref: ref, client: client} do
    Req.Test.stub(__MODULE__, fn conn -> Req.Test.transport_error(conn, :timeout) end)

    assert {:error, %Req.TransportError{reason: :timeout}} =
             client |> Telemetry.attach() |> Req.request(method: :get, retry: false)

    assert_received {@start, ^ref, _measurements, %{telemetry_span_context: span}}

    assert_received {@stop, ^ref, _measurements, %{http_status_code: nil, telemetry_span_context: ^span}}
  end

  test "emits one pair of events per attempt", %{ref: ref, client: client} do
    Req.Test.expect(__MODULE__, fn conn -> Plug.Conn.send_resp(conn, 429, "") end)
    Req.Test.expect(__MODULE__, fn conn -> Req.Test.json(conn, %{}) end)

    assert {:ok, %Req.Response{status: 200}} =
             client
             |> Telemetry.attach()
             |> Req.request(
               method: :get,
               retry: :transient,
               max_retries: 1,
               retry_delay: 0,
               retry_log_level: false
             )

    assert_received {@start, ^ref, _measurements, %{http_retry_count: 0, telemetry_span_context: first}}
    assert_received {@stop, ^ref, _measurements, %{http_status_code: 429, telemetry_span_context: ^first}}

    assert_received {@start, ^ref, _measurements, %{http_retry_count: 1, telemetry_span_context: second}}
    assert_received {@stop, ^ref, _measurements, %{http_status_code: 200, telemetry_span_context: ^second}}

    refute first == second
  end

  test "merges the :telemetry_metadata option into both events", %{ref: ref, client: client} do
    stub_status(200)

    assert {:ok, %Req.Response{}} =
             client
             |> Telemetry.attach()
             |> Req.request(method: :get, telemetry_metadata: %{resource: Stripe.Product})

    assert_received {@start, ^ref, _measurements, %{resource: Stripe.Product}}
    assert_received {@stop, ^ref, _measurements, %{resource: Stripe.Product}}
  end

  test "accepts the metadata as an attach option", %{ref: ref, client: client} do
    stub_status(200)

    assert {:ok, %Req.Response{}} =
             client
             |> Telemetry.attach(telemetry_metadata: %{resource: Stripe.Product})
             |> Req.request(method: :get)

    assert_received {@start, ^ref, _measurements, %{resource: Stripe.Product}}
  end

  test "does not let the metadata override the built-in keys", %{ref: ref, client: client} do
    stub_status(200)

    assert {:ok, %Req.Response{}} =
             client
             |> Telemetry.attach()
             |> Req.request(method: :get, telemetry_metadata: %{http_method: :patch})

    assert_received {@start, ^ref, _measurements, %{http_method: :get}}
  end

  test "emits nothing when not attached", %{ref: ref, client: client} do
    stub_status(200)

    assert {:ok, %Req.Response{}} = Req.request(client, method: :get)

    refute_received {@start, ^ref, _measurements, _metadata}
    refute_received {@stop, ^ref, _measurements, _metadata}
  end

  defp stub_status(status) do
    Req.Test.stub(__MODULE__, fn conn -> Plug.Conn.send_resp(conn, status, "") end)
  end
end

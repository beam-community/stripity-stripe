defmodule Stripe.API.IdempotencyKeyTest do
  use Stripe.StripeCase

  alias Stripe.API.IdempotencyKey

  setup {Req.Test, :verify_on_exit!}

  setup do
    {:ok, client: Req.new(plug: {Req.Test, __MODULE__}, url: "https://api.stripe.test/v1/products")}
  end

  test "generates an idempotency key", %{client: client} do
    expect_key()

    assert {:ok, %Req.Response{}} = client |> IdempotencyKey.attach() |> Req.request(method: :post)

    assert_received {:idempotency_key, [key]}
    assert key =~ ~r/^[0-9a-v]{24}$/
  end

  test "generates a different key on every request", %{client: client} do
    expect_key()
    expect_key()

    client = IdempotencyKey.attach(client)

    assert {:ok, %Req.Response{}} = Req.request(client, method: :post)
    assert {:ok, %Req.Response{}} = Req.request(client, method: :post)

    assert_received {:idempotency_key, [first]}
    assert_received {:idempotency_key, [second]}
    refute first == second
  end

  test "sets the idempotency key from the :idempotency_key option", %{client: client} do
    expect_key()

    assert {:ok, %Req.Response{}} =
             client
             |> IdempotencyKey.attach()
             |> Req.request(method: :post, idempotency_key: "key_123")

    assert_received {:idempotency_key, ["key_123"]}
  end

  test "a key already in the headers wins over the option", %{client: client} do
    expect_key()

    assert {:ok, %Req.Response{}} =
             client
             |> IdempotencyKey.attach()
             |> Req.request(
               method: :post,
               idempotency_key: "from_option",
               headers: [{"idempotency-key", "from_header"}]
             )

    assert_received {:idempotency_key, ["from_header"]}
  end

  for method <- [:get, :head, :put, :delete] do
    test "does not set the header on #{method} requests", %{client: client} do
      expect_key()

      assert {:ok, %Req.Response{}} =
               client
               |> IdempotencyKey.attach()
               |> Req.request(method: unquote(method), idempotency_key: "key_123")

      assert_received {:idempotency_key, []}
    end
  end

  test "does not set the header when not attached", %{client: client} do
    expect_key()

    assert {:ok, %Req.Response{}} = Req.request(client, method: :post)

    assert_received {:idempotency_key, []}
  end

  for status <- [409, 429] do
    test "retries requests carrying the header on a #{status} response", %{client: client} do
      expect_status(unquote(status))
      expect_key()

      assert {:ok, %Req.Response{status: 200}} = retryable_request(client, :post)

      assert_received {:idempotency_key, [_key]}
    end
  end

  for reason <- [:econnrefused, :timeout] do
    test "retries requests carrying the header on a #{reason} transport error", %{client: client} do
      expect_transport_error(unquote(reason))
      expect_key()

      assert {:ok, %Req.Response{status: 200}} = retryable_request(client, :post)

      assert_received {:idempotency_key, [_key]}
    end
  end

  test "does not retry other statuses", %{client: client} do
    expect_status(500)

    assert {:ok, %Req.Response{status: 500}} = retryable_request(client, :post)
  end

  test "does not retry other transport errors", %{client: client} do
    expect_transport_error(:closed)

    assert {:error, %Req.TransportError{reason: :closed}} = retryable_request(client, :post)
  end

  test "does not retry requests without the header", %{client: client} do
    expect_status(429)

    assert {:ok, %Req.Response{status: 429}} = retryable_request(client, :get)
  end

  defp expect_key do
    parent = self()

    Req.Test.expect(__MODULE__, fn conn ->
      send(parent, {:idempotency_key, Plug.Conn.get_req_header(conn, "idempotency-key")})

      Req.Test.json(conn, %{})
    end)
  end

  defp expect_status(status) do
    Req.Test.expect(__MODULE__, fn conn -> Plug.Conn.send_resp(conn, status, "") end)
  end

  defp expect_transport_error(reason) do
    Req.Test.expect(__MODULE__, fn conn -> Req.Test.transport_error(conn, reason) end)
  end

  defp retryable_request(client, method) do
    client
    |> IdempotencyKey.attach()
    |> Req.request(method: method, max_retries: 1, retry_delay: 0, retry_log_level: false)
  end
end

defmodule Stripe.API.ErrorHandlerTest do
  use Stripe.StripeCase

  alias Stripe.API.ErrorHandler
  alias Stripe.Error

  setup {Req.Test, :verify_on_exit!}

  setup do
    {:ok,
     client:
       Req.new(
         plug: {Req.Test, __MODULE__},
         url: "https://api.stripe.test/v1/products",
         retry: false
       )}
  end

  test "leaves successful responses untouched", %{client: client} do
    Req.Test.expect(__MODULE__, fn conn -> Req.Test.json(conn, %{"id" => "prod_123"}) end)

    assert {:ok, %Req.Response{status: 200, body: %{"id" => "prod_123"}}} =
             client |> ErrorHandler.attach() |> Req.request()
  end

  test "builds a stripe error from the error object in the body", %{client: client} do
    Req.Test.expect(__MODULE__, fn conn ->
      conn
      |> Plug.Conn.put_resp_header("request-id", "req_123")
      |> Plug.Conn.put_status(402)
      |> Req.Test.json(%{
        "error" => %{
          "type" => "card_error",
          "code" => "card_declined",
          "decline_code" => "insufficient_funds",
          "message" => "Your card was declined.",
          "param" => "card",
          "charge" => "ch_123"
        }
      })
    end)

    assert {:error, %Error{} = error} = client |> ErrorHandler.attach() |> Req.request()

    assert error.source == :stripe
    assert error.code == :card_error
    assert error.request_id == "req_123"
    assert error.message == "Your card was declined."
    assert error.user_message == "Your card was declined."

    assert %{
             http_status: 402,
             card_code: :card_declined,
             decline_code: "insufficient_funds",
             param: "card",
             charge_id: "ch_123"
           } = error.extra
  end

  test "builds a stripe error from an oauth error description", %{client: client} do
    Req.Test.expect(__MODULE__, fn conn ->
      conn
      |> Plug.Conn.put_status(400)
      |> Req.Test.json(%{
        "error" => "invalid_grant",
        "error_description" => "This authorization code has already been used."
      })
    end)

    assert {:error, %Error{} = error} = client |> ErrorHandler.attach() |> Req.request()

    assert error.source == :stripe
    assert error.code == :bad_request
    assert error.extra == %{http_status: 400}
  end

  test "falls back to the status when the body carries no error", %{client: client} do
    Req.Test.expect(__MODULE__, fn conn -> Plug.Conn.send_resp(conn, 404, "") end)

    assert {:error, %Error{} = error} = client |> ErrorHandler.attach() |> Req.request()

    assert error.source == :stripe
    assert error.code == :not_found
    assert error.message == "The requested resource doesn't exist."
    assert error.request_id == nil
    assert error.extra == %{http_status: 404}
  end

  test "handles redirect responses as errors", %{client: client} do
    Req.Test.expect(__MODULE__, fn conn -> Plug.Conn.send_resp(conn, 300, "") end)

    assert {:error, %Error{code: :unknown_error, extra: %{http_status: 300}}} =
             client |> ErrorHandler.attach() |> Req.request(redirect: false)
  end

  test "wraps transport failures in a network error", %{client: client} do
    Req.Test.expect(__MODULE__, fn conn -> Req.Test.transport_error(conn, :econnrefused) end)

    assert {:error, %Error{} = error} = client |> ErrorHandler.attach() |> Req.request()

    assert error.source == :network
    assert error.code == :network_error
    assert error.message =~ "connection refused"
    assert error.extra == %{network_reason: %Req.TransportError{reason: :econnrefused}}
  end

  test "does not build an error when not attached", %{client: client} do
    Req.Test.expect(__MODULE__, fn conn -> Plug.Conn.send_resp(conn, 404, "") end)

    assert {:ok, %Req.Response{status: 404}} = Req.request(client)
  end
end

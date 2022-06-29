defmodule Stripe.WebhookPlugTest do
  use ExUnit.Case
  use Plug.Test
  alias Stripe.WebhookPlug

  @valid_payload ~S({"object": "event"})
  @secret "secret"

  @opts WebhookPlug.init(
          at: "/webhook/stripe",
          handler: __MODULE__.Handler,
          secret: @secret
        )

  defmodule Handler do
    @behaviour Stripe.WebhookHandler

    @impl true
    def handle_event(%Stripe.Event{object: "event"}), do: :ok
  end

  defmodule ErrorTupleStringHandler do
    @behaviour Stripe.WebhookHandler

    @impl true
    def handle_event(%Stripe.Event{object: "event"}), do: {:error, "string error message"}
  end

  defmodule ErrorTupleAtomHandler do
    @behaviour Stripe.WebhookHandler

    @impl true
    def handle_event(%Stripe.Event{object: "event"}), do: {:error, :atom_error_message}
  end

  defmodule ErrorAtomHandler do
    @behaviour Stripe.WebhookHandler

    @impl true
    def handle_event(%Stripe.Event{object: "event"}), do: :error
  end

  defmodule BadHandler do
    def handle_event(_), do: nil
  end

  def get_value(:secret), do: @secret

  defp generate_signature_header(payload) do
    timestamp = System.system_time(:second)

    # TODO: remove when we require OTP 22
    code =
      case System.otp_release() >= "22" do
        true -> :crypto.mac(:hmac, :sha256, @secret, "#{timestamp}.#{payload}")
        false -> :crypto.mac(:sha256, @secret, "#{timestamp}.#{payload}")
      end

    signature =
      code
      |> Base.encode16(case: :lower)

    "t=#{timestamp},v1=#{signature}"
  end

  describe "WebhookPlug" do
    setup do
      signature_header = generate_signature_header(@valid_payload)

      conn =
        conn(:post, "/webhook/stripe", @valid_payload)
        |> put_req_header("stripe-signature", signature_header)

      {:ok, %{conn: conn}}
    end

    test "accepts valid signature", %{conn: conn} do
      result = WebhookPlug.call(conn, @opts)
      assert result.state == :sent
      assert result.status == 200
    end

    test "rejects invalid signature", %{conn: conn} do
      signature_header = generate_signature_header("random")

      conn = put_req_header(conn, "stripe-signature", signature_header)

      result = WebhookPlug.call(conn, @opts)
      assert result.state == :sent
      assert result.status == 400
    end

    test "nil secret should raise an error", %{conn: conn} do
      opts =
        WebhookPlug.init(
          at: "/webhook/stripe",
          handler: __MODULE__.Handler,
          secret: nil
        )

      assert_raise RuntimeError, fn ->
        WebhookPlug.call(conn, opts)
      end
    end

    test "function secret should be evaluated", %{conn: conn} do
      opts =
        WebhookPlug.init(
          at: "/webhook/stripe",
          handler: __MODULE__.Handler,
          secret: fn -> @secret end
        )

      result = WebhookPlug.call(conn, opts)
      assert result.state == :sent
      assert result.status == 200
    end

    test "{m, f, a} secret should be evaluated", %{conn: conn} do
      opts =
        WebhookPlug.init(
          at: "/webhook/stripe",
          handler: __MODULE__.Handler,
          secret: {__MODULE__, :get_value, [:secret]}
        )

      result = WebhookPlug.call(conn, opts)
      assert result.state == :sent
      assert result.status == 200
    end

    test "returns 400 status code with string message if handler returns error tuple", %{
      conn: conn
    } do
      opts =
        WebhookPlug.init(
          at: "/webhook/stripe",
          handler: __MODULE__.ErrorTupleStringHandler,
          secret: @secret
        )

      result = WebhookPlug.call(conn, opts)
      assert result.state == :sent
      assert result.status == 400
      assert result.resp_body == "string error message"
    end

    test "returns 400 status code with atom message if handler returns error tuple", %{conn: conn} do
      opts =
        WebhookPlug.init(
          at: "/webhook/stripe",
          handler: __MODULE__.ErrorTupleAtomHandler,
          secret: @secret
        )

      result = WebhookPlug.call(conn, opts)
      assert result.state == :sent
      assert result.status == 400
      assert result.resp_body == "atom_error_message"
    end

    test "returns 400 status code with no message if handler returns :error atom", %{conn: conn} do
      opts =
        WebhookPlug.init(
          at: "/webhook/stripe",
          handler: __MODULE__.ErrorAtomHandler,
          secret: @secret
        )

      result = WebhookPlug.call(conn, opts)
      assert result.state == :sent
      assert result.status == 400
      assert result.resp_body == ""
    end

    test "crash hard if handler fails", %{conn: conn} do
      opts =
        WebhookPlug.init(
          at: "/webhook/stripe",
          handler: __MODULE__.BadHandler,
          secret: @secret
        )

      assert_raise RuntimeError, fn ->
        WebhookPlug.call(conn, opts)
      end
    end
  end
end

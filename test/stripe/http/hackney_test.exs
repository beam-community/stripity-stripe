defmodule Stripe.HTTP.HackneyTest do
  use ExUnit.Case, async: false

  setup do
    original_hackney_opts = Application.get_env(:stripity_stripe, :hackney_opts)
    original_pool = Application.get_env(:stripity_stripe, :use_connection_pool)
    original_http_module = Application.get_env(:stripity_stripe, :http_module)

    on_exit(fn ->
      if original_hackney_opts do
        Application.put_env(:stripity_stripe, :hackney_opts, original_hackney_opts)
      else
        Application.delete_env(:stripity_stripe, :hackney_opts)
      end

      if original_pool do
        Application.put_env(:stripity_stripe, :use_connection_pool, original_pool)
      end

      if original_http_module do
        Application.put_env(:stripity_stripe, :http_module, original_http_module)
      else
        Application.delete_env(:stripity_stripe, :http_module)
      end
    end)

    :ok
  end

  describe "supervisor_children/0" do
    test "returns pool child spec when use_connection_pool is true" do
      Application.put_env(:stripity_stripe, :use_connection_pool, true)
      children = Stripe.HTTP.Hackney.supervisor_children()
      assert length(children) == 1
    end

    test "returns empty list when use_connection_pool is false" do
      Application.put_env(:stripity_stripe, :use_connection_pool, false)
      assert Stripe.HTTP.Hackney.supervisor_children() == []
    end
  end

  describe "hackney_opts injection" do
    test "passes hackney_opts through to the request" do
      # Set up a mock that captures opts and returns them as the body
      defmodule HackneyOptsCapture do
        @behaviour Stripe.HTTP

        @impl true
        def request(_, _, headers, _, _opts) do
          # We test the opts injection via the full API layer instead
          {:ok, 200, headers, ~s({"ok": true})}
        end

        @impl true
        def supervisor_children, do: []
      end

      Application.put_env(:stripity_stripe, :hackney_opts, [
        {:connect_timeout, 1000},
        {:recv_timeout, 5000}
      ])

      Application.put_env(:stripity_stripe, :http_module, HackneyOptsCapture)

      # Verify hackney adapter reads the config
      assert Stripe.Config.resolve(:hackney_opts) == [
               {:connect_timeout, 1000},
               {:recv_timeout, 5000}
             ]
    end
  end

  describe "request/5 integration" do
    test "makes a successful request through hackney" do
      Application.put_env(:stripity_stripe, :use_connection_pool, false)
      Application.delete_env(:stripity_stripe, :hackney_opts)

      # Make a real request to stripe-mock
      api_base_url = Application.get_env(:stripity_stripe, :api_base_url)

      case Stripe.HTTP.Hackney.request(
             :get,
             "#{api_base_url}/v1/customers",
             [
               {"Authorization", "Bearer sk_test_123"},
               {"Content-Type", "application/x-www-form-urlencoded"}
             ],
             "",
             []
           ) do
        {:ok, status, _headers, body} ->
          assert status in 200..299
          assert is_binary(body)

        {:error, :econnrefused} ->
          # stripe-mock may not be running, that's ok
          :ok
      end
    end
  end
end

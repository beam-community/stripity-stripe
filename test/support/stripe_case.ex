defmodule Stripe.StripeCase do
  @moduledoc """
  This module defines the setup for tests requiring access to a mocked version of Stripe.
  """

  use ExUnit.CaseTemplate

  def assert_stripe_requested(expected_method, path, extra \\ []) do
    expected_params = normalize_query(Keyword.get(extra, :query, %{}))
    expected_uri = URI.parse(stripe_base_url() <> path)
    expected_body = Keyword.get(extra, :body)
    expected_headers = Keyword.get(extra, :headers)

    assert_received(%Finch.Request{} = request)

    assert expected_method == normalize_method(request.method)
    assert expected_uri.scheme == to_string(request.scheme)
    assert expected_uri.host == request.host
    assert expected_uri.port == request.port
    assert expected_uri.path == request.path
    assert expected_params == normalize_query(request.query || "")

    assert_stripe_request_body(expected_body, request.body)
    assert_stripe_request_headers(expected_headers, request.headers)
  end

  defp normalize_method(method) do
    method |> String.downcase() |> String.to_existing_atom()
  end

  defp normalize_query(query) when is_binary(query) do
    query |> URI.query_decoder() |> Enum.into(%{})
  end

  defp normalize_query(query) when is_map(query) or is_list(query) do
    Map.new(query, fn {k, v} -> {to_string(k), to_string(v)} end)
  end

  def get_stripe_request_headers do
    assert_received(%Finch.Request{} = request)

    Map.new(request.headers)
  end

  def stripe_base_url do
    Application.get_env(:stripity_stripe, :api_base_url)
  end

  defp assert_stripe_request_headers(nil, _), do: nil

  defp assert_stripe_request_headers(expected_headers, headers) when is_list(expected_headers) do
    assert Enum.all?(expected_headers, &assert_stripe_request_headers(&1, headers))
  end

  defp assert_stripe_request_headers({expected_name, expected_value} = expected_header, headers) do
    assert {String.downcase(expected_name), expected_value} in headers,
           """
           Expected the header `#{inspect(expected_header)}` to be in the headers of the request.

           Headers:
           #{inspect(headers)}
           """
  end

  defp assert_stripe_request_body(nil, _), do: nil

  defp assert_stripe_request_body(expected_body, body) do
    assert body == Stripe.URI.encode_query(expected_body)
  end

  @doc false
  # Send message to the owning process for each request so we can assert that
  # the request was made.
  def send_request_to_test_process(_event, _measurements, %{request: request}, _config) do
    send(self(), request)
  end

  using do
    quote do
      import Stripe.StripeCase,
        only: [
          assert_stripe_requested: 2,
          assert_stripe_requested: 3,
          get_stripe_request_headers: 0,
          stripe_base_url: 0
        ]
    end
  end
end

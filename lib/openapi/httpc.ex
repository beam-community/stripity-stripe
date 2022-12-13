defmodule Stripe.HTTPClient.HTTPC do
  @moduledoc false
  @behaviour Stripe.HTTPClient

  @impl true
  def init() do
    {:ok, _} = Application.ensure_all_started(:inets)
    :ok
  end

  @impl true
  def request(:post = method, url, headers, body, opts) do
    headers = for {k, v} <- headers, do: {String.to_charlist(k), String.to_charlist(v)}
    request = {String.to_charlist(url), headers, ~C(application/x-www-form-urlencoded), body}

    do_request(method, request, opts)
  end

  def request(method, url, headers, _body, opts) do
    headers = for {k, v} <- headers, do: {String.to_charlist(k), String.to_charlist(v)}
    request = {String.to_charlist(url), headers}

    do_request(method, request, opts)
  end

  defp do_request(method, request, opts) do
    http_opts =
      [
        ssl: http_ssl_opts(),
        timeout: opts[:timeout] || 10_000
      ]
      |> Keyword.merge(opts)

    case :httpc.request(method, request, http_opts, body_format: :binary) do
      {:ok, {{_, status, _}, headers, body}} ->
        headers = for {k, v} <- headers, do: {List.to_string(k), List.to_string(v)}

        {:ok, %{status: status, headers: headers, body: body}}

      {:error, error} ->
        {:error, error}
    end
  end

  # Load SSL certificates

  crt_file = CAStore.file_path()
  crt = File.read!(crt_file)
  pems = :public_key.pem_decode(crt)
  ders = Enum.map(pems, fn {:Certificate, der, _} -> der end)

  @cacerts ders

  defp http_ssl_opts() do
    # Use secure options, see https://gist.github.com/jonatanklosko/5e20ca84127f6b31bbe3906498e1a1d7
    [
      verify: :verify_peer,
      cacerts: @cacerts,
      customize_hostname_check: [
        match_fun: :public_key.pkix_verify_hostname_match_fun(:https)
      ]
    ]
  end
end

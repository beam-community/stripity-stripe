if Code.ensure_loaded?(Req) do
  defmodule Stripe.HTTPClient.Req do
    @moduledoc """
    A `Stripe.HTTPClient` backed by [Req](https://hex.pm/packages/req).

    To use it, add `:req` to your dependencies and select it in your config:

        config :stripity_stripe, http_client: Stripe.HTTPClient.Req

    ## Configuration

      * `:req_opts` – options added to every request, e.g. timeouts:

            config :stripity_stripe, req_opts: [receive_timeout: 5000, connect_options: [timeout: 1000]]

      * `:use_connection_pool` and `:pool_options` – see "HTTP Connection Pool" in `Stripe`. The
        pool is a Finch pool named `Stripe.Finch`: `:max_connections` sets its `:size` and
        `:timeout` sets its `:conn_max_idle_time`. Req doesn't allow `:connect_options` with a
        named pool, so when `:connect_options` or `:finch` is given, Req picks the pool instead.
        With `use_connection_pool: false`, Req's default pool is used.

    Options passed to individual `Stripe` calls that `Stripe.API` doesn't handle are passed on
    to Req, so they must be valid Req options.

    `Stripe.API` retries requests itself (see the `:retries` config), so Req's `:retry` and
    `:redirect` are off by default. Response bodies are always returned undecoded.
    """

    @behaviour Stripe.HTTPClient

    alias Stripe.Config

    @pool_name Stripe.Finch
    @default_options [retry: false, redirect: false]

    @impl Stripe.HTTPClient
    def request(method, url, headers, body, opts) do
      @default_options
      |> Keyword.merge(Config.resolve(:req_opts) || [])
      |> Req.new()
      |> Req.merge(opts)
      |> Req.merge([method: method, url: url, headers: headers, raw: true] ++ body_options(body))
      |> add_pool_option()
      |> Req.request()
      |> handle_response()
    end

    @impl Stripe.HTTPClient
    def supervisor_children do
      if use_pool?() do
        [{Finch, name: @pool_name, pools: %{default: pool_options()}}]
      else
        []
      end
    end

    @spec use_pool?() :: boolean
    defp use_pool? do
      Config.resolve(:use_connection_pool)
    end

    # Translates the `:pool_options` documented in `Stripe` to Finch's pool options.
    @spec pool_options() :: Keyword.t()
    defp pool_options do
      options = Config.resolve(:pool_options) || []

      Enum.reject(
        [size: options[:max_connections], conn_max_idle_time: options[:timeout]],
        fn {_key, value} -> is_nil(value) end
      )
    end

    defp add_pool_option(request) do
      if use_pool?() and not Map.has_key?(request.options, :finch) and
           not Map.has_key?(request.options, :connect_options) do
        Req.merge(request, finch: [name: @pool_name])
      else
        request
      end
    end

    # Req sets the multipart Content-Type itself, including the boundary.
    defp body_options({:multipart, parts}), do: [form_multipart: Enum.map(parts, &multipart_part/1)]
    defp body_options(body), do: [body: body]

    defp multipart_part({:file, path}), do: {"file", File.stream!(path)}
    defp multipart_part({name, value}), do: {name, value}

    defp handle_response({:ok, %Req.Response{status: status, body: body} = response}) do
      {:ok, status, Req.get_headers_list(response), body}
    end

    # Unwrap errors so `Stripe.API` sees the same reasons hackney returns (e.g. `:timeout`).
    defp handle_response({:error, %Req.TransportError{reason: reason}}), do: {:error, reason}
    defp handle_response({:error, %Req.HTTPError{reason: reason}}), do: {:error, reason}
    defp handle_response({:error, exception}), do: {:error, exception}
  end
end

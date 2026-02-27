if Code.ensure_loaded?(:hackney) do
  defmodule Stripe.HTTP.Hackney do
    @moduledoc """
    HTTP adapter for `:hackney`.

    This is the default adapter when hackney is available as a dependency.

    ## Configuration

    The following application config keys are specific to this adapter:

      * `:hackney_opts` — extra options passed directly to `:hackney.request/5`
      * `:use_connection_pool` — whether to use a supervised connection pool (default `true`)
      * `:pool_options` — pool configuration (`:timeout`, `:max_connections`)
    """

    @behaviour Stripe.HTTP

    @pool_name Stripe.API

    @impl true
    def request(method, url, headers, body, opts) do
      opts =
        opts
        |> add_default_options()
        |> add_pool_option()
        |> add_options_from_config()

      case :hackney.request(method, url, headers, body, opts) do
        {:ok, status, resp_headers, body} ->
          {:ok, status, resp_headers, decompress_body(body, resp_headers)}

        {:error, _reason} = error ->
          error
      end
    end

    @impl true
    def supervisor_children do
      if use_pool?() do
        [:hackney_pool.child_spec(@pool_name, get_pool_options())]
      else
        []
      end
    end

    defp add_default_options(opts) do
      [:with_body | opts]
    end

    defp add_pool_option(opts) do
      if use_pool?() do
        [{:pool, @pool_name} | opts]
      else
        opts
      end
    end

    defp add_options_from_config(opts) do
      case Stripe.Config.resolve(:hackney_opts) do
        hackney_opts when is_list(hackney_opts) -> opts ++ hackney_opts
        _ -> opts
      end
    end

    defp use_pool? do
      Stripe.Config.resolve(:use_connection_pool)
    end

    defp get_pool_options do
      Stripe.Config.resolve(:pool_options)
    end

    defp decompress_body(body, headers) do
      content_encoding =
        Enum.find_value(headers, fn
          {key, value} ->
            if String.downcase(key) == "content-encoding", do: String.downcase(value)

          _ ->
            nil
        end)

      case content_encoding do
        "gzip" -> :zlib.gunzip(body)
        "deflate" -> :zlib.unzip(body)
        _ -> body
      end
    end
  end
end

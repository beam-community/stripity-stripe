if Code.ensure_loaded?(Req) do
  defmodule Stripe.HTTP.Req do
    @moduledoc """
    HTTP adapter for `Req`.

    Uses Req (which is backed by Finch) as the HTTP client. Req handles
    connection pooling and decompression automatically.

    ## Configuration

    Add `{:req, "~> 0.5"}` to your mix.exs dependencies. No additional
    stripity_stripe configuration is needed — Req manages its own pool.
    """

    @behaviour Stripe.HTTP

    @impl true
    def request(method, url, headers, body, _opts) do
      {req_body_opts, req_headers} = build_body_and_headers(body, headers)

      req =
        Req.new(
          method: method,
          url: url,
          headers: req_headers,
          # Disable automatic JSON decoding — Stripe.API handles that
          decode_body: false,
          # Disable retry — Stripe.API has its own retry logic
          retry: false
        )
        |> Map.update!(:options, &Map.merge(&1, req_body_opts))

      case Req.request(req) do
        {:ok, %{status: status, headers: resp_headers, body: resp_body}} ->
          {:ok, status, flatten_headers(resp_headers), resp_body}

        {:error, %{__struct__: _, reason: reason}} ->
          {:error, reason}

        {:error, reason} ->
          {:error, reason}
      end
    end

    @impl true
    def supervisor_children do
      []
    end

    defp build_body_and_headers({:multipart, parts}, headers) do
      multipart =
        Enum.map(parts, fn
          {:file, content, disposition, extra_headers} ->
            # hackney-style file part: {:file, content, {"form-data", [name: ..., filename: ...]}, []}
            {_form_data, params} = disposition
            name = Keyword.get(params, :name, "file")
            filename = Keyword.get(params, :filename, "upload")

            content_type =
              Enum.find_value(extra_headers, "application/octet-stream", fn
                {"Content-Type", ct} -> ct
                {"content-type", ct} -> ct
                _ -> nil
              end)

            {name, {content, filename: filename, content_type: content_type}}

          {name, value} when is_binary(name) and is_binary(value) ->
            {name, value}

          {name, value} ->
            {to_string(name), to_string(value)}
        end)

      # Remove Content-Type — Req sets its own multipart boundary
      filtered_headers =
        Enum.reject(headers, fn {key, _val} ->
          String.downcase(key) == "content-type"
        end)

      {%{form_multipart: multipart}, filtered_headers}
    end

    defp build_body_and_headers(body, headers) do
      {%{body: body}, headers}
    end

    defp flatten_headers(headers) when is_map(headers) do
      Enum.flat_map(headers, fn {name, values} ->
        Enum.map(List.wrap(values), fn value -> {name, value} end)
      end)
    end

    defp flatten_headers(headers) when is_list(headers) do
      headers
    end
  end
end

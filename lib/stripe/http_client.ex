defmodule Stripe.HTTPClient do
  @moduledoc """
  Behaviour for the HTTP client used to send requests to the Stripe API.

  Two clients are bundled:

    * `Stripe.HTTPClient.Hackney` – the default, backed by `:hackney`.
    * `Stripe.HTTPClient.Req` – backed by [Req](https://hex.pm/packages/req). Available when
      `:req` is in your dependencies.

  Select a client in your config:

      config :stripity_stripe, http_client: Stripe.HTTPClient.Req

  `Stripe.API` builds the URL, headers and body, and handles retries, telemetry, response
  decompression and JSON decoding. A client only sends the request and reports what came back.

  ## Implementing a client

  `c:request/5` receives:

    * `method` – one of `:get`, `:post`, `:put`, `:delete` or `:patch`.
    * `url` – the full URL, including the query string.
    * `headers` – a list of `{name, value}` string pairs.
    * `body` – either iodata, or `{:multipart, parts}` for file uploads, where each part is
      `{:file, path}` (a file to read from disk and send as the `"file"` field) or
      `{name, value}`.
    * `opts` – any options passed to the `Stripe` function that `Stripe.API` doesn't handle
      itself (it handles `:api_key`, `:api_version`, `:connect_account`, `:expand` and
      `:idempotency_key`). Clients typically merge these into their own request options.

  It must return `{:ok, status, headers, body}` for any HTTP response, including 4xx and 5xx,
  without decompressing the body, or `{:error, reason}` when no response was received.
  `Stripe.API` retries on the reasons `:timeout`, `:connect_timeout` and `:econnrefused`, so a
  client should return those atoms for the matching failures.

  `c:supervisor_children/0` is optional. It returns any processes the client needs, such as a
  connection pool, and they are started under the `Stripe` application's supervisor.
  """

  @type method :: :get | :post | :put | :delete | :patch
  @type headers :: [{String.t(), String.t()}]
  @type multipart_part :: {:file, Path.t()} | {String.t(), iodata()}
  @type body :: iodata() | {:multipart, [multipart_part]}
  @type response :: {:ok, status :: pos_integer, headers, body :: binary} | {:error, reason :: term}

  @callback request(method, url :: String.t(), headers, body, opts :: Keyword.t()) :: response

  @callback supervisor_children() :: [Supervisor.child_spec() | {module, term} | module]

  @optional_callbacks supervisor_children: 0
end

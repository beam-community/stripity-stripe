defmodule Stripe.API do
  @moduledoc """
  Low-level utilities for interacting with the Stripe API.

  Usually the utilities in `Stripe.Request` are a better way to write custom interactions with
  the API.
  """
  alias Stripe.Error

  @callback oauth_request(method, String.t(), map) :: {:ok, map}

  @type method :: :get | :post | :put | :delete | :patch
  @type headers :: %{String.t() => String.t()} | %{}
  @type body :: iodata() | {:multipart, list()}
  @typep http_success :: {:ok, integer, [{String.t(), String.t()}], String.t()}
  @typep http_failure :: {:error, term}

  @pool_name __MODULE__
  @api_version "2018-08-23"
  @idempotency_key_header "Idempotency-Key"

  @default_max_attempts 3
  @default_base_backoff 500
  @default_max_backoff 2_000

  def supervisor_children do
    if use_pool?() do
      [:hackney_pool.child_spec(@pool_name, get_pool_options())]
    else
      []
    end
  end

  @spec get_pool_options() :: Keyword.t()
  defp get_pool_options() do
    Application.get_env(:stripity_stripe, :pool_options)
  end

  @spec get_base_url() :: String.t()
  defp get_base_url() do
    Application.get_env(:stripity_stripe, :api_base_url)
  end

  @spec get_upload_url() :: String.t()
  defp get_upload_url() do
    Application.get_env(:stripity_stripe, :api_upload_url)
  end

  @spec get_default_api_key() :: String.t()
  defp get_default_api_key() do
    case Application.get_env(:stripity_stripe, :api_key) do
      nil ->
        # use an empty string and let Stripe produce an error
        ""

      key ->
        key
    end
  end

  @spec use_pool?() :: boolean
  defp use_pool?() do
    Application.get_env(:stripity_stripe, :use_connection_pool)
  end

  @spec get_http_module() :: module
  defp get_http_module() do
    Application.get_env(:stripity_stripe, :http_module) || :hackney
  end

  @spec get_retry_config() :: Keyword.t
  defp get_retry_config() do
    Application.get_env(:stripity_stripe, :retries) || []
  end

  @spec add_common_headers(headers) :: headers
  defp add_common_headers(existing_headers) do
    Map.merge(existing_headers, %{
      "Accept" => "application/json; charset=utf8",
      "Accept-Encoding" => "gzip",
      "Connection" => "keep-alive",
      "User-Agent" => "Stripe/v1 stripity-stripe/#{@api_version}",
      "Stripe-Version" => @api_version
    })
  end

  @spec add_default_headers(headers) :: headers
  defp add_default_headers(existing_headers) do
    existing_headers = add_common_headers(existing_headers)

    case Map.has_key?(existing_headers, "Content-Type") do
      false -> existing_headers |> Map.put("Content-Type", "application/x-www-form-urlencoded")
      true -> existing_headers
    end
  end

  @spec add_idempotency_headers(headers, method) :: headers
  defp add_idempotency_headers(existing_headers, method) when method in [:get, :head] do
    existing_headers
  end
  defp add_idempotency_headers(existing_headers, _method) do
    existing_headers
    |> Map.put(@idempotency_key_header, generate_idempotency_key())
  end

  @spec add_multipart_form_headers(headers) :: headers
  defp add_multipart_form_headers(existing_headers) do
    existing_headers
    |> Map.put("Content-Type", "multipart/form-data")
  end

  @spec add_auth_header(headers, String.t() | nil) :: headers
  defp add_auth_header(existing_headers, api_key) do
    api_key = fetch_api_key(api_key)
    Map.put(existing_headers, "Authorization", "Bearer #{api_key}")
  end

  @spec fetch_api_key(String.t() | nil) :: String.t()
  defp fetch_api_key(api_key) do
    case api_key do
      key when is_binary(key) -> key
      _ -> get_default_api_key()
    end
  end

  @spec add_connect_header(headers, String.t() | nil) :: headers
  defp add_connect_header(existing_headers, nil), do: existing_headers

  defp add_connect_header(existing_headers, account_id) do
    Map.put(existing_headers, "Stripe-Account", account_id)
  end

  @spec add_default_options(list) :: list
  defp add_default_options(opts) do
    [:with_body | opts]
  end

  @spec add_pool_option(list) :: list
  defp add_pool_option(opts) do
    if use_pool?() do
      [{:pool, @pool_name} | opts]
    else
      opts
    end
  end

  @doc """
  A low level utility function to make a direct request to the Stripe API

  ## Connect Accounts

  If you'd like to make a request on behalf of another Stripe account
  utilizing the Connect program, you can pass the other Stripe account's
  ID to the request function as follows:

      request(%{}, :get, "/customers", %{}, connect_account: "acc_134151")

  """
  @spec request(body, method, String.t(), headers, list) ::
          {:ok, map} | {:error, Stripe.Error.t()}
  def request(body, :get, endpoint, headers, opts) do
    {expansion, opts} = Keyword.pop(opts, :expand)
    base_url = get_base_url()

    req_url =
      body
      |> Stripe.Util.map_keys_to_atoms()
      |> add_object_expansion(expansion)
      |> Stripe.URI.encode_query()
      |> prepend_url("#{base_url}#{endpoint}")

    perform_request(req_url, :get, "", headers, opts)
  end

  def request(body, method, endpoint, headers, opts) do
    {expansion, opts} = Keyword.pop(opts, :expand)
    base_url = get_base_url()

    req_url = add_object_expansion("#{base_url}#{endpoint}", expansion)

    req_body =
      body
      |> Stripe.Util.map_keys_to_atoms()
      |> Stripe.URI.encode_query()

    perform_request(req_url, method, req_body, headers, opts)
  end

  @doc """
  A low level utility function to make a direct request to the files Stripe API
  """
  @spec request_file_upload(body, method, String.t(), headers, list) ::
          {:ok, map} | {:error, Stripe.Error.t()}
  def request_file_upload(body, :post, endpoint, headers, opts) do
    base_url = get_upload_url()
    req_url = base_url <> endpoint

    req_headers =
      headers
      |> add_multipart_form_headers()

    parts =
      body
      |> Enum.map(fn {key, value} ->
        {Stripe.Util.multipart_key(key), value}
      end)

    perform_request(req_url, :post, {:multipart, parts}, req_headers, opts)
  end

  def request_file_upload(body, method, endpoint, headers, opts) do
    base_url = get_upload_url()
    req_url = base_url <> endpoint

    req_body =
      body
      |> Stripe.Util.map_keys_to_atoms()
      |> Stripe.URI.encode_query()

    perform_request(req_url, method, req_body, headers, opts)
  end

  @doc """
  A low level utility function to make an OAuth request to the Stripe API
  """
  @spec oauth_request(method, String.t(), map) :: {:ok, map} | {:error, Stripe.Error.t()}
  def oauth_request(method, endpoint, body) do
    base_url = "https://connect.stripe.com/oauth/"
    req_url = base_url <> endpoint
    req_body = Stripe.URI.encode_query(body)

    do_perform_request(req_url, method, req_body, %{}, [])
  end

  @doc """
  A low level utility function to generate a new idempotency key for
  `#{@idempotency_key_header}` request header value.
  """
  @spec generate_idempotency_key() :: binary
  def generate_idempotency_key do
    binary = <<
      System.system_time(:nanosecond)::64,
      :erlang.phash2({node(), self()}, 16_777_216)::24,
      System.unique_integer([:positive])::32
    >>

    Base.hex_encode32(binary, case: :lower, padding: false)
  end

  @doc """
  Checks if an error is a problem that we should retry on. This includes both
  socket errors that may represent an intermittent problem and some special
  HTTP statuses.
  """
  @spec should_retry?(http_success | http_failure, attempts :: non_neg_integer, config :: Keyword.t) :: boolean

  def should_retry?(response, attempts \\ 0, config \\ []) do
    max_attempts = Keyword.get(config, :max_attempts) || @default_max_attempts

    if attempts >= max_attempts do
      false
    else
      retry_response?(response)
    end
  end

  @spec retry_response?(http_success | http_failure) :: boolean
  # 409 conflict
  defp retry_response?({:ok, 409, _headers, _body}), do: true
  # Destination refused the connection, the connection was reset, or a
  # variety of other connection failures. This could occur from a single
  # saturated server, so retry in case it's intermittent.
  defp retry_response?({:error, :econnrefused}), do: true
  # Retry on timeout-related problems (either on open or read).
  defp retry_response?({:error, :connect_timeout}), do: true
  defp retry_response?({:error, :timeout}), do: true
  defp retry_response?(_response), do: false

  @doc """
  Returns backoff in milliseconds.
  """
  @spec backoff(attempts :: non_neg_integer, config :: Keyword.t()) :: non_neg_integer
  def backoff(attempts, config) do
    base_backoff = Keyword.get(config, :base_backoff) || @default_base_backoff
    max_backoff = Keyword.get(config, :max_backoff) || @default_max_backoff

    (base_backoff * :math.pow(2, attempts))
    |> min(max_backoff)
    |> backoff_jitter()
    |> max(base_backoff)
    |> trunc
  end

  @spec backoff_jitter(float) :: float
  defp backoff_jitter(n) do
    # Apply some jitter by randomizing the value in the range of (n / 2) to n
    n * (0.5 * (1 + :rand.uniform()))
  end

  @spec perform_request(String.t(), method, body, headers, list) ::
        {:ok, map} | {:error, Stripe.Error.t()}
  defp perform_request(req_url, method, body, headers, opts) do
    {connect_account_id, opts} = Keyword.pop(opts, :connect_account)
    {api_key, opts} = Keyword.pop(opts, :api_key)

    req_headers =
      headers
      |> add_auth_header(api_key)
      |> add_connect_header(connect_account_id)

    do_perform_request(req_url, method, body, req_headers, opts)
  end

  @spec do_perform_request(String.t(), method, body, headers, list) ::
          {:ok, map}
          | {:error, Stripe.Error.t()}
  defp do_perform_request(req_url, method, body, headers, opts) do
    req_headers =
      headers
      |> add_default_headers()
      |> add_idempotency_headers(method)
      |> Map.to_list()

    req_opts =
      opts
      |> add_default_options()
      |> add_pool_option()

    do_perform_request_and_retry(req_url, method, body, req_headers, req_opts, {:attempts, 0})
  end

  @spec do_perform_request_and_retry(
          String.t(),
          method,
          body,
          headers,
          list,
          {:attempts, non_neg_integer} | {:response, http_success | http_failure}
        ) ::
          {:ok, map}
          | {:error, Stripe.Error.t()}
  defp do_perform_request_and_retry(
         _req_url,
         _method,
         _body,
         _headers,
         _opts,
         {:response, response}
       ) do
    handle_response(response)
  end

  defp do_perform_request_and_retry(req_url, method, body, headers, opts, {:attempts, attempts}) do
    response = get_http_module().request(method, req_url, headers, body, opts)

    do_perform_request_and_retry(
      req_url,
      method,
      body,
      headers,
      opts,
      add_attempts(response, attempts, get_retry_config())
    )
  end

  @spec add_attempts(http_success | http_failure, non_neg_integer, Keyword.t()) ::
          {:attempts, non_neg_integer} | {:response, http_success | http_failure}
  defp add_attempts(response, attempts, retry_config) do
    if should_retry?(response, attempts, retry_config) do
      attempts
      |> backoff(retry_config)
      |> :timer.sleep()

      {:attempts, attempts + 1}
    else
      {:response, response}
    end
  end

  @spec handle_response(http_success | http_failure) :: {:ok, map} | {:error, Stripe.Error.t()}
  defp handle_response({:ok, status, headers, body}) when status >= 200 and status <= 299 do
    decoded_body =
      body
      |> decompress_body(headers)
      |> Poison.decode!()

    {:ok, decoded_body}
  end

  defp handle_response({:ok, status, headers, body}) when status >= 300 and status <= 599 do
    request_id = headers |> List.keyfind("Request-Id", 0)

    error =
      case Poison.decode(body) do
        {:ok, %{"error_description" => _} = api_error} ->
          Error.from_stripe_error(status, api_error, request_id)

        {:ok, %{"error" => api_error}} ->
          Error.from_stripe_error(status, api_error, request_id)

        {:error, _} ->
          # e.g. if the body is empty
          Error.from_stripe_error(status, nil, request_id)
      end

    {:error, error}
  end

  defp handle_response({:error, reason}) do
    error = Error.from_hackney_error(reason)
    {:error, error}
  end

  defp decompress_body(body, headers) do
    headers_dict = :hackney_headers.new(headers)

    case :hackney_headers.get_value("Content-Encoding", headers_dict) do
      "gzip" -> :zlib.gunzip(body)
      "deflate" -> :zlib.unzip(body)
      _ -> body
    end
  end

  defp prepend_url("", url), do: url
  defp prepend_url(query, url), do: "#{url}?#{query}"

  defp add_object_expansion(query, expansion) when is_map(query) and is_list(expansion) do
    query |> Map.put(:expand, expansion)
  end

  defp add_object_expansion(url, expansion) when is_list(expansion) do
    expansion
    |> Enum.map(&"expand[]=#{&1}")
    |> Enum.join("&")
    |> prepend_url(url)
  end

  defp add_object_expansion(url, _), do: url
end

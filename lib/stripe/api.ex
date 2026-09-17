defmodule Stripe.API do
  @moduledoc """
  Low-level utilities for interacting with the Stripe API.

  Usually the utilities in `Stripe.Request` are a better way to write custom interactions with
  the API.
  """
  alias Stripe.API
  alias Stripe.{Config, Error}

  @api_version "2025-11-17.clover"
  @oauth_base_url "https://connect.stripe.com/oauth/"

  @type method :: :get | :post | :put | :delete | :patch
  @type headers :: %{String.t() => String.t()} | %{}

  @doc """
  A low level utility function to make a direct request to the Stripe API

  ## Setting the api key

      request(%{}, :get, "/customers", %{}, api_key: "bogus key")

  ## Setting api version

  The api version defaults to #{@api_version} but a custom version can be passed
  in as follows:

      request(%{}, :get, "/customers", %{}, api_version: "2018-11-04")

  ## Connect Accounts

  If you'd like to make a request on behalf of another Stripe account
  utilizing the Connect program, you can pass the other Stripe account's
  ID to the request function as follows:

      request(%{}, :get, "/customers", %{}, connect_account: "acc_134151")

  """
  @spec request(map, method, String.t(), headers, list) ::
          {:ok, map} | {:error, Stripe.Error.t()}
  def request(body, :get, endpoint, headers, opts) do
    opts
    |> client()
    |> Req.request(
      method: :get,
      base_url: Config.resolve(:api_base_url),
      url: endpoint,
      headers: headers,
      params: body
    )
    |> handle_response()
  end

  def request(body, method, endpoint, headers, opts) do
    opts
    |> client()
    |> Req.request(
      method: method,
      base_url: Config.resolve(:api_base_url),
      url: endpoint,
      headers: headers,
      form: body
    )
    |> handle_response()
  end

  @doc """
  A low level utility function to make a direct request to the files Stripe API
  """
  @spec request_file_upload(map, method, String.t(), headers, list) ::
          {:ok, map} | {:error, Stripe.Error.t()}
  def request_file_upload(body, :post, endpoint, headers, opts) do
    parts =
      case body do
        %{file: path} when is_binary(path) -> %{body | file: File.stream!(path)}
        body -> body
      end

    opts
    |> client()
    |> Req.request(
      method: :post,
      base_url: Config.resolve(:api_upload_url),
      url: endpoint,
      headers: headers,
      form_multipart: parts
    )
    |> handle_response()
  end

  def request_file_upload(body, method, endpoint, headers, opts) do
    opts
    |> client()
    |> Req.request(
      method: method,
      base_url: Config.resolve(:api_upload_url),
      url: endpoint,
      headers: headers,
      form: body
    )
    |> handle_response()
  end

  @doc """
  A low level utility function to make an OAuth request to the Stripe API
  """
  @spec oauth_request(method, String.t(), map, String.t() | nil) ::
          {:ok, map} | {:error, Stripe.Error.t()}
  def oauth_request(method, endpoint, body, api_key \\ nil, opts \\ [])

  # `deauthorize` authenticates with the API key, every other endpoint carries
  # the `client_secret` in the body instead.
  def oauth_request(method, "deauthorize" = endpoint, body, api_key, opts) do
    opts
    |> client()
    |> Req.Request.put_option(:api_key, api_key)
    |> Req.request(method: method, base_url: @oauth_base_url, url: endpoint, form: body)
    |> handle_response()
  end

  def oauth_request(method, endpoint, body, _api_key, opts) do
    opts
    |> client()
    |> Req.Request.put_option(:api_key, false)
    |> Req.request(method: method, base_url: @oauth_base_url, url: endpoint, form: body)
    |> handle_response()
  end

  defp client(opts) do
    [compressed: true]
    |> Req.new()
    |> Req.merge(Config.resolve(:req_options, []))
    |> Req.merge(Keyword.take(opts, [:plug]))
    |> API.APIKey.attach()
    |> API.APIVersion.attach()
    |> API.ConnectAccount.attach()
    |> API.Params.attach()
    |> API.Expand.attach()
    |> API.IdempotencyKey.attach()
    |> API.ErrorHandler.attach()
    |> API.Telemetry.attach()
    |> Req.Request.merge_options(opts)
  end

  defp handle_response({:ok, %Req.Response{body: body}}), do: {:ok, body}
  defp handle_response({:error, %Error{} = error}), do: {:error, error}
end

defmodule Stripe do
  @moduledoc """
    A HTTP client for Stripe.
    This module contains the Application that you can use to perform
    transactions on stripe API.
    ### Configuring
    By default the STRIPE_SECRET_KEY environment variable is used to find
    your API key for Stripe. You can also manually set your API key by
    configuring the :stripity_stripe application. You can see the default
    configuration in the default_config/0 private function at the bottom of
    this file. The value for platform client id is optional.

      config :stripity_stripe, secret_key: YOUR_STRIPE_KEY
      config :stripity_stripe, platform_client_id: STRIPE_PLATFORM_CLIENT_ID
  """

  # Let's build on top of HTTPoison
  use HTTPoison.Base

  defmodule MissingSecretKeyError do
    defexception message: """
      The secret_key setting is required so that we can report the
      correct environment instance to Stripe. Please configure
      secret_key in your config.exs and environment specific config files
      to have accurate reporting of errors.
      config :stripity_stripe, secret_key: YOUR_SECRET_KEY
    """
  end


  @doc """
  Grabs STRIPE_SECRET_KEY from system ENV
  Returns binary
  """
  def config_or_env_key do
    require_stripe_key()
  end

  @doc """
  Grabs STRIPE_PLATFORM_CLIENT_ID from system ENV
  Returns binary
  """
  def config_or_env_platform_client_id do
    Application.get_env(:stripity_stripe, :platform_client_id) || System.get_env "STRIPE_PLATFORM_CLIENT_ID"
  end

  @doc """
  Creates the URL for our endpoint.
  Args:
    * endpoint - part of the API we're hitting
  Returns string
  """
  def process_url(endpoint) do
    "https://api.stripe.com/v1/" <> endpoint
  end

  @doc """
  Set our request headers for every request.
  """
  def req_headers(key) do
    Map.new
      |> Map.put("Authorization", "Bearer #{key}")
      |> Map.put("User-Agent",    "Stripe/v1 stripity-stripe/1.4.0")
      |> Map.put("Content-Type",  "application/x-www-form-urlencoded")
  end

  @doc """
  Converts the binary keys in our response to atoms.
  Args:
    * body - string binary response
  Returns Record or ArgumentError
  """
  def process_response_body(body) do
    Poison.decode! body
  end

  @doc """
  Boilerplate code to make requests with a given key.
  Args:
    * method - request method
    * endpoint - string requested API endpoint
    * key - stripe key passed to the api
    * body - request body
    * headers - request headers
    * options - request options
  Returns tuple
  """
  def make_request_with_key( method, endpoint, key, body \\ %{}, headers \\ %{}, options \\ []) do
    rb = Stripe.URI.encode_query(body)
    rh = req_headers(key)
        |> Map.merge(headers)
        |> Map.to_list

    options = Keyword.merge(httpoison_request_options(), options)
    {:ok, response} = request(method, endpoint, rb, rh, options)
    response.body
  end

  @doc """
  Boilerplate code to make requests with the key read from config or env.see config_or_env_key/0
  Args:
  * method - request method
  * endpoint - string requested API endpoint
  * key - stripe key passed to the api
  * body - request body
  * headers - request headers
  * options - request options
  Returns tuple
  """
  def make_request(method, endpoint, body \\ %{}, headers \\ %{}, options \\ []) do
    make_request_with_key( method, endpoint, config_or_env_key(), body, headers, options )
  end

  @doc """
  """
  def make_oauth_token_callback_request(body) do
    rb = Stripe.URI.encode_query(body)
    rh = req_headers(Stripe.config_or_env_key)
      |> Map.to_list

    options = httpoison_request_options()
    HTTPoison.request(:post, "#{Stripe.Connect.base_url}oauth/token", rb, rh, options)
  end

  @doc """
  """
  def make_oauth_deauthorize_request(stripe_user_id) do
    rb = Stripe.URI.encode_query([
      stripe_user_id: stripe_user_id,
      client_id: Stripe.config_or_env_platform_client_id])
    rh = req_headers( Stripe.config_or_env_key)
      |> Map.to_list

    options = httpoison_request_options()
    HTTPoison.request(:post, "#{Stripe.Connect.base_url}oauth/deauthorize", rb, rh, options)
  end

  defp require_stripe_key do
    case Application.get_env(:stripity_stripe, :secret_key, System.get_env "STRIPE_SECRET_KEY") || :not_found do
      :not_found ->
        raise MissingSecretKeyError
      value -> value
    end
  end

  defp httpoison_request_options() do
    Application.get_env(:stripity_stripe, :httpoison_options, [])
  end
end

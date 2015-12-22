defmodule Stripe do
  @moduledoc """
  A HTTP client for Stripe.
  """

  # Let's build on top of HTTPoison
  use Application
  use HTTPoison.Base

  def start(_type, _args) do
    start #start HTTPoison.Base.start inherited from use statement 
    Stripe.Supervisor.start_link
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
    HashDict.new
      |> Dict.put("Authorization", "Bearer #{key}")
      |> Dict.put("User-Agent",    "Stripe/v1 stripe-elixir/0.1.0")
      |> Dict.put("Content-Type",  "application/x-www-form-urlencoded")
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
  Returns dict
  """
  def make_request_with_key( method, endpoint, key, body \\ [], headers \\ [], options \\ []) do
    rb = Stripe.URI.encode_query(body)
    rh = req_headers( key )
        |> Dict.merge(headers)
        |> Dict.to_list

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
  Returns dict
  """
  def make_request(method, endpoint, body \\ [], headers \\ [], options \\ []) do
    make_request_with_key( method, endpoint, config_or_env_key, body, headers, options )
  end


  def make_oauth_token_callback_request(body) do
    rb = Stripe.URI.encode_query(body)
    rh = req_headers( Stripe.config_or_env_key )
        |> Dict.to_list
        options = []
    HTTPoison.request(:post, "#{Stripe.Connect.base_url}oauth/token", rb, rh, options)
  end

  def make_oauth_deauthorize_request(stripe_user_id) do
    rb = Stripe.URI.encode_query([
      stripe_user_id: stripe_user_id,
      client_id: Stripe.config_or_env_platform_client_id])
    rh = req_headers( Stripe.config_or_env_key)
    |> Dict.to_list

    options = []
    HTTPoison.request(:post, "#{Stripe.Connect.base_url}oauth/deauthorize", rb, rh, options)
  end



  @doc """
  Grabs STRIPE_SECRET_KEY from system ENV
  Returns binary
  """
  def config_or_env_key do
    Application.get_env(:stripity_stripe, :secret_key) ||
      System.get_env "STRIPE_SECRET_KEY"
  end

  @doc """
  Grabs STRIPE_PLATFORM_CLIENT_ID from system ENV
  Returns binary
  """
  def config_or_env_platform_client_id do
    Application.get_env(:stripity_stripe, :platform_client_id) ||
      System.get_env "STRIPE_PLATFORM_CLIENT_ID"
  end
end

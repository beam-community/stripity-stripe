defmodule Stripe do
  @moduledoc """
  A HTTP client for Stripe.
  """

  # Let's build on top of HTTPoison
  use Application
  use HTTPoison.Base

  def start(_type, _args) do
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
  def req_headers do
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
  Boilerplate code to make requests.
  Args:
    * endpoint - string requested API endpoint
    * body - request body
  Returns dict
  """
  def make_request(method, endpoint, body \\ [], headers \\ [], options \\ []) do
    # rb = Enum.map(body, &url_encode_keyvalue(&1))
    #   |> Enum.join("&")
    rb = Stripe.URI.encode_query(body)
    rh = req_headers
      |> Dict.merge(headers)
      |> Dict.to_list


    {:ok, response} = case method do
      :get     -> get(     endpoint,     rh, options)
      :put     -> put(     endpoint, rb, rh, options)
      :head    -> head(    endpoint,     rh, options)
      :post    -> post(    endpoint, rb, rh, options)
      :patch   -> patch(   endpoint, rb, rh, options)
      :delete  -> delete(  endpoint,     rh, options)
      :options -> options( endpoint,     rh, options)
    end


    response.body
  end

  @doc """
  Grabs STRIPE_SECRET_KEY from system ENV
  Returns binary
  """
  def key do
    Application.get_env(:stripity_stripe, :secret_key) ||
      System.get_env "STRIPE_SECRET_KEY"
  end

  defp url_encode_keyvalue({k, v}) do
    key = Atom.to_string(k)
    "#{key}=#{v}"
  end
end

defmodule Stripe.OAuth do
  @doc """
  """
  @spec make_oauth_deauthorize_request(map) :: {:ok, map} | {:error, Exception.t}
  def make_oauth_token_callback_request(body) do
    endpoint = "oauth/token"

    Stripe.request(:post, endpoint, %{}, body, [])
  end

  @doc """
  """
  @spec make_oauth_deauthorize_request(String.t) :: {:ok, map} | {:error, Exception.t}
  def make_oauth_deauthorize_request(stripe_user_id) do
    endpoint = "oauth/deauthorize"
    body = %{
      stripe_user_id: stripe_user_id,
      client_id: Application.get_env(:stripity_stripe, :api_key)
    }

    Stripe.request(:post, endpoint, %{}, body, [])
  end
end

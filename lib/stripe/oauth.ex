defmodule Stripe.OAuth do
  @doc """
  """
  @spec token_callback_request(String.t) :: {:ok, map} | {:error, Exception.t}
  def token_callback_request(code) do
    endpoint = "token"

    body = %{
      client_secret: Application.get_env(:stripity_stripe, :api_key),
      code: code,
      grant_type: "authorization_code"
    }

    Stripe.oauth_request(:post, endpoint, body)
  end

  @doc """
  """
  @spec deauthorize_request(String.t) :: {:ok, map} | {:error, Exception.t}
  def deauthorize_request(stripe_user_id) do
    endpoint = "deauthorize"
    body = %{
      stripe_user_id: stripe_user_id,
      client_id: Application.get_env(:stripity_stripe, :api_key)
    }

    Stripe.oauth_request(:post, endpoint, body)
  end
end

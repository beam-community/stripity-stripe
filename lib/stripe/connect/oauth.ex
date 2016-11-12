defmodule Stripe.Connect.OAuth do
  @moduledoc """
  Helper module for Connect related features at Stripe.
  Through this API you can:
  - retrieve the oauth access token or the full response, using the code received from the oauth flow return

  (reference https://stripe.com/docs/connect/standalone-accounts)
  """

  alias Stripe.Util

  @client_id Application.get_env(:stripity_stripe, :connect_client_id)
  @client_secret Application.get_env(:stripity_stripe, :api_key)

  @authorize_url_base_body %{
    client_id: @client_id,
    response_type: "code",
    scope: "read_write"
  }

  defmodule AuthorizeResponse do
    defstruct [
      :access_token, :livemode, :refresh_token, :scope, :stripe_user_id,
      :stripe_publishable_key, :token_type
    ]
  end

  defmodule TokenResponse do
    defstruct [
      :access_token, :livemode, :refresh_token, :scope, :stripe_user_id,
      :stripe_publishable_key, :token_type
    ]
  end

  defmodule DeauthorizeResponse do
    defstruct [
      :stripe_user_id
    ]
  end

  @doc """
  Execute the oauth callback to Stripe using the code supplied in the request parameter of the oauth redirect at the end of the onboarding workflow.
# Example
```
{:ok, resp} = Stripe.Connect.token code
IO.inspect resp
%Stripe.Connect.OAuth.TokenResponse{
    token_type: "bearer",
    stripe_publishable_key: "PUBLISHABLE_KEY",
    scope: "read_write",
    livemode: false,
    stripe_user_id: "USER_ID",
    refresh_token: "REFRESH_TOKEN",
    access_token: "ACCESS_TOKEN"
}

```

  """
  @spec token(String.t) :: {:ok, map} | {:error, Exception.t}
  def token(code) do
    endpoint = "token"

    body = %{
      client_secret: @client_secret,
      code: code,
      grant_type: "authorization_code"
    }

    case Stripe.oauth_request(:post, endpoint, body) do
       {:ok, result} -> {:ok, Util.stripe_response_to_struct(%TokenResponse{}, result)}
       {:error, error} -> {:error, error}
     end
  end

  @doc """
  De-authorize an account with your connect entity. A kind of oauth reset which invalidates all tokens and requires the customer to re-establish the link using the onboarding workflow.
  # Example
  ```
  case Stripe.Connect.oauth_deauthorize stripe_user_id do
   {:ok, success} -> assert success == true
   {:error, msg} -> flunk msg
 end
  ```
  """
  @spec deauthorize(String.t) :: {:ok, map} | {:error, Exception.t}
  def deauthorize(stripe_user_id) do
    endpoint = "deauthorize"
    body = %{
      client_id: @client_id,
      stripe_user_id: stripe_user_id
    }

    case Stripe.oauth_request(:post, endpoint, body) do
      {:ok, result} -> {:ok, Util.stripe_response_to_struct(%DeauthorizeResponse{}, result)}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
  Generate the URL to start a Stripe workflow. You can pass in a
  CSRF token to be sent to Stripe, which they send you back at the end of the workflow to further secure the interaction. Make sure you verify this token yourself upon receipt of the callback.
  """
  @spec authorize_url(String.t) :: {:ok, map} | {:error, Exception.t}
  def authorize_url(csrf_token) do
    @authorize_url_base_body
    |> Map.put(:state, csrf_token)
    |> do_authorize_url()
  end

  @spec authorize_url :: {:ok, map} | {:error, Exception.t}
  def authorize_url, do: do_authorize_url(@authorize_url_base_body)

  @spec do_authorize_url(map) :: {:ok, map} | {:error, Exception.t}
  defp do_authorize_url(body) do
    base_url = "https://connect.stripe.com/oauth/authorize?"
    body = Stripe.URI.encode_query(body)
    base_url <> body
  end
end

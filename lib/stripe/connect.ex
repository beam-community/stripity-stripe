defmodule Stripe.Connect do
  require HashDict

  @moduledoc """
  Helper module for Connect related features at Stripe.
  Through this API you can:
  - retrieve the oauth access token or the full response, using the code received from the oauth flow return

  (reference https://stripe.com/docs/connect/standalone-accounts)
  """

  def base_url do
    "https://connect.stripe.com/"
  end


  @doc """
  Generate the URL to start a stripe workflow. You can pass in a
  crsf token to be sent to stripe, which they send you back at the end of the workflow to further secure the interaction. Make sure you verify this token yourself on reception of the workflow callback.
  """
  def generate_button_url( csrf_token ) do
    client_id = Stripe.config_or_env_platform_client_id
    url = base_url <> "oauth/authorize?response_type=code"
    url = url <> "&scope=read_write"
    url = url <> "&client_id=#{Stripe.config_or_env_platform_client_id}"

    if String.length(csrf_token) > 0 do
      url = url <> "&state=#{csrf_token}"
    end
    url
  end

  @doc """
  Execute the oauth callback to Stripe using the code supplied in the request parameter of the oauth redirect at the end of the onboarding workflow.
# Example
```
{:ok, resp} = Stripe.Connect.oauth_token_callback code
IO.inspect resp
%{
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
  def oauth_token_callback(code) do
    req = [
      client_secret: Stripe.config_or_env_key,
      code: code,
      grant_type: "authorization_code"
    ]

     case Stripe.make_oauth_token_callback_request req do
       {:ok, resp} ->
         case resp.status_code do
           200 ->
             {:ok, Stripe.Util.string_map_to_atoms Poison.decode!(resp.body)}
           _ -> {:error, Stripe.Util.string_map_to_atoms Poison.decode!(resp.body)}
         end
     end
  end

  @doc """
  Same as oauth_token_callback, but gives you back only the access token which you can then use with the rest of the API.
  ```
  {:ok, token} = Stripe.Connect.get_token code
  ```

  """
  def get_token(code) do
    case oauth_token_callback code do
      {:ok, resp} -> {:ok,resp["access_token"]}
      {:error, err} -> {:error, err}
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
  def oauth_deauthorize( stripe_user_id ) do
    {:ok, resp} = Stripe.make_oauth_deauthorize_request stripe_user_id
    body = Stripe.Util.string_map_to_atoms Poison.decode!( resp.body )

    case body[:stripe_user_id] == stripe_user_id do
        true -> {:ok, true}
        false -> {:error, body[:error_description]}  
    end
  end
end


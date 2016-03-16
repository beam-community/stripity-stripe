defmodule Stripe.StripeTest do
  use ExUnit.Case


  test "make_request_with_key fails when no key is supplied" do
    res = Stripe.make_request_with_key(
      :get,"plans?limit=0&include[]=total_count","")
            |> Stripe.Util.handle_stripe_response
    case res do
        {:error, err} -> assert String.contains? err["error"]["message"], "YOUR_SECRET_KEY"
        true -> assert false
    end
  end

  test "make_request_with_key works when valid key is supplied" do
    res = Stripe.make_request_with_key(
      :get,"plans?limit=0&include[]=total_count",Stripe.config_or_env_key)
        |> Stripe.Util.handle_stripe_response
    case res do
      {:ok, _} -> assert true
      {:error,err} -> flunk err
    end
  end
end

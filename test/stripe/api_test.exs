defmodule Stripe.APITest do
  use ExUnit.Case

  test "works with 301 responses without issue" do
    {:error, %Stripe.Error{extra: %{http_status: 301}}} =
      Stripe.API.request(%{}, :get, "/", %{}, [])
  end
end

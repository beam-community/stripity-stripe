defmodule Stripe.StripeCase do
  @moduledoc """
  This module defines the setup for tests requiring access to a mocked version of Stripe.
  """

  use ExUnit.CaseTemplate

  def assert_stripe_requested(_method, _url, _extra \\ []) do
    # TODO: use something akin to WebMock to check the API calls are correct
    assert true
  end

  def stripe_base_url() do
    Application.get_env(:stripity_stripe, :api_base_url)
  end

  using do
    quote do
      import Stripe.StripeCase, only: [assert_stripe_requested: 2, assert_stripe_requested: 3, stripe_base_url: 0]
    end
  end
end

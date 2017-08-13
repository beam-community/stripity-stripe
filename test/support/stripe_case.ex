defmodule Stripe.StripeCase do
  @moduledoc """
  This module defines the setup for tests requiring access to a mocked version of Stripe.
  """

  use ExUnit.CaseTemplate

  def assert_stripe_requested(_method, _url) do
    # TODO: use something akin to WebMock to check the API calls are correct
    assert true
  end

  def stripe_base_url() do
    Application.get_env(:stripity_stripe, :api_base_url)
  end

  def reset_stripe() do
    Stripe.StripeMock.reset()
    Process.sleep(250)
  end

  using do
    quote do
      import Stripe.StripeCase, only: [assert_stripe_requested: 2, stripe_base_url: 0, reset_stripe: 0]
    end
  end

  setup_all do
    reset_stripe()
  end

end

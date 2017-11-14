defmodule Stripe.Types do
  @moduledoc """
  A module that contains shared types matching Stripe schemas.
  """

  @type address :: %{
    city: String.t | nil,
    country: String.t | nil,
    line1: String.t | nil,
    line2: String.t | nil,
    postal_code: String.t | nil,
    state: String.t | nil
  }

  @type shipping :: %{
    address: Stripe.Types.address,
    carrier: String.t | nil,
    name: String.t,
    phone: String.t | nil,
    tracking_number: String.t | nil
  }
end

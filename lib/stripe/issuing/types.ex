defmodule Stripe.Issuing.Types do
  @moduledoc """
  A module that contains shared issuing types matching Stripe schemas.
  """

  @type authorization_controls :: %{
          allowed_categories: list() | nil,
          blocked_categories: list() | nil,
          spending_limits: list(spending_limits()) | nil,
          currency: String.t() | nil,
          max_amount: non_neg_integer | nil,
          max_approvals: non_neg_integer | nil
        }

  @type billing :: %{
          address: Stripe.Types.address(),
          name: String.t()
        }

  @type merchant_data :: %{
          category: String.t(),
          city: String.t(),
          country: String.t(),
          name: String.t(),
          network_id: String.t(),
          postal_code: String.t(),
          state: String.t()
        }

  @type spending_limits :: %{
          amount: non_neg_integer,
          categories: list(),
          interval: String.t()
        }
end

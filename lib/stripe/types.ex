defmodule Stripe.Types do
  @moduledoc """
  A module that contains shared types matching Stripe schemas.
  """

  @type address :: %{
          city: String.t() | nil,
          country: String.t() | nil,
          line1: String.t() | nil,
          line2: String.t() | nil,
          postal_code: String.t() | nil,
          state: String.t() | nil
        }

  @type authorization_controls :: %{
          allowed_categories: list() | nil,
          blocked_categories: list() | nil,
          spending_limits: list(Stripe.Types.spending_limits()) | nil,
          currency: String.t() | nil,
          max_amount: non_neg_integer | nil,
          max_approvals: non_neg_integer | nil
        }

  @type billing :: %{
          address: Stripe.Types.address(),
          name: String.t()
        }

  @type evidence :: %{
          fraudulent: Stripe.Types.evidence_detail() | nil,
          other: Stripe.Types.evidence_detail() | nil
        }

  @type evidence_detail :: %{
          dispute_explanation: String.t(),
          uncategorized_file: String.t()
        }

  @type fee :: %{
          amount: integer,
          application: String.t() | nil,
          currency: String.t(),
          description: String.t() | nil,
          type: String.t()
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

  @type metadata :: %{
          optional(String.t()) => String.t()
        }

  @type request_history :: %{
          approved: boolean,
          authorized_amount: integer,
          authorized_currency: String.t(),
          created: Stripe.timestamp(),
          held_amount: integer,
          held_currency: String.t(),
          reason: String.t()
        }

  @type shipping :: %{
          address: Stripe.Types.address(),
          carrier: String.t() | nil,
          eta: Stripe.timestamp() | nil,
          name: String.t(),
          phone: String.t() | nil,
          status: String.t() | nil,
          tracking_number: String.t() | nil,
          tracking_url: String.t() | nil
        }

  @type spending_limits :: %{
          amount: non_neg_integer,
          categories: list(),
          interval: String.t()
        }

  @type tax_info :: %{
          type: String.t(),
          tax_id: String.t() | nil
        }

  @type tax_info_verification :: %{
          status: String.t() | nil,
          verified_name: String.t() | nil
        }

  @type transfer_schedule :: %{
          delay_days: non_neg_integer,
          interval: String.t(),
          monthly_anchor: non_neg_integer | nil,
          weekly_anchor: String.t() | nil
        }

  @type verification_data :: %{
          address_line1_check: String.t(),
          address_zip_check: String.t(),
          cvc_check: String.t()
        }
end

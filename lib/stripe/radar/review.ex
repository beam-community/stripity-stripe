defmodule Stripe.Review do
  @moduledoc """
  Work with Stripe review objects.

  Stripe API reference: https://stripe.com/docs/api#reviews
  """

  use Stripe.Entity

  @type t :: %__MODULE__{
               id: Stripe.id,
               object: String.t,
               charge: Stripe.id | Stripe.Charge.t,
               created: Stripe.timestamp,
               livemode: boolean,
               open: boolean,
               reason: String.t
             }

  defstruct [
    :id,
    :object,
    :charge,
    :created,
    :livemode,
    :open,
    :reason
  ]
end

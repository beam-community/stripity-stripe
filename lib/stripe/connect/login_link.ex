defmodule Stripe.LoginLink do
  @moduledoc """

  """

  use Stripe.Entity

  @type t :: %__MODULE__{
               object: String.t,
               created: Stripe.timestamp,
               url: String.t
             }

  defstruct [
    :object,
    :created,
    :url
  ]
end

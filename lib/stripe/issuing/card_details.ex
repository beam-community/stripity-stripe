defmodule Stripe.Issuing.CardDetails do
  @moduledoc """
  Work with Stripe Issuing card details.

  You can:

  - Retrieve card details

  Stripe API reference: https://stripe.com/docs/api/issuing/cards/retrieve_details
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          card: Stripe.Issuing.Card.t(),
          object: String.t(),
          cvc: String.t(),
          exp_month: String.t(),
          exp_year: String.t(),
          number: String.t()
        }

  defstruct [
    :card,
    :object,
    :cvc,
    :exp_month,
    :exp_year,
    :number
  ]

  @plural_endpoint "issuing/cards"

  @doc """
  Retrieve card details.
  """
  @spec retrieve(Stripe.id() | Stripe.Issuing.Card.t(), Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}" <> "/details")
    |> put_method(:get)
    |> make_request()
  end
end

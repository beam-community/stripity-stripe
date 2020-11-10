defmodule Stripe.Checkout.Session.LineItems do
  @moduledoc false

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          amount_subtotal: non_neg_integer,
          amount_total: non_neg_integer,
          currency: String.t(),
          description: String.t(),
          price: Stripe.Price.t(),
          quantity: non_neg_integer
        }

  defstruct [
    :id,
    :object,
    :amount_subtotal,
    :amount_total,
    :currency,
    :description,
    :price,
    :quantity
  ]

  @plural_endpoint "checkout/sessions"

  @doc """
  List line items on a checkout session.
  """
  @spec list(Stripe.id(), Stripe.options()) ::
          {:ok, Stripe.List.t(t())} | {:error, Stripe.Error.t()}
  def list(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}/" <> "line_items")
    |> put_method(:get)
    |> make_request()
  end
end

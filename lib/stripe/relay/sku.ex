defmodule Stripe.SKU do
  @moduledoc """
  Work with Stripe SKU objects.

  Stripe API reference: https://stripe.com/docs/api#sku_object
  """

  use Stripe.Entity

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          active: boolean,
          attributes: %{
            optional(String.t()) => String.t()
          },
          created: Stripe.timestamp(),
          currency: String.t(),
          image: String.t(),
          inventory: %{
            quantity: non_neg_integer | nil,
            type: String.t(),
            value: String.t() | nil
          },
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          package_dimensions:
            %{
              height: float,
              length: float,
              weight: float,
              width: float
            }
            | nil,
          price: non_neg_integer,
          product: Stripe.id() | Stripe.Relay.Product.t(),
          updated: Stripe.timestamp()
        }

  defstruct [
    :id,
    :object,
    :active,
    :attributes,
    :created,
    :currency,
    :image,
    :inventory,
    :livemode,
    :metadata,
    :package_dimensions,
    :price,
    :product,
    :updated
  ]
end

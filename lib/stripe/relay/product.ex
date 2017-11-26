defmodule Stripe.Product do
  @moduledoc """
  Work with Stripe products.

  Stripe API reference: https://stripe.com/docs/api#products
  """

  use Stripe.Entity

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          active: boolean,
          attributes: %{
            optional(String.t()) => String.t()
          },
          caption: String.t(),
          created: Stripe.timestamp(),
          deactivate_on: [Stripe.id()],
          description: String.t(),
          images: [String.t()],
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          name: String.t(),
          package_dimensions:
            nil
            | %{
                height: float,
                length: float,
                weight: float,
                width: float
              },
          shippable: boolean,
          skus: Stripe.List.t(Stripe.SKU.t()),
          updated: Stripe.timestamp(),
          url: String.t()
        }

  defstruct [
    :id,
    :object,
    :active,
    :attributes,
    :caption,
    :created,
    :deactivate_on,
    :description,
    :images,
    :livemode,
    :metadata,
    :name,
    :package_dimensions,
    :shippable,
    :skus,
    :updated,
    :url
  ]
end

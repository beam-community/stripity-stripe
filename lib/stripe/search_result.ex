defmodule Stripe.SearchResult do
  @moduledoc """
  Work with Stripe search result objects.

  A search result is a object which holds one or more
  other Stripe objects in its "data" property. It's similar to Stripe.List
  """

  use Stripe.Entity

  @type value :: term

  @type t(value) :: %__MODULE__{
          object: String.t(),
          data: [value],
          has_more: boolean,
          total_count: integer | nil,
          url: String.t(),
          next_page: String.t()
        }

  defstruct [:object, :data, :has_more, :total_count, :url, :next_page]
end

defmodule Stripe.List do
  @moduledoc """
  Work with Stripe list objects.

  A list is a general-purpose Stripe object which holds one or more
  other Stripe objects in its "data" property.

  In its current iteration it simply allows serializing into a properly
  typed struct.

  In future iterations, it should:
  - Support multiple types of objects in its collection
  - Support fetching the next set of objects (pagination)
  """

  @type t :: %__MODULE__{}

  defstruct [:object, :data, :has_more, :total_count, :url]
end

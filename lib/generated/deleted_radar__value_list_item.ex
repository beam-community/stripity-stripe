defmodule Stripe.DeletedRadar.ValueListItem do
  use Stripe.Entity
  @moduledoc ""
  (
    defstruct [:deleted, :id, :object]

    @typedoc "The `deleted_radar.value_list_item` type.\n\n  * `deleted` Always true for a deleted object\n  * `id` Unique identifier for the object.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n"
    @type t :: %__MODULE__{deleted: boolean, id: binary, object: binary}
  )
end

defmodule Stripe.FinancialConnections.AccountOwner do
  use Stripe.Entity
  @moduledoc "Describes an owner of an account."
  (
    defstruct [:email, :id, :name, :object, :ownership, :phone, :raw_address, :refreshed_at]

    @typedoc "The `financial_connections.account_owner` type.\n\n  * `email` The email address of the owner.\n  * `id` Unique identifier for the object.\n  * `name` The full name of the owner.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `ownership` The ownership object that this owner belongs to.\n  * `phone` The raw phone number of the owner.\n  * `raw_address` The raw physical address of the owner.\n  * `refreshed_at` The timestamp of the refresh that updated this owner.\n"
    @type t :: %__MODULE__{
            email: binary | nil,
            id: binary,
            name: binary,
            object: binary,
            ownership: binary,
            phone: binary | nil,
            raw_address: binary | nil,
            refreshed_at: integer | nil
          }
  )
end

defmodule Stripe.Event do
  @moduledoc """
  Work with Stripe event objects.

  You can:

  - Retrieve an event

  Does not yet render the `data` object.

  Stripe API reference: https://stripe.com/docs/api#event
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object, :api_version, :created, :livemode, :pending_webhooks,
    :request, :type, :user_id
  ]

  @relationships %{}

  @plural_endpoint "events"

  @doc """
  Returns a map of relationship keys and their Struct name.
  Relationships must be specified for the relationship to
  be returned as a struct.
  """
  @spec relationships :: map
  def relationships, do: @relationships

  @doc """
  Retrieve an event.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, __MODULE__, opts)
  end
end

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
    :id, :object,
    :api_version, :created, :data, :livemode, :pending_webhooks,
    :request, :type, :user_id
  ]

  @plural_endpoint "events"

  @doc """
  Retrieve an event.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, __MODULE__, opts)
  end
end

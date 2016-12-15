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

  @response_mapping %{
    id: :string,
    object: :string,
    api_version: :string,
    created: :datetime,
    livemode: :boolean,
    pending_webhooks: :integer,
    request: :string,
    type: :string,
    user_id: :string
  }

  @plural_endpoint "events"

  @doc """
  Returns the Stripe response mapping of keys to types.
  """
  @spec response_mapping :: Keyword.t
  def response_mapping, do: @response_mapping

  @doc """
  Retrieve an event.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, __MODULE__, opts)
  end
end

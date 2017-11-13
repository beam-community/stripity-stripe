defmodule Stripe.Event do
  @moduledoc """
  Work with Stripe event objects.

  You can:

  - Retrieve an event

  Does not yet render the `data` object.

  Stripe API reference: https://stripe.com/docs/api#event
  """
  use Stripe.Entity

  @type t :: %__MODULE__{
               id: Stripe.id,
               object: String.t,
               api_version: String.t,
               created: Stripe.timestamp,
               data: %{
                 object: map,
                 previous_attributes: map
               },
               livemode: boolean,
               pending_webhooks: non_neg_integer,
               request: %{
                 id: String.t,
                 idempotency_key: String.t
               },
               type: String.t
             }

  defstruct [
    :id,
    :object,
    :api_version,
    :created,
    :data,
    :livemode,
    :pending_webhooks,
    :request,
    :type,
    :user_id
  ]

  @plural_endpoint "events"

  @doc """
  Retrieve an event.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end

  @doc """
  List all events.
  """
  @spec list(map, Keyword.t) :: {:ok, Stripe.List.t} | {:error, Stripe.api_error_struct}
  def list(params \\ %{}, opts \\ []) do
    endpoint = @plural_endpoint
    Stripe.Request.retrieve(params, endpoint, opts)
  end
end

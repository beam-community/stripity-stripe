defmodule Stripe.WebhookEndpoint do
  @moduledoc """
  Work with [Stripe `webhook_endpoint` objects](https://stripe.com/docs/api/webhook_endpoints).
   You can:
  - [Create a webhook_endpoint](https://stripe.com/docs/api/webhook_endpoints/create)
  - [Retrieve a webhook_endpoint](https://stripe.com/docs/api/webhook_endpoints/retrieve)
  - [Update a webhook_endpoint](https://stripe.com/docs/api/webhook_endpoints/update)
  - [List all webhook_endpoint](https://stripe.com/docs/api/webhook_endpoints/list)
  """

  use Stripe.Entity
  import Stripe.Request
  require Stripe.Util

  @type t :: %__MODULE__{
          created: Stripe.timestamp(),
          deleted: boolean,
          description: String.t(),
          enabled_events: list(String.t()),
          id: Stripe.id(),
          livemode: boolean,
          metadata: map,
          object: String.t(),
          secret: String.t() | nil,
          status: String.t(),
          url: String.t()
        }

  defstruct [
    :created,
    :deleted,
    :description,
    :enabled_events,
    :id,
    :livemode,
    :metadata,
    :object,
    :secret,
    :status,
    :url
  ]

  @plural_endpoint "webhook_endpoints"

  @doc """
  Create a webhook endpoint.
    See the [Stripe docs](https://stripe.com/docs/api/webhook_endpoints/create).
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:api_version) => String.t(),
                 optional(:connect) => boolean,
                 optional(:description) => String.t(),
                 :enabled_events => list(String.t()),
                 optional(:metadata) => map,
                 :url => String.t()
               }
               | %{}
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  Retrieve a webhook endpoint.
    See the [Stripe docs](https://stripe.com/docs/api/webhook_endpoints/retrieve).
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a webhook endpoint.
    See the [Stripe docs](https://stripe.com/docs/api/webhook_endpoints/update).
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:description) => String.t(),
                 optional(:disabled) => boolean,
                 optional(:enabled_events) => list(String.t()),
                 optional(:metadata) => map,
                 optional(:url) => String.t()
               }
               | %{}
  def update(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  List all webhook endpoints.
    See the [Stripe docs](https://stripe.com/docs/api/webhook_endpoints/list).
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:ending_before) => t | Stripe.id(),
                 optional(:limit) => 1..100,
                 optional(:starting_after) => t | Stripe.id()
               }
               | %{}
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> prefix_expansions()
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:ending_before, :starting_after])
    |> make_request()
  end

  @doc """
  Delete a webhook endpoint.
    See the [Stripe docs](https://stripe.com/docs/api/webhook_endpoints/delete).
  """
  @spec delete(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def delete(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:delete)
    |> make_request()
  end
end

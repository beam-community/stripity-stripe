defmodule Stripe.Terminal.Location do
  @moduledoc """
  A Location represents a grouping of readers.

  You can:
  - [Create a location](https://stripe.com/docs/api/terminal/locations/create)
  - [Retrieve a location](https://stripe.com/docs/api/terminal/locations/retrieve)
  - [Update a location](https://stripe.com/docs/api/terminal/locations/update)
  - [Delete a location](https://stripe.com/docs/api/terminal/locations/delete)
  - [List all locations](https://stripe.com/docs/api/terminal/locations/list)
  """

  use Stripe.Entity
  import Stripe.Request
  require Stripe.Util

  @type t :: %__MODULE__{
          id: Stripe.id(),
          address: Stripe.Types.address(),
          object: String.t(),
          display_name: String.t(),
          metadata: Stripe.Types.metadata(),
          livemode: boolean()
        }

  defstruct [
    :id,
    :metadata,
    :address,
    :display_name,
    :object,
    :livemode
  ]

  @plural_endpoint "terminal/locations"

  @doc """
  Create a new Location
  """

  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 :address => Stripe.Types.address(),
                 :display_name => String.t(),
                 optional(:metadata) => Stripe.Types.metadata()
               }
               | %{}

  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Retrieve a location with a specified `id`.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a location.

  Takes the `id` and a map of changes.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:default_currency) => Stripe.Types.address(),
               optional(:display_name) => String.t(),
               optional(:metadata) => Stripe.Types.metadata()
             }
  def update(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  Delete an account.
  """
  @spec delete(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def delete(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:delete)
    |> make_request()
  end

  @doc """
  List all locations.
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:ending_before) => t | Stripe.id(),
               optional(:limit) => 1..100,
               optional(:starting_after) => t | Stripe.id()
             }
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> prefix_expansions()
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:ending_before, :starting_after])
    |> make_request()
  end
end

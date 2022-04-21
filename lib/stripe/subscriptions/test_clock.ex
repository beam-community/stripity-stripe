defmodule Stripe.TestClock do
  @moduledoc """
  Work with Stripe Test Clock object

  You can:

  - Create a Test Clock
  - Retrieve a Test Clock
  - Advance a Test Clock
  - Delete a Test Clock
  - List Test Clocks

  Stripe API reference: https://stripe.com/docs/api/test_clocks
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          created: Stripe.timestamp(),
          deletes_after: Stripe.timestamp(),
          frozen_time: Stripe.timestamp(),
          livemode: boolean(),
          name: String.t(),
          status: String.t()
        }

  defstruct [
    :id,
    :object,
    :created,
    :deletes_after,
    :frozen_time,
    :livemode,
    :name,
    :status
  ]

  @plural_endpoint "test_helpers/test_clocks"

  @spec create(params, Stripe.options()) :: {:ok, t()} | {:error, Stripe.Error.t()}
        when params: %{
               :frozen_time => Stripe.timestamp(),
               optional(:name) => String.t()
             }
  def create(params, opts \\ []) do
    opts
    |> new_request()
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> make_request()
  end

  @spec retrieve(Stripe.id() | t(), Stripe.options()) :: {:ok, t()} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    opts
    |> new_request()
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @spec advance(Stripe.id(), params, Stripe.options()) :: {:ok, t()} | {:error, Stripe.Error.t()}
        when params: %{
               :frozen_time => Stripe.timestamp()
             }
  def advance(id, params, opts \\ []) do
    opts
    |> new_request()
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}/advance")
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  @spec delete(Stripe.id() | t(), Stripe.options()) :: {:ok, t()} | {:erorr, Stripe.Error.t()}
  def delete(id, opts \\ []) do
    opts
    |> new_request()
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:delete)
    |> make_request()
  end

  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t())} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:ending_before) => Stripe.timestamp(),
               optional(:limit) => 1..100,
               optional(:starting_after) => t() | Stripe.id()
             }
  def list(params \\ %{}, opts \\ []) do
    opts
    |> new_request()
    |> prefix_expansions()
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:ending_before, :starting_after])
    |> make_request()
  end
end

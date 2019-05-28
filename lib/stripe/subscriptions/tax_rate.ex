defmodule Stripe.TaxRate do
  @moduledoc """
  Work with Stripe TaxRate objects.

  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          active: boolean,
          created: Stripe.timestamp(),
          description: String.t() | nil,
          display_name: String.t(),
          inclusive: boolean,
          jurisdiction: String.t() | nil,
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          percentage: integer
        }

  defstruct [
    :id,
    :object,
    :active,
    :created,
    :description,
    :display_name,
    :inclusive,
    :jurisdiction,
    :livemode,
    :metadata,
    :percentage
  ]

  @plural_endpoint "tax_rates"

  @doc """
  Create a tax rate.
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 :percentage => number,
                 :display_name => String.t(),
                 :inclusive => boolean,
                 optional(:active) => boolean,
                 optional(:description) => String.t(),
                 optional(:metadata) => Stripe.Types.metadata(),
                 optional(:jurisdiction) => String.t()
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
  Retrieve a tax rate.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a tax rate.

  Takes the `id` and a map of changes.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:percentage) => number,
                 optional(:display_name) => String.t(),
                 optional(:inclusive) => boolean,
                 optional(:active) => boolean,
                 optional(:description) => String.t(),
                 optional(:metadata) => Stripe.Types.metadata(),
                 optional(:jurisdiction) => String.t()
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
  List all tax rates.
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:active) => boolean,
                 optional(:created) => Stripe.date_query(),
                 optional(:ending_before) => t | Stripe.id(),
                 optional(:limit) => 1..100,
                 optional(:inclusive) => boolean,
                 optional(:percentage) => number,
                 optional(:starting_after) => t | Stripe.id()
               }
               | %{}
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:ending_before, :starting_after])
    |> make_request()
  end
end

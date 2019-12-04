defmodule Stripe.Issuing.Cardholder do
  @moduledoc """
  Work with Stripe Issuing cardholder objects.

  You can:

  - Create a cardholder
  - Retrieve a cardholder
  - Update a cardholder

  Stripe API reference: https://stripe.com/docs/api/issuing/cardholders
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          authorization_controls: Stripe.Issuing.Types.authorization_controls() | nil,
          billing: Stripe.Issuing.Types.billing(),
          created: Stripe.timestamp(),
          email: String.t() | nil,
          is_default: boolean | nil,
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          name: String.t(),
          phone_number: String.t() | nil,
          requirements: %{
            disabled_reason: String.t() | nil,
            past_due: list
          },
          status: String.t() | nil,
          type: atom() | String.t()
        }

  defstruct [
    :id,
    :object,
    :authorization_controls,
    :billing,
    :created,
    :email,
    :is_default,
    :livemode,
    :metadata,
    :name,
    :phone_number,
    :requirements,
    :status,
    :type
  ]

  @plural_endpoint "issuing/cardholders"

  @doc """
  Create a cardholder.
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 :billing => Stripe.Issuing.Types.billing(),
                 :name => String.t(),
                 :type => :individual | :business_entity,
                 optional(:authorization_controls) =>
                   Stripe.Issuing.Types.authorization_controls(),
                 optional(:email) => String.t(),
                 optional(:is_default) => boolean,
                 optional(:metadata) => Stripe.Types.metadata(),
                 optional(:phone_number) => String.t(),
                 optional(:status) => String.t()
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
  Retrieve a cardholder.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a cardholder.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:authorization_controls) =>
                   Stripe.Issuing.Types.authorization_controls(),
                 optional(:email) => String.t(),
                 optional(:is_default) => boolean,
                 optional(:metadata) => Stripe.Types.metadata(),
                 optional(:phone_number) => String.t(),
                 optional(:status) => String.t()
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
  List all cardholders.
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:created) => String.t() | Stripe.date_query(),
                 optional(:email) => String.t(),
                 optional(:ending_before) => t | Stripe.id(),
                 optional(:is_default) => boolean,
                 optional(:limit) => 1..100,
                 optional(:phone_number) => String.t(),
                 optional(:starting_after) => t | Stripe.id(),
                 optional(:status) => String.t(),
                 optional(:type) => String.t()
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
end

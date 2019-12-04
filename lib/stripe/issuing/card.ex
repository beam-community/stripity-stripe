defmodule Stripe.Issuing.Card do
  @moduledoc """
  Work with Stripe Issuing card objects.

  You can:

  - Create a card
  - Retrieve a card
  - Update a card
  - List all cards

  Stripe API reference: https://stripe.com/docs/api/issuing/cards
  """

  use Stripe.Entity
  import Stripe.Request

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          authorization_controls: Stripe.Issuing.Types.authorization_controls(),
          brand: String.t(),
          cardholder: Stripe.id() | Stripe.Issuing.Cardholder.t(),
          created: Stripe.timestamp(),
          currency: String.t(),
          exp_month: pos_integer,
          exp_year: pos_integer,
          last4: String.t(),
          livemode: boolean,
          metadata: Stripe.Types.metadata(),
          name: String.t(),
          pin: %{
            status: :active | :blocked
          },
          replacement_for: t | Stripe.id() | nil,
          replacement_reason: String.t() | nil,
          shipping: Stripe.Types.shipping() | nil,
          status: String.t(),
          type: atom() | String.t()
        }

  defstruct [
    :id,
    :object,
    :authorization_controls,
    :brand,
    :cardholder,
    :created,
    :currency,
    :exp_month,
    :exp_year,
    :last4,
    :livemode,
    :metadata,
    :name,
    :pin,
    :replacement_for,
    :replacement_reason,
    :shipping,
    :status,
    :type
  ]

  @plural_endpoint "issuing/cards"

  @doc """
  Create a card.
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 :currency => String.t(),
                 :type => :physical | :virtual,
                 optional(:authorization_controls) =>
                   Stripe.Issuing.Types.authorization_controls(),
                 optional(:cardholder) => Stripe.id() | Stripe.Issuing.Cardholder.t(),
                 optional(:metadata) => Stripe.Types.metadata(),
                 optional(:replacement_for) => t | Stripe.id(),
                 optional(:replacement_reason) => String.t(),
                 optional(:shipping) => Stripe.Types.shipping(),
                 optional(:status) => String.t()
               }
               | %{}
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> cast_to_id([:cardholder])
    |> make_request()
  end

  @doc """
  Retrieve a card.
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc """
  Update a card.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:authorization_controls) =>
                   Stripe.Issuing.Types.authorization_controls(),
                 optional(:cardholder) => Stripe.id() | Stripe.Issuing.Cardholder.t(),
                 optional(:metadata) => Stripe.Types.metadata(),
                 optional(:replacement_for) => t | Stripe.id(),
                 optional(:replacement_reason) => String.t(),
                 optional(:shipping) => Stripe.Types.shipping(),
                 optional(:status) => String.t()
               }
               | %{}
  def update(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> cast_to_id([:cardholder])
    |> make_request()
  end

  @doc """
  List all cards.
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:cardholder) => Stripe.id() | Stripe.Issuing.Cardholder.t(),
                 optional(:created) => String.t() | Stripe.date_query(),
                 optional(:ending_before) => t | Stripe.id(),
                 optional(:exp_month) => String.t(),
                 optional(:exp_year) => String.t(),
                 optional(:last4) => String.t(),
                 optional(:limit) => 1..100,
                 optional(:source) => String.t(),
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
    |> cast_to_id([:cardholder, :ending_before, :starting_after])
    |> make_request()
  end
end

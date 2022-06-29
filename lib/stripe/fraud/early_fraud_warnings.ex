defmodule Stripe.Fraud.EarlyFraudWarning do
  @moduledoc """
  Work with Stripe Radar Early Fraud Warnings objects.

  You can:

  - Retrieve an early fraud warning
  - Retrieve all early fraud warnings

  Stripe API reference: https://stripe.com/docs/api/radar/early_fraud_warnings
  """

  use Stripe.Entity
  import Stripe.Request

  @typedoc """
  One of "card_never_received", or "fraudulent_card_application", or
  "made_with_counterfeit_card", or "made_with_lost_card", or "made_with_stolen_card",
  or "misc", or "unauthorized_use_of_card"
  """
  @type payment_status :: String.t()

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          actionable: boolean(),
          charge: Stripe.id() | Stripe.Charge.t() | nil,
          created: Stripe.timestamp(),
          fraud_type: String.t(),
          livemode: boolean(),
          payment_intent: Stripe.id() | Stripe.PaymentIntent.t() | nil
        }

  defstruct [
    :id,
    :object,
    :actionable,
    :charge,
    :created,
    :fraud_type,
    :livemode,
    :payment_intent
  ]

  @plural_endpoint "radar/early_fraud_warnings"

  @doc ~S"""
  Retrieve an Early Fraud Warning
  """
  @spec retrieve(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:get)
    |> make_request()
  end

  @doc ~S"""
  Retrieve a list of Early Fraud Warnings
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params:
               %{
                 optional(:charge) => Stripe.id() | Stripe.Charge.t(),
                 optional(:payment_intent) => Stripe.id() | Stripe.PaymentIntent.t(),
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
    |> cast_to_id([:charge, :ending_before, :starting_after])
    |> make_request()
  end
end

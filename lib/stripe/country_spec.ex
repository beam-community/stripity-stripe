defmodule Stripe.CountrySpec do
  alias Stripe.Converter

  @moduledoc """
  Work with Stripe country specs objects.

  You can:
  - Retrieve a country spec
  - Retrieve a list of country specs

  Stripe API reference: https://stripe.com/docs/api#country_specs
  """
  @type t :: %__MODULE__{}

  defstruct [
    :id, :object,
    :default_currency, :supported_bank_account_currencies,
    :supported_payment_currencies, :supported_payment_methods,
    :verification_fields
  ]

  @endpoint "country_specs"

  @doc """
  Retrieve a country spec.
  """
  @spec retrieve(binary) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(country) do
    path = @endpoint <> "/" <> country
    Stripe.Request.retrieve(path, [])
  end

  @doc """
  Retrieve a list of country specs.
  """
  @spec retrieve_all() :: {:ok, Map.t} | {:error, Stripe.api_error_struct}
  def retrieve_all do
    Stripe.Request.retrieve_all(@endpoint)
  end
end

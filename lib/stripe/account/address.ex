defmodule Stripe.Account.Address do
  @moduledoc """
  Module definition for a Stripe Address object
  Stripe Address objects do not have endpoints or actions associated,
  but they have a specific mapping
  """

  alias Stripe.Util

  @type t :: %__MODULE__{}

  defstruct [
    :city, :country, :line1, :line2, :state, :postal_code
  ]

  @response_mapping %{
    city: :string,
    country: :string,
    line1: :string,
    line2: :string,
    state: :string,
    postal_code: :string,

  }

  @doc """
  Returns the Stripe response mapping of keys to types.
  """
  @spec response_mapping :: Keyword.t
  def response_mapping, do: @response_mapping
end

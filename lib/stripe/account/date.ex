 defmodule Stripe.Account.Date do
  @moduledoc """
  Module definition for a Stripe Date object
  Stripe Date objects do not have endpoints or actions associated,
  but they have a specific mapping
  """

  alias Stripe.Util

  @type t :: %__MODULE__{}

  defstruct [:day, :month, :year]

  @response_mapping %{
    day: :integer,
    month: :integer,
    year: :integer
  }

  @doc """
  Returns the Stripe response mapping of keys to types.
  """
  @spec response_mapping :: Keyword.t
  def response_mapping, do: @response_mapping
end

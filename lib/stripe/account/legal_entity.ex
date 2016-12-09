defmodule Stripe.Account.LegalEntity do
  @moduledoc """
  Module definition for a Stripe LegalEntity object
  Stripe LegalEntity objects do not have endpoints or actions associated,
  but they have a specific mapping
  """

  alias Stripe.Util

  @type t :: %__MODULE__{}

  defstruct [
    :business_name, :business_tax_id_provided, :dob, :first_name, :last_name,
    :address, :personal_address, :ssn_last_4_provided, :type
  ]

  @response_mapping %{
    business_name: :string,
    business_tax_id_provided: :boolean,
    dob: %{module: Stripe.Account.Date},
    first_name: :string,
    last_name: :string,
    address: %{module: Stripe.Account.Address},
    personal_address: %{module: Stripe.Account.Address},
    ssn_last_4_provided: :boolean,
    type: :string
  }

  @doc """
  Returns the Stripe response mapping of keys to types.
  """
  @spec response_mapping :: Keyword.t
  def response_mapping, do: @response_mapping
end

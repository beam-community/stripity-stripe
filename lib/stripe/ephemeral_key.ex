defmodule Stripe.EphemeralKey do
  @moduledoc """
  Work with Stripe EphemeralKey objects.

  You can:

  - Create a ephemeral key

  Does not yet render lists or take options.
  
  Does not have an afficiol API docs endpoint, 
  but is required for iOS and Android SDK functionality.
  
  Explained in
  https://stripe.com/docs/mobile/ios/standard#prepare-your-api
  https://stripe.com/docs/mobile/android/customer-information#prepare-your-api

  Stripe API reference: https://stripe.com/docs/api#customer
  """
  defstruct [
    :id, :object,
    :created, :expires,
    :secret, :associated_objects
  ]

  @type t :: %__MODULE__{}

  @plural_endpoint "ephemeral_keys"

  @schema %{
    customer: [:create]
  }
  @doc """
  Create an ephemeral key.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, api_version, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, @schema, opts, %{"Stripe-Version": api_version})
  end
end

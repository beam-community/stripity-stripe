defmodule Stripe.Charge do
  @moduledoc """
  Work with Stripe charge objects.

  You can:

  - Retrieve a charge

  Stripe API reference: https://stripe.com/docs/api#charge
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object,
    :amount, :amount_refunded, :application, :application_fee,
    :balance_transaction, :captured, :created, :currency, :customer,
    :description, :destination, :dispute, :failure_code, :failure_message,
    :fraud_details, :invoice, :livemode, :metadata, :order, :outcome,
    :paid, :receipt_email, :receipt_number, :refunded, :refunds, :review,
    :shipping, :source, :source_transfer, :statement_descriptor, :status,
    :transfer
  ]

  @plural_endpoint "charges"

  @address_map %{
    city: [:create, :retrieve, :update],
    country: [:create, :retrieve, :update],
    line1: [:create, :retrieve, :update],
    line2: [:create, :retrieve, :update],
    postal_code: [:create, :retrieve, :update],
    state: [:create, :retrieve, :update]
  }

  @schema %{
    amount: [:create, :retrieve],
    amount_refunded: [:retrieve],
    application: [:retrieve],
    application_fee: [:create, :retrieve],
    balance_transaction: [:retrieve],
    capture: [:create],
    captured: [:retrieve],
    created: [:retrieve],
    currency: [:retrieve],
    customer: [:create, :retrieve],
    description: [:create, :retrieve, :update],
    destination: [:create, :retrieve],
    dispute: [:retrieve],
    failure_code: [:retrieve],
    failure_message: [:retrieve],
    fraud_details: [:retrieve, :update],
    id: [:retrieve],
    invoice: [:retrieve],
    livemode: [:retrieve],
    metadata: [:create, :retrieve, :update],
    object: [:retrieve],
    order: [:create, :retrieve],
    outcome: [:create, :retrieve],
    paid: [:create, :retrieve],
    receipt_email: [:create, :retrieve, :update],
    receipt_number: [:retrieve],
    refunded: [:retrieve],
    refunds: [:retrieve],
    review: [:retrieve],
    shipping: %{
      address: @address_map,
      carrier: [:create, :retrieve, :update],
      name: [:create, :retrieve, :update],
      phone: [:create, :retrieve, :update],
      tracking_number: [:create, :retrieve, :update]
    },
    source: [:create, :retrieve],
    source_transfer: [:retrieve],
    statement_descriptor: [:create, :retrieve],
    status: [:retrieve],
    transfer: [:retrieve]
  }

  @nullable_keys []

  @doc """
  Retrieve a charge.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, __MODULE__, opts)
  end
end

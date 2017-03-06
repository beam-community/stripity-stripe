defmodule Stripe.Charge do
  @moduledoc """
  Work with Stripe charge objects.

  You can:

  - Retrieve a charge

  Stripe API reference: https://stripe.com/docs/api#charge

  Example:

  ```
  {
    "id": "ch_19l8PP2eZvKYlo2CJo3S4Ka5",
    "object": "charge",
    "amount": 2000,
    "amount_refunded": 0,
    "application": null,
    "application_fee": null,
    "balance_transaction": "txn_19XQj42eZvKYlo2CQ5A803uM",
    "captured": true,
    "created": 1486610147,
    "currency": "usd",
    "customer": "cus_4YUnnAzzvuqjSD",
    "description": null,
    "destination": null,
    "dispute": null,
    "failure_code": null,
    "failure_message": null,
    "fraud_details": {
    },
    "invoice": "in_19l6C52eZvKYlo2CpZ9qGpDQ",
    "livemode": false,
    "metadata": {
    },
    "on_behalf_of": null,
    "order": null,
    "outcome": {
      "network_status": "approved_by_network",
      "reason": null,
      "risk_level": "normal",
      "seller_message": "Payment complete.",
      "type": "authorized"
    },
    "paid": true,
    "receipt_email": null,
    "receipt_number": null,
    "refunded": false,
    "refunds": {
      "object": "list",
      "data": [

      ],
      "has_more": false,
      "total_count": 0,
      "url": "/v1/charges/ch_19l8PP2eZvKYlo2CJo3S4Ka5/refunds"
    },
    "review": null,
    "shipping": null,
    "source": {
      "id": "card_14PNna2eZvKYlo2C13kTQzRo",
      "object": "card",
      "address_city": null,
      "address_country": null,
      "address_line1": null,
      "address_line1_check": null,
      "address_line2": null,
      "address_state": null,
      "address_zip": null,
      "address_zip_check": null,
      "brand": "Visa",
      "country": "US",
      "customer": "cus_4YUnnAzzvuqjSD",
      "cvc_check": null,
      "dynamic_last4": null,
      "exp_month": 6,
      "exp_year": 2019,
      "funding": "credit",
      "last4": "4242",
      "metadata": {
      },
      "name": null,
      "tokenization_method": null
    },
    "source_transfer": null,
    "statement_descriptor": null,
    "status": "succeeded",
    "transfer_group": null
  }
  ```
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

  @doc """
  Create a charge.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, opts)
  end

  @doc """
  Retrieve a charge.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end
end

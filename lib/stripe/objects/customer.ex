defmodule Stripe.Customer do
  @moduledoc """
  Work with Stripe customer objects.

  You can:

  - Create a customer
  - Retrieve a customer
  - Update a customer
  - Delete a customer

  Does not yet render lists or take options.

  Stripe API reference: https://stripe.com/docs/api#customer

  Example:

  ```
  {
    "id": "cus_A5IzRTlo2DcV1J",
    "object": "customer",
    "account_balance": 0,
    "created": 1486610024,
    "currency": "usd",
    "default_source": "card_19l8NQ2eZvKYlo2CiYWILX4R",
    "delinquent": false,
    "description": "Sample user",
    "discount": null,
    "email": "jaylen@example.com",
    "livemode": false,
    "metadata": {
    },
    "shipping": null,
    "sources": {
      "object": "list",
      "data": [
        {
          "id": "card_19l8NQ2eZvKYlo2CiYWILX4R",
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
          "customer": "cus_A5IzRTlo2DcV1J",
          "cvc_check": "pass",
          "dynamic_last4": null,
          "exp_month": 2,
          "exp_year": 2018,
          "funding": "credit",
          "last4": "1881",
          "metadata": {
          },
          "name": null,
          "tokenization_method": null
        }
      ],
      "has_more": false,
      "total_count": 1,
      "url": "/v1/customers/cus_A5IzRTlo2DcV1J/sources"
    },
    "subscriptions": {
      "object": "list",
      "data": [

      ],
      "has_more": false,
      "total_count": 0,
      "url": "/v1/customers/cus_A5IzRTlo2DcV1J/subscriptions"
    }
  }
  ```
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object,
    :account_balance, :business_vat_id, :created, :currency,
    :default_source, :delinquent, :description, :discount, :email,
    :livemode, :metadata, :shipping, :sources, :subscriptions
  ]

  @plural_endpoint "customers"

  @doc """
  Create a customer.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, opts)
  end

  @doc """
  Retrieve a customer.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end

  @doc """
  Update a customer.

  Takes the `id` and a map of changes.
  """
  @spec update(binary, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, opts)
  end

  @doc """
  Delete a customer.
  """
  @spec delete(binary, list) :: :ok | {:error, Stripe.api_error_struct}
  def delete(id, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.delete(endpoint, %{}, opts)
  end

  @doc """
  List all customers.
  """
  @spec list(map, Keyword.t) :: {:ok, Stripe.List.t} | {:error, Stripe.api_error_struct}
  def list(params \\ %{}, opts \\ []) do
    endpoint = @plural_endpoint
    Stripe.Request.retrieve(params, endpoint, opts)
  end
end

defmodule Stripe.Account do
  @moduledoc """
  Work with Stripe account objects.

  You can:

  - Retrieve your own account
  - Retrieve an account with a specified `id`

  This module does not yet support managed accounts.

  Does not yet render lists or take options.

  Stripe API reference: https://stripe.com/docs/api#account

  Example:

  ```
  {
    "id": "acct_1032D82eZvKYlo2C",
    "object": "account",
    "business_logo": null,
    "business_name": "Stripe.com",
    "business_url": null,
    "charges_enabled": false,
    "country": "US",
    "debit_negative_balances": true,
    "decline_charge_on": {
      "avs_failure": true,
      "cvc_failure": false
    },
    "default_currency": "usd",
    "details_submitted": false,
    "display_name": "Stripe.com",
    "email": "site@stripe.com",
    "external_accounts": {
      "object": "list",
      "data": [

      ],
      "has_more": false,
      "total_count": 0,
      "url": "/v1/accounts/acct_1032D82eZvKYlo2C/external_accounts"
    },
    "legal_entity": {
      "address": {
        "city": null,
        "country": "US",
        "line1": null,
        "line2": null,
        "postal_code": null,
        "state": null
      },
      "business_name": null,
      "business_tax_id_provided": false,
      "dob": {
        "day": null,
        "month": null,
        "year": null
      },
      "first_name": null,
      "last_name": null,
      "personal_address": {
        "city": null,
        "country": "US",
        "line1": null,
        "line2": null,
        "postal_code": null,
        "state": null
      },
      "personal_id_number_provided": false,
      "ssn_last_4_provided": false,
      "type": null,
      "verification": {
        "details": null,
        "details_code": "failed_other",
        "document": null,
        "status": "unverified"
      }
    },
    "managed": true,
    "metadata": {
    },
    "product_description": null,
    "statement_descriptor": null,
    "support_email": null,
    "support_phone": null,
    "timezone": "US/Pacific",
    "tos_acceptance": {
      "date": null,
      "ip": null,
      "user_agent": null
    },
    "transfer_schedule": {
      "delay_days": 7,
      "interval": "daily"
    },
    "transfer_statement_descriptor": null,
    "transfers_enabled": false,
    "verification": {
      "disabled_reason": "fields_needed",
      "due_by": null,
      "fields_needed": [
        "business_url",
        "external_account",
        "product_description",
        "support_phone",
        "tos_acceptance.date",
        "tos_acceptance.ip"
      ]
    }
  }
  ```
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :object,
    :business_name, :business_primary_color, :business_url,
    :charges_enabled, :country, :default_currency, :details_submitted,
    :display_name, :email, :legal_entity, :external_accounts, :managed,
    :metadata, :statement_descriptor, :support_email, :support_phone,
    :support_url, :timezone, :tos_acceptance, :transfers_enabled,
    :verification
  ]

  @singular_endpoint "account"
  @plural_endpoint "accounts"

  @doc """
  Create an account.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, opts)
  end

  @doc """
  Retrieve your own account without options.
  """
  @spec retrieve :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve, do: retrieve([])

  @doc """
  Retrieve your own account with options.
  """
  @spec retrieve(list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(opts) when is_list(opts), do: do_retrieve(@singular_endpoint, opts)

  @doc """
  Retrieve an account with a specified `id`.
  """
  @spec retrieve(binary, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts \\ []), do: do_retrieve(@plural_endpoint <> "/" <> id, opts)

  @spec do_retrieve(String.t, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  defp do_retrieve(endpoint, opts), do: Stripe.Request.retrieve(endpoint, opts)

  @doc """
  Update an account.

  Takes the `id` and a map of changes.
  """
  @spec update(binary, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, opts)
  end
end

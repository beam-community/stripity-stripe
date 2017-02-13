defmodule Stripe.ExternalAccount do
  @moduledoc """
  Work with Stripe external account objects.

  You can:

  - Create an external account
  - Retrieve an external account
  - Update an external account
  - Delete an external account

  Does not yet render lists or take options.

  Probably does not yet work for credit cards.

  Stripe API reference: https://stripe.com/docs/api#external_accounts

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
    :account, :account_holder_name, :account_holder_type,
    :bank_name, :country, :currency, :default_for_currency, :fingerprint,
    :last4, :metadata, :routing_number, :status
  ]

  defp endpoint(managed_account_id) do
    "accounts/#{managed_account_id}/external_accounts"
  end

  @doc """
  Create an external account.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts = [connect_account: managed_account_id]) do
    endpoint = endpoint(managed_account_id)
    Stripe.Request.create(endpoint, changes, opts)
  end

  @doc """
  Retrieve an external account.
  """
  @spec retrieve(binary, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def retrieve(id, opts = [connect_account: managed_account_id]) do
    endpoint = endpoint(managed_account_id) <> "/" <> id
    Stripe.Request.retrieve(endpoint, opts)
  end

  @doc """
  Update an external account.

  Takes the `id` and a map of changes.
  """
  @spec update(binary, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts = [connect_account: managed_account_id]) do
    endpoint = endpoint(managed_account_id) <> "/" <> id
    Stripe.Request.update(endpoint, changes, opts)
  end

  @doc """
  Delete an external account.
  """
  @spec delete(binary, list) :: :ok | {:error, Stripe.api_error_struct}
  def delete(id, opts = [connect_account: managed_account_id]) do
    endpoint = endpoint(managed_account_id) <> "/" <> id
    Stripe.Request.delete(endpoint, opts)
  end
end

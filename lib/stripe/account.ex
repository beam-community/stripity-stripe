defmodule Stripe.Account do
  @moduledoc """
  Work with Stripe account objects.

  You can:

  - Retrieve your own account
  - Retrieve an account with a specified `id`

  This module does not yet support managed accounts.

  Does not yet render lists or take options.

  Stripe API reference: https://stripe.com/docs/api#account
  """

  @type t :: %__MODULE__{}

  defstruct [
    :id, :business_name, :business_primary_color, :business_url,
    :charges_enabled, :country, :default_currency, :details_submitted,
    :display_name, :email, :legal_entity, :external_accounts, :managed,
    :metadata, :statement_descriptor, :support_email, :support_phone,
    :support_url, :timezone, :tos_acceptance, :transfers_enabled,
    :verification
  ]

  @relationships %{}

  @singular_endpoint "account"
  @plural_endpoint "accounts"

  @address_map %{
    city: [:create, :retrieve, :update],
    country: [:create, :retrieve, :update],
    line1: [:create, :retrieve, :update],
    line2: [:create, :retrieve, :update],
    postal_code: [:create, :retrieve, :update],
    state: [:create, :retrieve, :update]
  }

  @address_kana_kanji_map %{ # Japan only
    city: [:create, :retrieve, :update],
    country: [:create, :retrieve, :update],
    line1: [:create, :retrieve, :update],
    line2: [:create, :retrieve, :update],
    postal_code: [:create, :retrieve, :update],
    state: [:create, :retrieve, :update],
    town: [:create, :retrieve, :update]
  }

  @dob_map %{
    day: [:create, :retrieve, :update],
    month: [:create, :retrieve, :update],
    year: [:create, :retrieve, :update]
  }

  @schema %{
    business_logo: [:create, :retrieve, :update],
    business_name: [:create, :retrieve, :update],
    business_primary_color: [:create, :retrieve, :update],
    business_url: [:create, :retrieve, :update],
    country: [:create, :retrieve],
    debit_negative_balances: [:create, :retrieve, :update],
    decline_charge_on: %{
      avs_failure: [:create, :retrieve, :update],
      cvc_failure: [:create, :retrieve, :update]
    },
    default_currency: [:create, :retrieve, :update],
    email: [:create, :retrieve, :update],
    # TODO: Add ability to have nested external_account object OR the
    # token string – can accomplish with a tuple and matching on that.
    external_account: [:create, :retrieve, :update],
    external_accounts: [:retrieve],
    id: [:retrieve],
    legal_entity: %{
      address: @address_map,
      address_kana: @address_kana_kanji_map, # Japan only
      address_kanji: @address_kana_kanji_map, # Japan only
      business_name: [:create, :retrieve, :update],
      business_name_kana: [:create, :retrieve, :update], # Japan only
      business_name_kanji: [:create, :retrieve, :update], # Japan only
      business_tax_id: [:create, :update],
      business_tax_id_provided: [:retrieve],
      business_vat_id: [:create, :update],
      business_vat_id_provided: [:retrieve],
      dob: @dob_map,
      first_name: [:create, :retrieve, :update],
      first_name_kana: [:create, :retrieve, :update], # Japan only
      first_name_kanji: [:create, :retrieve, :update], # Japan only
      gender: [:create, :retrieve, :update], # "male" or "female"
      last_name: [:create, :retrieve, :update],
      last_name_kana: [:create, :retrieve, :update], # Japan only
      last_name_kanji: [:create, :retrieve, :update], # Japan only
      maiden_name: [:create, :retrieve, :update],
      personal_address: @address_map,
      personal_address_kana: @address_kana_kanji_map, # Japan only
      personal_address_kanji: @address_kana_kanji_map, # Japan only
      personal_id_number: [:create, :update],
      personal_id_number_provided: [:retrieve],
      phone_number: [:create, :retrieve, :update],
      ssn_last_4: [:create, :update], # US only
      ssn_last_4_provided: [:retrieve],
      type: [:create, :update, :retrieve], # "individual" or "company"
      verification: %{
        details: [:retrieve],
        details_code: [:retrieve],
        document: [:create, :retrieve, :update],
        status: [:retrieve],
      }
    },
    managed: [:create, :retrieve],
    metadata: [:create, :retrieve, :update],
    object: [:retrieve],
    product_description: [:create, :retrieve, :update],
    statement_descriptor: [:create, :retrieve, :update],
    support_email: [:create, :retrieve, :update],
    support_phone: [:create, :retrieve, :update],
    support_url: [:create, :retrieve, :update],
    timezone: [:retrieve],
    tos_acceptance: %{
      date: [:create, :retrieve, :update],
      ip: [:create, :retrieve, :update],
      user_agent: [:create, :retrieve, :update]
    },
    transfer_schedule: %{
      delay_days: [:create, :retrieve, :update],
      interval: [:create, :retrieve, :update],
      monthly_anchor: [:create, :retrieve, :update],
      weekly_anchor: [:create, :retrieve, :update]
    },
    transfer_statement_descriptor: [:create, :retrieve, :update],
    verification: %{
      disabled_reason: [:retrieve],
      due_by: [:retrieve],
      fields_needed: [:retrieve]
    }
  }

  @doc """
  Schema map indicating when a particular argument can be created on, retrieved
  from, or updated on the Stripe API.
  """
  @spec schema :: Keyword.t
  def schema, do: @schema

  @nullable_keys [
    :metadata, :transfer_statement_descriptor
  ]

  @doc """
  Returns a map of relationship keys and their Struct name.
  Relationships must be specified for the relationship to
  be returned as a struct.
  """
  @spec relationships :: Keyword.t
  def relationships, do: @relationships

  @doc """
  Create an account.
  """
  @spec create(map, Keyword.t) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def create(changes, opts \\ []) do
    Stripe.Request.create(@plural_endpoint, changes, @schema, __MODULE__, opts)
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
  defp do_retrieve(endpoint, opts) do
    Stripe.Request.retrieve(endpoint, __MODULE__, opts)
  end

  @doc """
  Update an account.

  Takes the `id` and a map of changes.
  """
  @spec update(t, map, list) :: {:ok, t} | {:error, Stripe.api_error_struct}
  def update(id, changes, opts \\ []) do
    endpoint = @plural_endpoint <> "/" <> id
    Stripe.Request.update(endpoint, changes, @schema, @nullable_keys, __MODULE__, opts)
  end
end

defmodule Stripe.Account do
  @moduledoc """
  Work with Stripe Connect account objects.

  You can:

  - Retrieve your own account
  - Retrieve an account with a specified `id`

  This module does not yet support managed accounts.

  Does not yet render lists or take options.

  Stripe API reference: https://stripe.com/docs/api#account
  """
  use Stripe.Entity



  @type address :: %{
                     city: String.t,
                     country: String.t,
                     line1: String.t,
                     line2: String.t,
                     postal_code: String.t,
                     state: String.t
                   }

  @type address_jp :: %{
                        city: String.t,
                        country: String.t,
                        line1: String.t,
                        line2: String.t,
                        postal_code: String.t,
                        state: String.t,
                        town: String.t
                      }

  @type verification :: %{
                          details: String.t,
                          details_code:
                            :scan_corrupt | :scan_not_readable | :scan_failed_greyscale
                            | :scan_not_uploaded | :scan_id_type_not_supported
                            | :scan_id_country_not_supported | :scan_name_mismatch
                            | :scan_failed_other | :failed_keyed_identity | :failed_other,
                          document: Stripe.id | Stripe.FileUpload.t,
                          status: :unverified | :pending | :verified
                        }

  @type additional_owner :: %{
                              address: address,
                              dob: %{
                                day: pos_integer,
                                month: pos_integer,
                                year: pos_integer
                              },
                              first_name: String.t,
                              last_name: String.t,
                              maiden_name: String.t,
                              verification: verification
                            }

  @type t :: %__MODULE__{
               id: Stripe.id,
               object: String.t,
               business_name: String.t,
               business_url: String.t,
               charges_enabled: boolean,
               country: String.t,
               debit_negative_balances: boolean,
               decline_charge_on: %{
                 avs_failure: boolean,
                 cvc_failure: boolean
               },
               default_currency: String.t,
               details_submitted: boolean,
               display_name: String.t,
               email: String.t,
               external_accounts: Stripe.List.of(Stripe.BankAccount.t | Stripe.Card.t),
               legal_entity: %{
                 additional_owners: [additional_owner],
                 address: address,
                 address_kana: address_jp,
                 address_kanji: address_jp,
                 business_name: String.t,
                 business_name_kana: String.t,
                 business_name_kanji: String.t,
                 business_tax_id_provided: boolean,
                 business_vat_id_provided: boolean,
                 dob: %{
                   day: pos_integer,
                   month: pos_integer,
                   year: pos_integer
                 },
                 first_name: String.t,
                 first_name_kanji: String.t,
                 first_name_kana: String.t,
                 gender: String.t,
                 last_name: String.t,
                 last_name_kana: String.t,
                 last_name_kanji: String.t,
                 maiden_name: String.t,
                 personal_address: address,
                 personal_address_kana: address_jp,
                 personal_address_kanji: address_jp,
                 personal_id_number_provided: boolean,
                 phone_number: String.t,
                 ssn_last_4_provided: String.t,
                 tax_id_registar: String.t,
                 type: :individual | :company,
                 verification: verification
               },
               metadata: %{
                 optional(String.t) => String.t
               },
               payout_schedule: %{
                 delay_days: non_neg_integer,
                 interval: :manual | :daily | :weekly | :monthly,
                 monthly_anchor: non_neg_integer,
                 weekly_anchor: String.t
               },
               payout_statement_descriptor: String.t,
               payouts_enabled: boolean,
               product_description: String.t,
               statement_descriptor: String.t,
               support_email: String.t,
               support_phone: String.t,
               timezone: String.t,
               tos_acceptance: %{
                 date: Stripe.timestamp,
                 ip: String.t,
                 user_agent: String.t
               },
               type: :standard | :express | :custom,
               verification: %{
                 disabled_reason:
                   :"rejected.fraud" | :"rejected.terms_of_service" | :"rejected.listed"
                   | :"rejected.other" | :fields_needed | :listed | :under_review | :other,
                 due_by: Stripe.timestamp,
                 fields_needed: [String.t]
               }
             }

  defstruct [
    :id,
    :object,
    :business_name,
    :business_url,
    :charges_enabled,
    :country,
    :debit_negative_balances,
    :decline_charge_on,
    :default_currency,
    :details_submitted,
    :display_name,
    :email,
    :legal_entity,
    :external_accounts,
    :metadata,
    :payout_schedule,
    :payout_statement_descriptor,
    :payouts_enabled,
    :product_description,
    :statement_descriptor,
    :support_email,
    :support_phone,
    :timezone,
    :tos_acceptance,
    :type,
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

  @doc """
  List all connected accounts.
  """
  @spec list(map, Keyword.t) :: {:ok, Stripe.List.t} | {:error, Stripe.api_error_struct}
  def list(params \\ %{}, opts \\ []) do
    endpoint = @plural_endpoint
    Stripe.Request.retrieve(params, endpoint, opts)
  end
end

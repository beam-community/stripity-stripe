defmodule Stripe.Account do
  @moduledoc """
  Work with Stripe Connect account objects.

  You can:

  - Retrieve your own account
  - Retrieve an account with a specified `id`

  This module does not yet support managed accounts.

  Stripe API reference: https://stripe.com/docs/api#account
  """

  use Stripe.Entity
  import Stripe.Request

  @type decline_charge_on :: %{
          avs_failure: boolean,
          cvc_failure: boolean
        }

  @type legal_entity :: %{
          additional_owners: [legal_entity_additional_owner] | nil,
          address: legal_entity_address,
          address_kana: legal_entity_japan_address | nil,
          address_kanji: legal_entity_japan_address | nil,
          business_name: String.t() | nil,
          business_name_kana: String.t() | nil,
          business_name_kanji: String.t() | nil,
          business_tax_id_provided: boolean,
          business_vat_id_provided: boolean,
          dob: legal_entity_dob,
          first_name: String.t() | nil,
          first_name_kana: String.t() | nil,
          first_name_kanji: String.t() | nil,
          gender: String.t() | nil,
          last_name: String.t() | nil,
          last_name_kana: String.t() | nil,
          last_name_kanji: String.t() | nil,
          maiden_name: String.t() | nil,
          personal_address: legal_entity_address,
          personal_address_kana: legal_entity_japan_address | nil,
          personal_address_kanji: legal_entity_japan_address | nil,
          personal_id_number_provided: boolean,
          phone_number: String.t() | nil,
          ssn_last_4_provided: String.t(),
          tax_id_registar: String.t(),
          type: String.t() | nil,
          verification: legal_entity_verification
        }

  @type legal_entity_additional_owner :: %{
          address: legal_entity_address,
          dob: legal_entity_dob,
          first_name: String.t() | nil,
          last_name: String.t() | nil,
          maiden_name: String.t() | nil,
          verification: legal_entity_verification
        }

  @type legal_entity_address :: %{
          city: String.t() | nil,
          country: String.t() | nil,
          line1: String.t() | nil,
          line2: String.t() | nil,
          postal_code: String.t() | nil,
          state: String.t() | nil
        }

  @type legal_entity_dob :: %{
          day: 1..31 | nil,
          month: 1..12 | nil,
          year: pos_integer | nil
        }

  @type legal_entity_japan_address :: %{
          city: String.t() | nil,
          country: String.t() | nil,
          line1: String.t() | nil,
          line2: String.t() | nil,
          postal_code: String.t() | nil,
          state: String.t() | nil,
          town: String.t() | nil
        }

  @type legal_entity_verification :: %{
          details: String.t() | nil,
          details_code: String.t() | nil,
          document: Stripe.id() | Stripe.FileUpload.t() | nil,
          status: String.t()
        }

  @type tos_acceptance :: %{
          date: Stripe.timestamp() | nil,
          ip: String.t() | nil,
          user_agent: String.t() | nil
        }

  @type verification :: %{
          disabled_reason: String.t() | nil,
          due_by: Stripe.timestamp() | nil,
          fields_needed: [String.t()]
        }

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          business_logo: String.t() | nil,
          business_name: String.t() | nil,
          business_url: String.t() | nil,
          charges_enabled: boolean,
          created: Stripe.timestamp() | nil,
          country: String.t(),
          debit_negative_balances: boolean,
          decline_charge_on: decline_charge_on,
          default_currency: String.t(),
          details_submitted: boolean,
          display_name: String.t() | nil,
          email: String.t() | nil,
          external_accounts: Stripe.List.t(Stripe.BankAccount.t() | Stripe.Card.t()),
          legal_entity: legal_entity,
          metadata: Stripe.Types.metadata(),
          payout_schedule: Stripe.Types.transfer_schedule(),
          payout_statement_descriptor: String.t() | nil,
          payouts_enabled: boolean,
          product_description: String.t() | nil,
          statement_descriptor: String.t() | nil,
          support_email: String.t() | nil,
          support_phone: String.t() | nil,
          timezone: String.t() | nil,
          tos_acceptance: tos_acceptance,
          type: String.t(),
          verification: verification
        }

  defstruct [
    :id,
    :object,
    :business_logo,
    :business_name,
    :business_url,
    :charges_enabled,
    :country,
    :created,
    :debit_negative_balances,
    :decline_charge_on,
    :default_currency,
    :details_submitted,
    :display_name,
    :email,
    :external_accounts,
    :legal_entity,
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
    :transfers_enabled,
    :type,
    :verification
  ]

  @singular_endpoint "account"
  @plural_endpoint "accounts"

  @type create_params :: %{
          :type => String.t(),
          optional(:account_token) => String.t(),
          optional(:business_logo) => String.t(),
          optional(:business_name) => String.t(),
          optional(:business_primary_color) => String.t(),
          optional(:business_url) => String.t(),
          optional(:country) => String.t(),
          optional(:debit_negative_balances) => boolean,
          optional(:decline_charge_on) => decline_charge_on,
          optional(:default_currency) => String.t(),
          optional(:email) => String.t(),
          optional(:external_account) => String.t(),
          optional(:legal_entity) => legal_entity,
          optional(:metadata) => Stripe.Types.metadata(),
          optional(:payout_schedule) => Stripe.Types.transfer_schedule(),
          optional(:payout_statement_descriptor) => String.t(),
          optional(:product_description) => String.t(),
          optional(:statement_descriptor) => String.t(),
          optional(:support_email) => String.t(),
          optional(:support_phone) => String.t(),
          optional(:support_url) => String.t(),
          optional(:tos_acceptance) => tos_acceptance
        }

  @doc """
  Create an account.
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:country) => String.t(),
               optional(:email) => String.t(),
               optional(:type) => String.t()
             }
  def create(params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_params(params)
    |> put_method(:post)
    |> cast_to_id([:coupon, :default_source, :source])
    |> make_request()
  end

  @doc """
  Retrieve your own account without options.
  """
  @spec retrieve :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve, do: retrieve([])

  @doc """
  Retrieve your own account with options.
  """
  @spec retrieve(list) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(opts) when is_list(opts), do: do_retrieve(@singular_endpoint, opts)

  @doc """
  Retrieve an account with a specified `id`.
  """
  @spec retrieve(binary, list) :: {:ok, t} | {:error, Stripe.Error.t()}
  def retrieve(id, opts \\ []), do: do_retrieve(@plural_endpoint <> "/" <> id, opts)

  @spec do_retrieve(String.t(), list) :: {:ok, t} | {:error, Stripe.Error.t()}
  defp do_retrieve(endpoint, opts) do
    new_request(opts)
    |> put_endpoint(endpoint)
    |> put_method(:get)
    |> make_request()
  end

  @type update_params :: %{
          optional(:account_token) => String.t(),
          optional(:business_logo) => String.t(),
          optional(:business_name) => String.t(),
          optional(:business_primary_color) => String.t(),
          optional(:business_url) => String.t(),
          optional(:country) => String.t(),
          optional(:debit_negative_balances) => boolean,
          optional(:decline_charge_on) => decline_charge_on,
          optional(:default_currency) => String.t(),
          optional(:email) => String.t(),
          optional(:external_account) => String.t(),
          optional(:legal_entity) => legal_entity,
          optional(:metadata) => Stripe.Types.metadata(),
          optional(:payout_schedule) => Stripe.Types.transfer_schedule(),
          optional(:payout_statement_descriptor) => String.t(),
          optional(:product_description) => String.t(),
          optional(:statement_descriptor) => String.t(),
          optional(:support_email) => String.t(),
          optional(:support_phone) => String.t(),
          optional(:support_url) => String.t(),
          optional(:tos_acceptance) => tos_acceptance
        }

  @doc """
  Update an account.

  Takes the `id` and a map of changes.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:business_logo) => String.t(),
               optional(:business_name) => String.t(),
               optional(:business_primary_color) => String.t(),
               optional(:business_url) => String.t(),
               optional(:double_negative_balances) => boolean,
               optional(:decline_charge_on) => decline_charge_on,
               optional(:default_currency) => String.t(),
               optional(:email) => String.t(),
               optional(:external_accounts) => String.t(),
               optional(:legal_entity) => legal_entity,
               optional(:metadata) => String.Types.metadata(),
               optional(:payout_schedule) => String.Types.transfer_schedule(),
               optional(:payout_statement_descriptor) => String.t(),
               optional(:product_description) => String.t(),
               optional(:statement_descriptor) => String.t(),
               optional(:support_phone) => String.t(),
               optional(:support_email) => String.t(),
               optional(:support_url) => String.t(),
               optional(:tos_acceptance) => tos_acceptance
             }
  def update(id, params, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(params)
    |> make_request()
  end

  @doc """
  Delete an account.
  """
  @spec delete(Stripe.id() | t, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
  def delete(id, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}")
    |> put_method(:delete)
    |> make_request()
  end

  @doc """
  Reject an account.

  Takes the `id` and `reason`.
  """
  @spec reject(Stripe.id() | t, String.t(), Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
  def reject(id, reason, opts \\ []) do
    params = %{
      account: id,
      reason: reason
    }

    new_request(opts)
    |> put_endpoint(@plural_endpoint <> "/#{get_id!(id)}/reject")
    |> put_method(:post)
    |> put_params(params)
    |> cast_to_id([:account])
    |> make_request()
  end

  @doc """
  List all connected accounts.
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:ending_before) => t | Stripe.id(),
               optional(:limit) => 1..100,
               optional(:starting_after) => t | Stripe.id()
             }
  def list(params \\ %{}, opts \\ []) do
    new_request(opts)
    |> put_endpoint(@plural_endpoint)
    |> put_method(:get)
    |> put_params(params)
    |> cast_to_id([:ending_before, :starting_after])
    |> make_request()
  end

  @doc """
  Create a login link.
  """
  @spec create_login_link(Stripe.id() | t, params, Stripe.options()) ::
          {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:redirect_url) => String.t(),
             }
  def create_login_link(id, params, opts \\ []) do
    Stripe.LoginLink.create(id, params, opts)
  end
end

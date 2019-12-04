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

  @type requirements :: %{
          current_deadline: Stripe.timestamp() | nil,
          currently_due: Stripe.List.t(String.t()) | nil,
          disabled_reason: String.t() | nil,
          eventually_due: Stripe.List.t(String.t()) | nil,
          past_due: Stripe.List.t(String.t()) | nil
        }

  @type settings :: %{
          branding: map | nil,
          card_payments: map | nil,
          dashboard: map | nil,
          payments: map | nil,
          payouts: map | nil
        }

  @type company :: %{
          address: Stripe.Types.address(),
          address_kana: Stripe.Types.japan_address() | nil,
          address_kanji: Stripe.Types.japan_address() | nil,
          directors_provided: boolean | nil,
          name: String.t() | nil,
          name_kana: String.t() | nil,
          name_kanji: String.t() | nil,
          owners_provided: boolean | nil,
          phone: String.t() | nil,
          tax_id_provided: boolean | nil,
          tax_id_registar: String.t(),
          vat_id_provided: boolean | nil
        }

  @type individual :: %{
          additional_owners: [individual_additional_owner] | nil,
          address: Stripe.Types.address(),
          address_kana: Stripe.Types.japan_address() | nil,
          address_kanji: Stripe.Types.japan_address() | nil,
          business_name: String.t() | nil,
          business_name_kana: String.t() | nil,
          business_name_kanji: String.t() | nil,
          business_tax_id_provided: boolean,
          business_vat_id_provided: boolean,
          dob: Stripe.Types.dob(),
          first_name: String.t() | nil,
          first_name_kana: String.t() | nil,
          first_name_kanji: String.t() | nil,
          gender: String.t() | nil,
          last_name: String.t() | nil,
          last_name_kana: String.t() | nil,
          last_name_kanji: String.t() | nil,
          maiden_name: String.t() | nil,
          personal_address: Stripe.Types.address(),
          personal_address_kana: Stripe.Types.japan_address() | nil,
          personal_address_kanji: Stripe.Types.japan_address() | nil,
          personal_id_number_provided: boolean,
          phone_number: String.t() | nil,
          ssn_last_4_provided: String.t(),
          tax_id_registar: String.t(),
          type: String.t() | nil,
          verification: individual_verification
        }

  @type individual_additional_owner :: %{
          address: Stripe.Types.address(),
          dob: Stripe.Types.dob(),
          first_name: String.t() | nil,
          last_name: String.t() | nil,
          maiden_name: String.t() | nil,
          verification: individual_verification
        }

  @type individual_verification :: %{
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

  @type business_profile :: %{
          mcc: String.t() | nil,
          name: String.t() | nil,
          product_description: String.t() | nil,
          support_address: %{
            city: String.t() | nil,
            country: String.t() | nil,
            line1: String.t() | nil,
            line2: String.t() | nil,
            postal_code: String.t() | nil,
            state: String.t() | nil
          },
          support_email: String.t() | nil,
          support_phone: String.t() | nil,
          support_url: String.t() | nil,
          url: String.t() | nil
        }

  @type capabilities :: %{
          card_payments: String.t() | nil,
          legacy_payments: String.t() | nil,
          transfers: String.t() | nil
        }

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          business_profile: business_profile | nil,
          business_type: String.t() | nil,
          capabilities: capabilities | nil,
          charges_enabled: boolean,
          company: company | nil,
          country: String.t(),
          created: Stripe.timestamp() | nil,
          default_currency: String.t(),
          details_submitted: boolean,
          email: String.t() | nil,
          external_accounts: Stripe.List.t(Stripe.BankAccount.t() | Stripe.Card.t()),
          individual: individual | nil,
          metadata: Stripe.Types.metadata(),
          payouts_enabled: boolean | nil,
          requirements: requirements | nil,
          settings: settings | nil,
          tos_acceptance: tos_acceptance | nil,
          type: String.t()
        }

  defstruct [
    :id,
    :object,
    :business_profile,
    :business_type,
    :capabilities,
    :charges_enabled,
    :company,
    :country,
    :created,
    :default_currency,
    :details_submitted,
    :email,
    :external_accounts,
    :individual,
    :metadata,
    :payouts_enabled,
    :requirements,
    :settings,
    :tos_acceptance,
    :type
  ]

  @singular_endpoint "account"
  @plural_endpoint "accounts"

  @doc """
  Create an account.
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               :type => String.t(),
               optional(:country) => String.t(),
               optional(:account_token) => String.t(),
               optional(:business_profile) => business_profile,
               optional(:business_type) => String.t(),
               optional(:company) => company,
               optional(:email) => String.t(),
               optional(:external_account) => String.t(),
               optional(:individual) => individual,
               optional(:metadata) => Stripe.Types.metadata(),
               optional(:requested_capabilities) => capabilities,
               optional(:settings) => settings,
               optional(:tos_acceptance) => tos_acceptance
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

  @doc """
  Update an account.

  Takes the `id` and a map of changes.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{
               optional(:account_token) => String.t(),
               optional(:business_profile) => business_profile,
               optional(:business_type) => String.t(),
               optional(:company) => company,
               optional(:default_currency) => String.t(),
               optional(:email) => String.t(),
               optional(:external_accounts) => String.t(),
               optional(:individual) => individual,
               optional(:metadata) => Stripe.Types.metadata(),
               optional(:requested_capabilities) => capabilities,
               optional(:settings) => settings,
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
    |> prefix_expansions()
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
               optional(:redirect_url) => String.t()
             }
  def create_login_link(id, params, opts \\ []) do
    Stripe.LoginLink.create(id, params, opts)
  end
end

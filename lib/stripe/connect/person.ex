defmodule Stripe.Person do
  @moduledoc """
  Work with Stripe Connect person objects.

  You can:

  - Create a person
  - Retrieve a person with a specified `id`
  - Update a person
  - Delete a person
  - List all persons on an account

  Stripe API reference: https://stripe.com/docs/api/persons
  """

  use Stripe.Entity
  import Stripe.Request

  @spec accounts_plural_endpoint(params) :: String.t() when params: %{:account => Stripe.id()}
  defp accounts_plural_endpoint(%{account: id}) do
    "accounts/#{id}/persons"
  end

  @type relationship :: %{
          representative: boolean() | nil,
          director: boolean() | nil,
          owner: boolean() | nil,
          percent_ownership: float() | nil,
          title: String.t() | nil
        }

  @type requirements :: %{
          currently_due: Stripe.List.t(String.t()) | nil,
          eventually_due: Stripe.List.t(String.t()) | nil,
          past_due: Stripe.List.t(String.t()) | nil
        }

  @type verification :: %{
          details: String.t() | nil,
          details_code: String.t() | nil,
          document: verification_document() | nil,
          status: String.t() | nil
        }

  @type verification_document :: %{
          back: String.t() | nil,
          details: String.t() | nil,
          details_code: String.t() | nil,
          front: String.t() | nil
        }

  @type t :: %__MODULE__{
          id: Stripe.id(),
          object: String.t(),
          account: Stripe.id(),
          address: Stripe.Types.address() | nil,
          address_kana: Stripe.Types.japan_address() | nil,
          address_kanji: Stripe.Types.japan_address() | nil,
          created: Stripe.timestamp() | nil,
          dob: Stripe.Types.dob() | nil,
          email: String.t() | nil,
          first_name: String.t() | nil,
          first_name_kana: String.t() | nil,
          first_name_kanji: String.t() | nil,
          gender: String.t() | nil,
          id_number_provided: boolean(),
          last_name: String.t() | nil,
          last_name_kana: String.t() | nil,
          last_name_kanji: String.t() | nil,
          metadata: Stripe.Types.metadata(),
          phone: String.t() | nil,
          relationship: relationship() | nil,
          requirements: requirements() | nil,
          ssn_last_4_provided: boolean(),
          verification: verification() | nil
        }

  defstruct [
    :id,
    :object,
    :account,
    :address,
    :address_kana,
    :address_kanji,
    :created,
    :dob,
    :email,
    :first_name,
    :first_name_kana,
    :first_name_kanji,
    :gender,
    :id_number_provided,
    :last_name,
    :last_name_kana,
    :last_name_kanji,
    :metadata,
    :phone,
    :relationship,
    :requirements,
    :ssn_last_4_provided,
    :verification
  ]

  @type create_params :: %{
          optional(:account) => String.t(),
          optional(:address) => Stripe.Types.address(),
          optional(:address_kana) => Stripe.Types.japan_address(),
          optional(:address_kanji) => Stripe.Types.japan_address(),
          optional(:dob) => Stripe.Types.dob(),
          optional(:email) => String.t(),
          optional(:first_name) => String.t(),
          optional(:first_name_kana) => String.t(),
          optional(:first_name_kanji) => String.t(),
          optional(:gender) => String.t(),
          optional(:id_number) => String.t(),
          optional(:last_name) => String.t(),
          optional(:last_name_kana) => String.t(),
          optional(:last_name_kanji) => String.t(),
          optional(:maiden_name) => String.t(),
          optional(:metadata) => Stripe.Types.metadata(),
          optional(:person_token) => String.t(),
          optional(:phone) => String.t(),
          optional(:relationship) => relationship(),
          optional(:ssn_last_4) => String.t(),
          optional(:verification) => verification()
        }

  @doc """
  Create a person.
  """
  @spec create(params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: create_params()
  def create(params, opts \\ []) do
    endpoint = accounts_plural_endpoint(params)
    updated_params = Map.delete(params, :account)

    new_request(opts)
    |> put_endpoint(endpoint)
    |> put_params(updated_params)
    |> put_method(:post)
    |> make_request()
  end

  @doc """
  Retrieve a person with a specified `id`.
  """
  @spec retrieve(String.t(), params) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{:account => String.t()}
  def retrieve(id, %{account: _} = params, opts \\ []) do
    endpoint = accounts_plural_endpoint(params)

    new_request(opts)
    |> put_endpoint("#{endpoint}/#{id}")
    |> put_method(:get)
    |> make_request()
  end

  @type update_params :: %{
          optional(:account) => String.t(),
          optional(:address) => Stripe.Types.address(),
          optional(:address_kana) => Stripe.Types.japan_address(),
          optional(:address_kanji) => Stripe.Types.japan_address(),
          optional(:dob) => Stripe.Types.dob(),
          optional(:email) => String.t(),
          optional(:first_name) => String.t(),
          optional(:first_name_kana) => String.t(),
          optional(:first_name_kanji) => String.t(),
          optional(:gender) => String.t(),
          optional(:id_number) => String.t(),
          optional(:last_name) => String.t(),
          optional(:last_name_kana) => String.t(),
          optional(:last_name_kanji) => String.t(),
          optional(:maiden_name) => String.t(),
          optional(:metadata) => Stripe.Types.metadata(),
          optional(:person_token) => String.t(),
          optional(:phone) => String.t(),
          optional(:relationship) => relationship(),
          optional(:ssn_last_4) => String.t(),
          optional(:verification) => verification()
        }

  @doc """
  Update a person.

  Takes the `id` and a map of changes.
  """
  @spec update(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: update_params()
  def update(id, params, opts \\ []) do
    endpoint = accounts_plural_endpoint(params)
    updated_params = Map.delete(params, :account)

    new_request(opts)
    |> put_endpoint(endpoint <> "/#{get_id!(id)}")
    |> put_method(:post)
    |> put_params(updated_params)
    |> make_request()
  end

  @doc """
  Delete a person.
  """
  @spec delete(Stripe.id() | t, params, Stripe.options()) :: {:ok, t} | {:error, Stripe.Error.t()}
        when params: %{:account => Stripe.id()}
  def delete(id, params, opts \\ []) do
    endpoint = accounts_plural_endpoint(params)

    new_request(opts)
    |> put_endpoint(endpoint <> "/#{get_id!(id)}")
    |> put_method(:delete)
    |> make_request()
  end

  @doc """
  List all persons on an account.
  """
  @spec list(params, Stripe.options()) :: {:ok, Stripe.List.t(t)} | {:error, Stripe.Error.t()}
        when params: %{
               :account => Stripe.id(),
               optional(:ending_before) => t | Stripe.id(),
               optional(:limit) => 1..100,
               optional(:starting_after) => t | Stripe.id()
             }
  def list(params, opts \\ []) do
    endpoint = accounts_plural_endpoint(params)
    updated_params = Map.delete(params, :account)

    new_request(opts)
    |> prefix_expansions()
    |> put_endpoint(endpoint)
    |> put_method(:get)
    |> put_params(updated_params)
    |> cast_to_id([:ending_before, :starting_after])
    |> make_request()
  end
end

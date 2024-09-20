defmodule Stripe.Person do
  use Stripe.Entity

  @moduledoc "This is an object representing a person associated with a Stripe account.\n\nA platform cannot access a person for an account where [account.controller.requirement_collection](/api/accounts/object#account_object-controller-requirement_collection) is `stripe`, which includes Standard and Express accounts, after creating an Account Link or Account Session to start Connect onboarding.\n\nSee the [Standard onboarding](/connect/standard-accounts) or [Express onboarding](/connect/express-accounts) documentation for information about prefilling information and account onboarding steps. Learn more about [handling identity verification with the API](/connect/handling-api-verification#person-information)."
  (
    defstruct [
      :account,
      :additional_tos_acceptances,
      :address,
      :address_kana,
      :address_kanji,
      :created,
      :dob,
      :email,
      :first_name,
      :first_name_kana,
      :first_name_kanji,
      :full_name_aliases,
      :future_requirements,
      :gender,
      :id,
      :id_number_provided,
      :id_number_secondary_provided,
      :last_name,
      :last_name_kana,
      :last_name_kanji,
      :maiden_name,
      :metadata,
      :nationality,
      :object,
      :phone,
      :political_exposure,
      :registered_address,
      :relationship,
      :requirements,
      :ssn_last_4_provided,
      :verification
    ]

    @typedoc "The `person` type.\n\n  * `account` The account the person is associated with.\n  * `additional_tos_acceptances` \n  * `address` \n  * `address_kana` The Kana variation of the person's address (Japan only).\n  * `address_kanji` The Kanji variation of the person's address (Japan only).\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `dob` \n  * `email` The person's email address.\n  * `first_name` The person's first name.\n  * `first_name_kana` The Kana variation of the person's first name (Japan only).\n  * `first_name_kanji` The Kanji variation of the person's first name (Japan only).\n  * `full_name_aliases` A list of alternate names or aliases that the person is known by.\n  * `future_requirements` Information about the [upcoming new requirements for this person](https://stripe.com/docs/connect/custom-accounts/future-requirements), including what information needs to be collected, and by when.\n  * `gender` The person's gender (International regulations require either \"male\" or \"female\").\n  * `id` Unique identifier for the object.\n  * `id_number_provided` Whether the person's `id_number` was provided. True if either the full ID number was provided or if only the required part of the ID number was provided (ex. last four of an individual's SSN for the US indicated by `ssn_last_4_provided`).\n  * `id_number_secondary_provided` Whether the person's `id_number_secondary` was provided.\n  * `last_name` The person's last name.\n  * `last_name_kana` The Kana variation of the person's last name (Japan only).\n  * `last_name_kanji` The Kanji variation of the person's last name (Japan only).\n  * `maiden_name` The person's maiden name.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `nationality` The country where the person is a national.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `phone` The person's phone number.\n  * `political_exposure` Indicates if the person or any of their representatives, family members, or other closely related persons, declares that they hold or have held an important public job or function, in any jurisdiction.\n  * `registered_address` \n  * `relationship` \n  * `requirements` Information about the requirements for this person, including what information needs to be collected, and by when.\n  * `ssn_last_4_provided` Whether the last four digits of the person's Social Security number have been provided (U.S. only).\n  * `verification` \n"
    @type t :: %__MODULE__{
            account: binary,
            additional_tos_acceptances: term,
            address: term,
            address_kana: term | nil,
            address_kanji: term | nil,
            created: integer,
            dob: term,
            email: binary | nil,
            first_name: binary | nil,
            first_name_kana: binary | nil,
            first_name_kanji: binary | nil,
            full_name_aliases: term,
            future_requirements: term | nil,
            gender: binary | nil,
            id: binary,
            id_number_provided: boolean,
            id_number_secondary_provided: boolean,
            last_name: binary | nil,
            last_name_kana: binary | nil,
            last_name_kanji: binary | nil,
            maiden_name: binary | nil,
            metadata: term,
            nationality: binary | nil,
            object: binary,
            phone: binary | nil,
            political_exposure: binary,
            registered_address: term,
            relationship: term,
            requirements: term | nil,
            ssn_last_4_provided: boolean,
            verification: term
          }
  )

  (
    @typedoc "Details on the legal guardian's acceptance of the main Stripe service agreement."
    @type account :: %{
            optional(:date) => integer,
            optional(:ip) => binary,
            optional(:user_agent) => binary | binary
          }
  )

  (
    @typedoc "A document showing address, either a passport, local ID card, or utility bill from a well-known utility company."
    @type additional_document :: %{optional(:back) => binary, optional(:front) => binary}
  )

  (
    @typedoc "Details on the legal guardian's or authorizer's acceptance of the required Stripe agreements."
    @type additional_tos_acceptances :: %{optional(:account) => account}
  )

  (
    @typedoc "The person's address."
    @type address :: %{
            optional(:city) => binary,
            optional(:country) => binary,
            optional(:line1) => binary,
            optional(:line2) => binary,
            optional(:postal_code) => binary,
            optional(:state) => binary
          }
  )

  (
    @typedoc "The Kana variation of the person's address (Japan only)."
    @type address_kana :: %{
            optional(:city) => binary,
            optional(:country) => binary,
            optional(:line1) => binary,
            optional(:line2) => binary,
            optional(:postal_code) => binary,
            optional(:state) => binary,
            optional(:town) => binary
          }
  )

  (
    @typedoc "The Kanji variation of the person's address (Japan only)."
    @type address_kanji :: %{
            optional(:city) => binary,
            optional(:country) => binary,
            optional(:line1) => binary,
            optional(:line2) => binary,
            optional(:postal_code) => binary,
            optional(:state) => binary,
            optional(:town) => binary
          }
  )

  (
    @typedoc "One or more documents that demonstrate proof that this person is authorized to represent the company."
    @type company_authorization :: %{optional(:files) => list(binary | binary)}
  )

  (
    @typedoc nil
    @type dob :: %{
            optional(:day) => integer,
            optional(:month) => integer,
            optional(:year) => integer
          }
  )

  (
    @typedoc "An identifying document, either a passport or local ID card."
    @type document :: %{optional(:back) => binary, optional(:front) => binary}
  )

  (
    @typedoc "Documents that may be submitted to satisfy various informational requests."
    @type documents :: %{
            optional(:company_authorization) => company_authorization,
            optional(:passport) => passport,
            optional(:visa) => visa
          }
  )

  (
    @typedoc "One or more documents showing the person's passport page with photo and personal data."
    @type passport :: %{optional(:files) => list(binary | binary)}
  )

  (
    @typedoc "The person's registered address."
    @type registered_address :: %{
            optional(:city) => binary,
            optional(:country) => binary,
            optional(:line1) => binary,
            optional(:line2) => binary,
            optional(:postal_code) => binary,
            optional(:state) => binary
          }
  )

  (
    @typedoc nil
    @type relationship :: %{
            optional(:director) => boolean,
            optional(:executive) => boolean,
            optional(:legal_guardian) => boolean,
            optional(:owner) => boolean,
            optional(:representative) => boolean
          }
  )

  (
    @typedoc "The person's verification status."
    @type verification :: %{
            optional(:additional_document) => additional_document,
            optional(:document) => document
          }
  )

  (
    @typedoc "One or more documents showing the person's visa required for living in the country where they are residing."
    @type visa :: %{optional(:files) => list(binary | binary)}
  )

  (
    nil

    @doc "<p>Deletes an existing person’s relationship to the account’s legal entity. Any person with a relationship for an account can be deleted through the API, except if the person is the <code>account_opener</code>. If your integration is using the <code>executive</code> parameter, you cannot delete the only verified <code>executive</code> on file.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/accounts/{account}/persons/{person}`\n"
    (
      @spec delete(account :: binary(), person :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedPerson.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def delete(account, person, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/accounts/{account}/persons/{person}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "account",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "account",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              },
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "person",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "person",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [account, person]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Returns a list of people associated with the account’s legal entity. The people are returned sorted by creation date, with the most recent people appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/accounts/{account}/persons`\n"
    (
      @spec list(
              account :: binary(),
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:relationship) => relationship,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Person.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(account, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/accounts/{account}/persons",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "account",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "account",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [account]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Retrieves an existing person.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/accounts/{account}/persons/{person}`\n"
    (
      @spec retrieve(
              account :: binary(),
              person :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Person.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(account, person, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/accounts/{account}/persons/{person}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "account",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "account",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              },
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "person",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "person",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [account, person]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Creates a new person.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/accounts/{account}/persons`\n"
    (
      @spec create(
              account :: binary(),
              params :: %{
                optional(:additional_tos_acceptances) => additional_tos_acceptances,
                optional(:address) => address,
                optional(:address_kana) => address_kana,
                optional(:address_kanji) => address_kanji,
                optional(:dob) => dob | binary,
                optional(:documents) => documents,
                optional(:email) => binary,
                optional(:expand) => list(binary),
                optional(:first_name) => binary,
                optional(:first_name_kana) => binary,
                optional(:first_name_kanji) => binary,
                optional(:full_name_aliases) => list(binary) | binary,
                optional(:gender) => binary,
                optional(:id_number) => binary,
                optional(:id_number_secondary) => binary,
                optional(:last_name) => binary,
                optional(:last_name_kana) => binary,
                optional(:last_name_kanji) => binary,
                optional(:maiden_name) => binary,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:nationality) => binary,
                optional(:person_token) => binary,
                optional(:phone) => binary,
                optional(:political_exposure) => binary,
                optional(:registered_address) => registered_address,
                optional(:relationship) => relationship,
                optional(:ssn_last_4) => binary,
                optional(:verification) => verification
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Person.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(account, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/accounts/{account}/persons",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "account",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "account",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [account]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Updates an existing person.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/accounts/{account}/persons/{person}`\n"
    (
      @spec update(
              account :: binary(),
              person :: binary(),
              params :: %{
                optional(:additional_tos_acceptances) => additional_tos_acceptances,
                optional(:address) => address,
                optional(:address_kana) => address_kana,
                optional(:address_kanji) => address_kanji,
                optional(:dob) => dob | binary,
                optional(:documents) => documents,
                optional(:email) => binary,
                optional(:expand) => list(binary),
                optional(:first_name) => binary,
                optional(:first_name_kana) => binary,
                optional(:first_name_kanji) => binary,
                optional(:full_name_aliases) => list(binary) | binary,
                optional(:gender) => binary,
                optional(:id_number) => binary,
                optional(:id_number_secondary) => binary,
                optional(:last_name) => binary,
                optional(:last_name_kana) => binary,
                optional(:last_name_kanji) => binary,
                optional(:maiden_name) => binary,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:nationality) => binary,
                optional(:person_token) => binary,
                optional(:phone) => binary,
                optional(:political_exposure) => binary,
                optional(:registered_address) => registered_address,
                optional(:relationship) => relationship,
                optional(:ssn_last_4) => binary,
                optional(:verification) => verification
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Person.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(account, person, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/accounts/{account}/persons/{person}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "account",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "account",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              },
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "person",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "person",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [account, person]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end
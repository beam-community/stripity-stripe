defmodule Stripe.Issuing.PersonalizationDesign do
  use Stripe.Entity

  @moduledoc "A Personalization Design is a logical grouping of a Physical Bundle, card logo, and carrier text that represents a product line."
  (
    defstruct [
      :card_logo,
      :carrier_text,
      :created,
      :id,
      :livemode,
      :lookup_key,
      :metadata,
      :name,
      :object,
      :physical_bundle,
      :preferences,
      :rejection_reasons,
      :status
    ]

    @typedoc "The `issuing.personalization_design` type.\n\n  * `card_logo` The file for the card logo to use with physical bundles that support card logos. Must have a `purpose` value of `issuing_logo`.\n  * `carrier_text` Hash containing carrier text, for use with physical bundles that support carrier text.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `lookup_key` A lookup key used to retrieve personalization designs dynamically from a static string. This may be up to 200 characters.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `name` Friendly display name.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `physical_bundle` The physical bundle object belonging to this personalization design.\n  * `preferences` \n  * `rejection_reasons` \n  * `status` Whether this personalization design can be used to create cards.\n"
    @type t :: %__MODULE__{
            card_logo: (binary | Stripe.File.t()) | nil,
            carrier_text: term | nil,
            created: integer,
            id: binary,
            livemode: boolean,
            lookup_key: binary | nil,
            metadata: term,
            name: binary | nil,
            object: binary,
            physical_bundle: binary | Stripe.Issuing.PhysicalBundle.t(),
            preferences: term,
            rejection_reasons: term,
            status: binary
          }
  )

  (
    @typedoc "Hash containing carrier text, for use with physical bundles that support carrier text."
    @type carrier_text :: %{
            optional(:footer_body) => binary | binary,
            optional(:footer_title) => binary | binary,
            optional(:header_body) => binary | binary,
            optional(:header_title) => binary | binary
          }
  )

  (
    @typedoc nil
    @type preferences :: %{
            optional(:is_default) => boolean,
            optional(:is_platform_default) => boolean
          }
  )

  (
    @typedoc "The reason(s) the personalization design was rejected."
    @type rejection_reasons :: %{
            optional(:card_logo) =>
              list(
                :geographic_location
                | :inappropriate
                | :network_name
                | :non_binary_image
                | :non_fiat_currency
                | :other
                | :other_entity
                | :promotional_material
              ),
            optional(:carrier_text) =>
              list(
                :geographic_location
                | :inappropriate
                | :network_name
                | :non_fiat_currency
                | :other
                | :other_entity
                | :promotional_material
              )
          }
  )

  (
    nil

    @doc "<p>Returns a list of personalization design objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/issuing/personalization_designs`\n"
    (
      @spec list(
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:lookup_keys) => list(binary),
                optional(:preferences) => preferences,
                optional(:starting_after) => binary,
                optional(:status) => :active | :inactive | :rejected | :review
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Issuing.PersonalizationDesign.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params("/v1/issuing/personalization_designs", [], [])

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

    @doc "<p>Retrieves a personalization design object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/issuing/personalization_designs/{personalization_design}`\n"
    (
      @spec retrieve(
              personalization_design :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.PersonalizationDesign.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(personalization_design, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/personalization_designs/{personalization_design}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "personalization_design",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "personalization_design",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [personalization_design]
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

    @doc "<p>Creates a personalization design object.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/issuing/personalization_designs`\n"
    (
      @spec create(
              params :: %{
                optional(:card_logo) => binary,
                optional(:carrier_text) => carrier_text,
                optional(:expand) => list(binary),
                optional(:lookup_key) => binary,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:name) => binary,
                optional(:physical_bundle) => binary,
                optional(:preferences) => preferences,
                optional(:transfer_lookup_key) => boolean
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.PersonalizationDesign.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params("/v1/issuing/personalization_designs", [], [])

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

    @doc "<p>Updates a card personalization object.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/issuing/personalization_designs/{personalization_design}`\n"
    (
      @spec update(
              personalization_design :: binary(),
              params :: %{
                optional(:card_logo) => binary | binary,
                optional(:carrier_text) => carrier_text | binary,
                optional(:expand) => list(binary),
                optional(:lookup_key) => binary | binary,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:name) => binary | binary,
                optional(:physical_bundle) => binary,
                optional(:preferences) => preferences,
                optional(:transfer_lookup_key) => boolean
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.PersonalizationDesign.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(personalization_design, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/issuing/personalization_designs/{personalization_design}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "personalization_design",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "personalization_design",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [personalization_design]
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

    @doc "<p>Updates the <code>status</code> of the specified testmode personalization design object to <code>active</code>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/issuing/personalization_designs/{personalization_design}/activate`\n"
    (
      @spec activate(
              personalization_design :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.PersonalizationDesign.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def activate(personalization_design, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/issuing/personalization_designs/{personalization_design}/activate",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "personalization_design",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "personalization_design",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [personalization_design]
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

    @doc "<p>Updates the <code>status</code> of the specified testmode personalization design object to <code>inactive</code>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/issuing/personalization_designs/{personalization_design}/deactivate`\n"
    (
      @spec deactivate(
              personalization_design :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.PersonalizationDesign.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def deactivate(personalization_design, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/issuing/personalization_designs/{personalization_design}/deactivate",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "personalization_design",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "personalization_design",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [personalization_design]
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

    @doc "<p>Updates the <code>status</code> of the specified testmode personalization design object to <code>rejected</code>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/issuing/personalization_designs/{personalization_design}/reject`\n"
    (
      @spec reject(
              personalization_design :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:rejection_reasons) => rejection_reasons
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Issuing.PersonalizationDesign.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def reject(personalization_design, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/issuing/personalization_designs/{personalization_design}/reject",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "personalization_design",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "personalization_design",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [personalization_design]
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

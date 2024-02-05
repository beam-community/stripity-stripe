defmodule Stripe.Radar.ValueList do
  use Stripe.Entity

  @moduledoc "Value lists allow you to group values together which can then be referenced in rules.\n\nRelated guide: [Default Stripe lists](https://stripe.com/docs/radar/lists#managing-list-items)"
  (
    defstruct [
      :alias,
      :created,
      :created_by,
      :id,
      :item_type,
      :list_items,
      :livemode,
      :metadata,
      :name,
      :object
    ]

    @typedoc "The `radar.value_list` type.\n\n  * `alias` The name of the value list for use in rules.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `created_by` The name or email address of the user who created this value list.\n  * `id` Unique identifier for the object.\n  * `item_type` The type of items in the value list. One of `card_fingerprint`, `us_bank_account_fingerprint`, `sepa_debit_fingerprint`, `card_bin`, `email`, `ip_address`, `country`, `string`, `case_sensitive_string`, or `customer_id`.\n  * `list_items` List of items contained within this value list.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `name` The name of the value list.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n"
    @type t :: %__MODULE__{
            alias: binary,
            created: integer,
            created_by: binary,
            id: binary,
            item_type: binary,
            list_items: term,
            livemode: boolean,
            metadata: term,
            name: binary,
            object: binary
          }
  )

  (
    @typedoc nil
    @type created :: %{
            optional(:gt) => integer,
            optional(:gte) => integer,
            optional(:lt) => integer,
            optional(:lte) => integer
          }
  )

  (
    nil

    @doc "<p>Deletes a <code>ValueList</code> object, also deleting any items contained within the value list. To be deleted, a value list must not be referenced in any rules.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/radar/value_lists/{value_list}`\n"
    (
      @spec delete(value_list :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedRadar.ValueList.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def delete(value_list, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/radar/value_lists/{value_list}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "value_list",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "value_list",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [value_list]
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

    @doc "<p>Returns a list of <code>ValueList</code> objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/radar/value_lists`\n"
    (
      @spec list(
              params :: %{
                optional(:alias) => binary,
                optional(:contains) => binary,
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Radar.ValueList.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/radar/value_lists", [], [])

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

    @doc "<p>Retrieves a <code>ValueList</code> object.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/radar/value_lists/{value_list}`\n"
    (
      @spec retrieve(
              value_list :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Radar.ValueList.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(value_list, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/radar/value_lists/{value_list}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "value_list",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "value_list",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [value_list]
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

    @doc "<p>Creates a new <code>ValueList</code> object, which can then be referenced in rules.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/radar/value_lists`\n"
    (
      @spec create(
              params :: %{
                optional(:alias) => binary,
                optional(:expand) => list(binary),
                optional(:item_type) =>
                  :card_bin
                  | :card_fingerprint
                  | :case_sensitive_string
                  | :country
                  | :customer_id
                  | :email
                  | :ip_address
                  | :sepa_debit_fingerprint
                  | binary
                  | :us_bank_account_fingerprint,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:name) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Radar.ValueList.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/radar/value_lists", [], [])

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

    @doc "<p>Updates a <code>ValueList</code> object by setting the values of the parameters passed. Any parameters not provided will be left unchanged. Note that <code>item_type</code> is immutable.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/radar/value_lists/{value_list}`\n"
    (
      @spec update(
              value_list :: binary(),
              params :: %{
                optional(:alias) => binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary},
                optional(:name) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Radar.ValueList.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(value_list, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/radar/value_lists/{value_list}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "value_list",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "value_list",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [value_list]
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

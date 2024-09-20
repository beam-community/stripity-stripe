defmodule Stripe.Entitlements.Feature do
  use Stripe.Entity

  @moduledoc "A feature represents a monetizable ability or functionality in your system.\nFeatures can be assigned to products, and when those products are purchased, Stripe will create an entitlement to the feature for the purchasing customer."
  (
    defstruct [:active, :id, :livemode, :lookup_key, :metadata, :name, :object]

    @typedoc "The `entitlements.feature` type.\n\n  * `active` Inactive features cannot be attached to new products and will not be returned from the features list endpoint.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `lookup_key` A unique key you provide as your own system identifier. This may be up to 80 characters.\n  * `metadata` Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `name` The feature's name, for your own purpose, not meant to be displayable to the customer.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n"
    @type t :: %__MODULE__{
            active: boolean,
            id: binary,
            livemode: boolean,
            lookup_key: binary,
            metadata: term,
            name: binary,
            object: binary
          }
  )

  (
    nil

    @doc "<p>Retrieve a list of features</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/entitlements/features`\n"
    (
      @spec list(
              params :: %{
                optional(:archived) => boolean,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:lookup_key) => binary,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Entitlements.Feature.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/entitlements/features", [], [])

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

    @doc "<p>Retrieves a feature</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/entitlements/features/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Entitlements.Feature.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/entitlements/features/{id}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "id",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "id",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [id]
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

    @doc "<p>Creates a feature</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/entitlements/features`\n"
    (
      @spec create(
              params :: %{
                optional(:expand) => list(binary),
                optional(:lookup_key) => binary,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:name) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Entitlements.Feature.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/entitlements/features", [], [])

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

    @doc "<p>Update a feature’s metadata or permanently deactivate it.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/entitlements/features/{id}`\n"
    (
      @spec update(
              id :: binary(),
              params :: %{
                optional(:active) => boolean,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:name) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Entitlements.Feature.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/entitlements/features/{id}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "id",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "id",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [id]
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

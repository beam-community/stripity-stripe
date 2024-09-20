defmodule Stripe.ProductFeature do
  use Stripe.Entity

  @moduledoc "A product_feature represents an attachment between a feature and a product.\nWhen a product is purchased that has a feature attached, Stripe will create an entitlement to the feature for the purchasing customer."
  (
    defstruct [:entitlement_feature, :id, :livemode, :object]

    @typedoc "The `product_feature` type.\n\n  * `entitlement_feature` \n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n"
    @type t :: %__MODULE__{
            entitlement_feature: Stripe.Entitlements.Feature.t(),
            id: binary,
            livemode: boolean,
            object: binary
          }
  )

  (
    nil

    @doc "<p>Deletes the feature attachment to a product</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/products/{product}/features/{id}`\n"
    (
      @spec delete(id :: binary(), product :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedProductFeature.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def delete(id, product, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/products/{product}/features/{id}",
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
              },
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "product",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "product",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [id, product]
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

    @doc "<p>Retrieve a list of features for a product</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/products/{product}/features`\n"
    (
      @spec list(
              product :: binary(),
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.ProductFeature.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(product, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/products/{product}/features",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "product",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "product",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [product]
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

    @doc "<p>Retrieves a product_feature, which represents a feature attachment to a product</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/products/{product}/features/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              product :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.ProductFeature.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(id, product, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/products/{product}/features/{id}",
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
              },
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "product",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "product",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [id, product]
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

    @doc "<p>Creates a product_feature, which represents a feature attachment to a product</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/products/{product}/features`\n"
    (
      @spec create(
              product :: binary(),
              params :: %{
                optional(:entitlement_feature) => binary,
                optional(:expand) => list(binary)
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.ProductFeature.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(product, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/products/{product}/features",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "product",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "product",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [product]
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

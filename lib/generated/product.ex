defmodule Stripe.Product do
  use Stripe.Entity

  @moduledoc "Products describe the specific goods or services you offer to your customers.\nFor example, you might offer a Standard and Premium version of your goods or service; each version would be a separate Product.\nThey can be used in conjunction with [Prices](https://stripe.com/docs/api#prices) to configure pricing in Payment Links, Checkout, and Subscriptions.\n\nRelated guides: [Set up a subscription](https://stripe.com/docs/billing/subscriptions/set-up-subscription),\n[share a Payment Link](https://stripe.com/docs/payment-links),\n[accept payments with Checkout](https://stripe.com/docs/payments/accept-a-payment#create-product-prices-upfront),\nand more about [Products and Prices](https://stripe.com/docs/products-prices/overview)"
  (
    defstruct [
      :active,
      :created,
      :default_price,
      :description,
      :features,
      :id,
      :images,
      :livemode,
      :metadata,
      :name,
      :object,
      :package_dimensions,
      :shippable,
      :statement_descriptor,
      :tax_code,
      :type,
      :unit_label,
      :updated,
      :url
    ]

    @typedoc "The `product` type.\n\n  * `active` Whether the product is currently available for purchase.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `default_price` The ID of the [Price](https://stripe.com/docs/api/prices) object that is the default price for this product.\n  * `description` The product's description, meant to be displayable to the customer. Use this field to optionally store a long form explanation of the product being sold for your own rendering purposes.\n  * `features` A list of up to 15 features for this product. These are displayed in [pricing tables](https://stripe.com/docs/payments/checkout/pricing-table).\n  * `id` Unique identifier for the object.\n  * `images` A list of up to 8 URLs of images for this product, meant to be displayable to the customer.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `name` The product's name, meant to be displayable to the customer.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `package_dimensions` The dimensions of this product for shipping purposes.\n  * `shippable` Whether this product is shipped (i.e., physical goods).\n  * `statement_descriptor` Extra information about a product which will appear on your customer's credit card statement. In the case that multiple products are billed at once, the first statement descriptor will be used.\n  * `tax_code` A [tax code](https://stripe.com/docs/tax/tax-categories) ID.\n  * `type` The type of the product. The product is either of type `good`, which is eligible for use with Orders and SKUs, or `service`, which is eligible for use with Subscriptions and Plans.\n  * `unit_label` A label that represents units of this product. When set, this will be included in customers' receipts, invoices, Checkout, and the customer portal.\n  * `updated` Time at which the object was last updated. Measured in seconds since the Unix epoch.\n  * `url` A URL of a publicly-accessible webpage for this product.\n"
    @type t :: %__MODULE__{
            active: boolean,
            created: integer,
            default_price: (binary | Stripe.Price.t()) | nil,
            description: binary | nil,
            features: term,
            id: binary,
            images: term,
            livemode: boolean,
            metadata: term,
            name: binary,
            object: binary,
            package_dimensions: term | nil,
            shippable: boolean | nil,
            statement_descriptor: binary | nil,
            tax_code: (binary | Stripe.TaxCode.t()) | nil,
            type: binary,
            unit_label: binary | nil,
            updated: integer,
            url: binary | nil
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
    @typedoc "Data used to generate a new [Price](https://stripe.com/docs/api/prices) object. This Price will be set as the default price for this product."
    @type default_price_data :: %{
            optional(:currency) => binary,
            optional(:currency_options) => map(),
            optional(:recurring) => recurring,
            optional(:tax_behavior) => :exclusive | :inclusive | :unspecified,
            optional(:unit_amount) => integer,
            optional(:unit_amount_decimal) => binary
          }
  )

  (
    @typedoc nil
    @type features :: %{optional(:name) => binary}
  )

  (
    @typedoc "The dimensions of this product for shipping purposes."
    @type package_dimensions :: %{
            optional(:height) => number,
            optional(:length) => number,
            optional(:weight) => number,
            optional(:width) => number
          }
  )

  (
    @typedoc "The recurring components of a price such as `interval` and `interval_count`."
    @type recurring :: %{
            optional(:interval) => :day | :month | :week | :year,
            optional(:interval_count) => integer
          }
  )

  (
    nil

    @doc "<p>Delete a product. Deleting a product is only possible if it has no prices associated with it. Additionally, deleting a product with <code>type=good</code> is only possible if it has no SKUs associated with it.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/products/{id}`\n"
    (
      @spec delete(id :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedProduct.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def delete(id, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/products/{id}",
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
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Returns a list of your products. The products are returned sorted by creation date, with the most recently created products appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/products`\n"
    (
      @spec list(
              params :: %{
                optional(:active) => boolean,
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:ids) => list(binary),
                optional(:limit) => integer,
                optional(:shippable) => boolean,
                optional(:starting_after) => binary,
                optional(:type) => :good | :service,
                optional(:url) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Product.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/products", [], [])

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

    @doc "<p>Retrieves the details of an existing product. Supply the unique product ID from either a product creation request or the product list, and Stripe will return the corresponding product information.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/products/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Product.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/products/{id}",
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

    @doc "<p>Search for products you’ve previously created using Stripe’s <a href=\"/docs/search#search-query-language\">Search Query Language</a>.\nDon’t use search in read-after-write flows where strict consistency is necessary. Under normal operating\nconditions, data is searchable in less than a minute. Occasionally, propagation of new or updated data can be up\nto an hour behind during outages. Search functionality is not available to merchants in India.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/products/search`\n"
    (
      @spec search(
              params :: %{
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:page) => binary,
                optional(:query) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.SearchResult.t(Stripe.Product.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def search(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/products/search", [], [])

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

    @doc "<p>Creates a new product object.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/products`\n"
    (
      @spec create(
              params :: %{
                optional(:active) => boolean,
                optional(:default_price_data) => default_price_data,
                optional(:description) => binary,
                optional(:expand) => list(binary),
                optional(:features) => list(features),
                optional(:id) => binary,
                optional(:images) => list(binary),
                optional(:metadata) => %{optional(binary) => binary},
                optional(:name) => binary,
                optional(:package_dimensions) => package_dimensions,
                optional(:shippable) => boolean,
                optional(:statement_descriptor) => binary,
                optional(:tax_code) => binary,
                optional(:type) => :good | :service,
                optional(:unit_label) => binary,
                optional(:url) => binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Product.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/products", [], [])

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

    @doc "<p>Updates the specific product by setting the values of the parameters passed. Any parameters not provided will be left unchanged.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/products/{id}`\n"
    (
      @spec update(
              id :: binary(),
              params :: %{
                optional(:active) => boolean,
                optional(:default_price) => binary,
                optional(:description) => binary | binary,
                optional(:expand) => list(binary),
                optional(:features) => list(features) | binary,
                optional(:images) => list(binary) | binary,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:name) => binary,
                optional(:package_dimensions) => package_dimensions | binary,
                optional(:shippable) => boolean,
                optional(:statement_descriptor) => binary,
                optional(:tax_code) => binary | binary,
                optional(:unit_label) => binary | binary,
                optional(:url) => binary | binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Product.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/products/{id}",
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

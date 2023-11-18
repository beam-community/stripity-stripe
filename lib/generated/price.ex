defmodule Stripe.Price do
  use Stripe.Entity

  @moduledoc "Prices define the unit cost, currency, and (optional) billing cycle for both recurring and one-time purchases of products.\n[Products](https://stripe.com/docs/api#products) help you track inventory or provisioning, and prices help you track payment terms. Different physical goods or levels of service should be represented by products, and pricing options should be represented by prices. This approach lets you change prices without having to change your provisioning scheme.\n\nFor example, you might have a single \"gold\" product that has prices for $10/month, $100/year, and €9 once.\n\nRelated guides: [Set up a subscription](https://stripe.com/docs/billing/subscriptions/set-up-subscription), [create an invoice](https://stripe.com/docs/billing/invoices/create), and more about [products and prices](https://stripe.com/docs/products-prices/overview)."
  (
    defstruct [
      :active,
      :billing_scheme,
      :created,
      :currency,
      :currency_options,
      :custom_unit_amount,
      :id,
      :livemode,
      :lookup_key,
      :metadata,
      :nickname,
      :object,
      :product,
      :recurring,
      :tax_behavior,
      :tiers,
      :tiers_mode,
      :transform_quantity,
      :type,
      :unit_amount,
      :unit_amount_decimal
    ]

    @typedoc "The `price` type.\n\n  * `active` Whether the price can be used for new purchases.\n  * `billing_scheme` Describes how to compute the price per period. Either `per_unit` or `tiered`. `per_unit` indicates that the fixed amount (specified in `unit_amount` or `unit_amount_decimal`) will be charged per unit in `quantity` (for prices with `usage_type=licensed`), or per unit of total usage (for prices with `usage_type=metered`). `tiered` indicates that the unit pricing will be computed using a tiering strategy as defined using the `tiers` and `tiers_mode` attributes.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `currency_options` Prices defined in each available currency option. Each key must be a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html) and a [supported currency](https://stripe.com/docs/currencies).\n  * `custom_unit_amount` When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment Links.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `lookup_key` A lookup key used to retrieve prices dynamically from a static string. This may be up to 200 characters.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `nickname` A brief description of the price, hidden from customers.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `product` The ID of the product this price is associated with.\n  * `recurring` The recurring components of a price such as `interval` and `usage_type`.\n  * `tax_behavior` Only required if a [default tax behavior](https://stripe.com/docs/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.\n  * `tiers` Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to `tiered`. See also the documentation for `billing_scheme`.\n  * `tiers_mode` Defines if the tiering price should be `graduated` or `volume` based. In `volume`-based tiering, the maximum quantity within a period determines the per unit price. In `graduated` tiering, pricing can change as the quantity grows.\n  * `transform_quantity` Apply a transformation to the reported usage or set quantity before computing the amount billed. Cannot be combined with `tiers`.\n  * `type` One of `one_time` or `recurring` depending on whether the price is for a one-time purchase or a recurring (subscription) purchase.\n  * `unit_amount` The unit amount in cents (or local equivalent) to be charged, represented as a whole integer if possible. Only set if `billing_scheme=per_unit`.\n  * `unit_amount_decimal` The unit amount in cents (or local equivalent) to be charged, represented as a decimal string with at most 12 decimal places. Only set if `billing_scheme=per_unit`.\n"
    @type t :: %__MODULE__{
            active: boolean,
            billing_scheme: binary,
            created: integer,
            currency: binary,
            currency_options: term,
            custom_unit_amount: term | nil,
            id: binary,
            livemode: boolean,
            lookup_key: binary | nil,
            metadata: term,
            nickname: binary | nil,
            object: binary,
            product: binary | Stripe.Product.t() | Stripe.DeletedProduct.t(),
            recurring: term | nil,
            tax_behavior: binary | nil,
            tiers: term,
            tiers_mode: binary | nil,
            transform_quantity: term | nil,
            type: binary,
            unit_amount: integer | nil,
            unit_amount_decimal: binary | nil
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
    @typedoc "When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment Links."
    @type custom_unit_amount :: %{
            optional(:enabled) => boolean,
            optional(:maximum) => integer,
            optional(:minimum) => integer,
            optional(:preset) => integer
          }
  )

  (
    @typedoc "These fields can be used to create a new product that this price will belong to."
    @type product_data :: %{
            optional(:active) => boolean,
            optional(:id) => binary,
            optional(:metadata) => %{optional(binary) => binary},
            optional(:name) => binary,
            optional(:statement_descriptor) => binary,
            optional(:tax_code) => binary,
            optional(:unit_label) => binary
          }
  )

  (
    @typedoc nil
    @type recurring :: %{
            optional(:interval) => :day | :month | :week | :year,
            optional(:usage_type) => :licensed | :metered
          }
  )

  (
    @typedoc nil
    @type tiers :: %{
            optional(:flat_amount) => integer,
            optional(:flat_amount_decimal) => binary,
            optional(:unit_amount) => integer,
            optional(:unit_amount_decimal) => binary,
            optional(:up_to) => :inf | integer
          }
  )

  (
    @typedoc "Apply a transformation to the reported usage or set quantity before computing the billed price. Cannot be combined with `tiers`."
    @type transform_quantity :: %{
            optional(:divide_by) => integer,
            optional(:round) => :down | :up
          }
  )

  (
    nil

    @doc "<p>Search for prices you’ve previously created using Stripe’s <a href=\"/docs/search#search-query-language\">Search Query Language</a>.\nDon’t use search in read-after-write flows where strict consistency is necessary. Under normal operating\nconditions, data is searchable in less than a minute. Occasionally, propagation of new or updated data can be up\nto an hour behind during outages. Search functionality is not available to merchants in India.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/prices/search`\n"
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
              {:ok, Stripe.SearchResult.t(Stripe.Price.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def search(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/prices/search", [], [])

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

    @doc "<p>Returns a list of your active prices, excluding <a href=\"/docs/products-prices/pricing-models#inline-pricing\">inline prices</a>. For the list of inactive prices, set <code>active</code> to false.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/prices`\n"
    (
      @spec list(
              params :: %{
                optional(:active) => boolean,
                optional(:created) => created | integer,
                optional(:currency) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:lookup_keys) => list(binary),
                optional(:product) => binary,
                optional(:recurring) => recurring,
                optional(:starting_after) => binary,
                optional(:type) => :one_time | :recurring
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Price.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/prices", [], [])

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

    @doc "<p>Creates a new price for an existing product. The price can be recurring or one-time.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/prices`\n"
    (
      @spec create(
              params :: %{
                optional(:active) => boolean,
                optional(:billing_scheme) => :per_unit | :tiered,
                optional(:currency) => binary,
                optional(:currency_options) => map(),
                optional(:custom_unit_amount) => custom_unit_amount,
                optional(:expand) => list(binary),
                optional(:lookup_key) => binary,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:nickname) => binary,
                optional(:product) => binary,
                optional(:product_data) => product_data,
                optional(:recurring) => recurring,
                optional(:tax_behavior) => :exclusive | :inclusive | :unspecified,
                optional(:tiers) => list(tiers),
                optional(:tiers_mode) => :graduated | :volume,
                optional(:transfer_lookup_key) => boolean,
                optional(:transform_quantity) => transform_quantity,
                optional(:unit_amount) => integer,
                optional(:unit_amount_decimal) => binary
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Price.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/prices", [], [])

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

    @doc "<p>Retrieves the price with the given ID.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/prices/{price}`\n"
    (
      @spec retrieve(
              price :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Price.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(price, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/prices/{price}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "price",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "price",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [price]
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

    @doc "<p>Updates the specified price by setting the values of the parameters passed. Any parameters not provided are left unchanged.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/prices/{price}`\n"
    (
      @spec update(
              price :: binary(),
              params :: %{
                optional(:active) => boolean,
                optional(:currency_options) => map() | binary,
                optional(:expand) => list(binary),
                optional(:lookup_key) => binary,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:nickname) => binary,
                optional(:tax_behavior) => :exclusive | :inclusive | :unspecified,
                optional(:transfer_lookup_key) => boolean
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Price.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(price, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/prices/{price}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "price",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "price",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [price]
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

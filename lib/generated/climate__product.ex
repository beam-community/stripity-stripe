defmodule Stripe.Climate.Product do
  use Stripe.Entity

  @moduledoc "A Climate product represents a type of carbon removal unit available for reservation.\nYou can retrieve it to see the current price and availability."
  (
    defstruct [
      :created,
      :current_prices_per_metric_ton,
      :delivery_year,
      :id,
      :livemode,
      :metric_tons_available,
      :name,
      :object,
      :suppliers
    ]

    @typedoc "The `climate.product` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `current_prices_per_metric_ton` Current prices for a metric ton of carbon removal in a currency's smallest unit.\n  * `delivery_year` The year in which the carbon removal is expected to be delivered.\n  * `id` Unique identifier for the object. For convenience, Climate product IDs are human-readable strings\nthat start with `climsku_`. See [carbon removal inventory](https://stripe.com/docs/climate/orders/carbon-removal-inventory)\nfor a list of available carbon removal products.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metric_tons_available` The quantity of metric tons available for reservation.\n  * `name` The Climate product's name.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `suppliers` The carbon removal suppliers that fulfill orders for this Climate product.\n"
    @type t :: %__MODULE__{
            created: integer,
            current_prices_per_metric_ton: term,
            delivery_year: integer | nil,
            id: binary,
            livemode: boolean,
            metric_tons_available: binary,
            name: binary,
            object: binary,
            suppliers: term
          }
  )

  (
    nil

    @doc "<p>Retrieves the details of a Climate product with the given ID.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/climate/products/{product}`\n"
    (
      @spec retrieve(
              product :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Climate.Product.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(product, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/climate/products/{product}",
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

    @doc "<p>Lists all available Climate product objects.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/climate/products`\n"
    (
      @spec list(
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Climate.Product.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/climate/products", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )
end

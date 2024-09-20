defmodule Stripe.Climate.Order do
  use Stripe.Entity

  @moduledoc "Orders represent your intent to purchase a particular Climate product. When you create an order, the\npayment is deducted from your merchant balance."
  (
    defstruct [
      :amount_fees,
      :amount_subtotal,
      :amount_total,
      :beneficiary,
      :canceled_at,
      :cancellation_reason,
      :certificate,
      :confirmed_at,
      :created,
      :currency,
      :delayed_at,
      :delivered_at,
      :delivery_details,
      :expected_delivery_year,
      :id,
      :livemode,
      :metadata,
      :metric_tons,
      :object,
      :product,
      :product_substituted_at,
      :status
    ]

    @typedoc "The `climate.order` type.\n\n  * `amount_fees` Total amount of [Frontier](https://frontierclimate.com/)'s service fees in the currency's smallest unit.\n  * `amount_subtotal` Total amount of the carbon removal in the currency's smallest unit.\n  * `amount_total` Total amount of the order including fees in the currency's smallest unit.\n  * `beneficiary` \n  * `canceled_at` Time at which the order was canceled. Measured in seconds since the Unix epoch.\n  * `cancellation_reason` Reason for the cancellation of this order.\n  * `certificate` For delivered orders, a URL to a delivery certificate for the order.\n  * `confirmed_at` Time at which the order was confirmed. Measured in seconds since the Unix epoch.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase, representing the currency for this order.\n  * `delayed_at` Time at which the order's expected_delivery_year was delayed. Measured in seconds since the Unix epoch.\n  * `delivered_at` Time at which the order was delivered. Measured in seconds since the Unix epoch.\n  * `delivery_details` Details about the delivery of carbon removal for this order.\n  * `expected_delivery_year` The year this order is expected to be delivered.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `metric_tons` Quantity of carbon removal that is included in this order.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `product` Unique ID for the Climate `Product` this order is purchasing.\n  * `product_substituted_at` Time at which the order's product was substituted for a different product. Measured in seconds since the Unix epoch.\n  * `status` The current status of this order.\n"
    @type t :: %__MODULE__{
            amount_fees: integer,
            amount_subtotal: integer,
            amount_total: integer,
            beneficiary: term,
            canceled_at: integer | nil,
            cancellation_reason: binary | nil,
            certificate: binary | nil,
            confirmed_at: integer | nil,
            created: integer,
            currency: binary,
            delayed_at: integer | nil,
            delivered_at: integer | nil,
            delivery_details: term,
            expected_delivery_year: integer,
            id: binary,
            livemode: boolean,
            metadata: term,
            metric_tons: binary,
            object: binary,
            product: binary | Stripe.Climate.Product.t(),
            product_substituted_at: integer | nil,
            status: binary
          }
  )

  (
    @typedoc "Publicly sharable reference for the end beneficiary of carbon removal. Assumed to be the Stripe account if not set."
    @type beneficiary :: %{optional(:public_name) => binary}
  )

  (
    nil

    @doc "<p>Lists all Climate order objects. The orders are returned sorted by creation date, with the\nmost recently created orders appearing first.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/climate/orders`\n"
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
              {:ok, Stripe.List.t(Stripe.Climate.Order.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/climate/orders", [], [])

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

    @doc "<p>Retrieves the details of a Climate order object with the given ID.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/climate/orders/{order}`\n"
    (
      @spec retrieve(
              order :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Climate.Order.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(order, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/climate/orders/{order}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "order",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "order",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [order]
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

    @doc "<p>Creates a Climate order object for a given Climate product. The order will be processed immediately\nafter creation and payment will be deducted your Stripe balance.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/climate/orders`\n"
    (
      @spec create(
              params :: %{
                optional(:amount) => integer,
                optional(:beneficiary) => beneficiary,
                optional(:currency) => binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary},
                optional(:metric_tons) => binary,
                optional(:product) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Climate.Order.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/climate/orders", [], [])

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

    @doc "<p>Updates the specified order by setting the values of the parameters passed.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/climate/orders/{order}`\n"
    (
      @spec update(
              order :: binary(),
              params :: %{
                optional(:beneficiary) => beneficiary | binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary}
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Climate.Order.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(order, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/climate/orders/{order}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "order",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "order",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [order]
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

    @doc "<p>Cancels a Climate order. You can cancel an order within 24 hours of creation. Stripe refunds the\nreservation <code>amount_subtotal</code>, but not the <code>amount_fees</code> for user-triggered cancellations. Frontier\nmight cancel reservations if suppliers fail to deliver. If Frontier cancels the reservation, Stripe\nprovides 90 days advance notice and refunds the <code>amount_total</code>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/climate/orders/{order}/cancel`\n"
    (
      @spec cancel(
              order :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Climate.Order.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def cancel(order, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/climate/orders/{order}/cancel",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "order",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "order",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [order]
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

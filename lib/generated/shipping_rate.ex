defmodule Stripe.ShippingRate do
  use Stripe.Entity

  @moduledoc "Shipping rates describe the price of shipping presented to your customers and\napplied to a purchase. For more information, see [Charge for shipping](https://stripe.com/docs/payments/during-payment/charge-shipping)."
  (
    defstruct [
      :active,
      :created,
      :delivery_estimate,
      :display_name,
      :fixed_amount,
      :id,
      :livemode,
      :metadata,
      :object,
      :tax_behavior,
      :tax_code,
      :type
    ]

    @typedoc "The `shipping_rate` type.\n\n  * `active` Whether the shipping rate can be used for new purchases. Defaults to `true`.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `delivery_estimate` The estimated range for how long shipping will take, meant to be displayable to the customer. This will appear on CheckoutSessions.\n  * `display_name` The name of the shipping rate, meant to be displayable to the customer. This will appear on CheckoutSessions.\n  * `fixed_amount` \n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `tax_behavior` Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`.\n  * `tax_code` A [tax code](https://stripe.com/docs/tax/tax-categories) ID. The Shipping tax code is `txcd_92010001`.\n  * `type` The type of calculation to use on the shipping rate.\n"
    @type t :: %__MODULE__{
            active: boolean,
            created: integer,
            delivery_estimate: term | nil,
            display_name: binary | nil,
            fixed_amount: term,
            id: binary,
            livemode: boolean,
            metadata: term,
            object: binary,
            tax_behavior: binary | nil,
            tax_code: (binary | Stripe.TaxCode.t()) | nil,
            type: binary
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
    @typedoc "The estimated range for how long shipping will take, meant to be displayable to the customer. This will appear on CheckoutSessions."
    @type delivery_estimate :: %{optional(:maximum) => maximum, optional(:minimum) => minimum}
  )

  (
    @typedoc "Describes a fixed amount to charge for shipping. Must be present if type is `fixed_amount`."
    @type fixed_amount :: %{
            optional(:amount) => integer,
            optional(:currency) => binary,
            optional(:currency_options) => map()
          }
  )

  (
    @typedoc "The upper bound of the estimated range. If empty, represents no upper bound i.e., infinite."
    @type maximum :: %{
            optional(:unit) => :business_day | :day | :hour | :month | :week,
            optional(:value) => integer
          }
  )

  (
    @typedoc "The lower bound of the estimated range. If empty, represents no lower bound."
    @type minimum :: %{
            optional(:unit) => :business_day | :day | :hour | :month | :week,
            optional(:value) => integer
          }
  )

  (
    nil

    @doc "<p>Returns a list of your shipping rates.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/shipping_rates`\n"
    (
      @spec list(
              params :: %{
                optional(:active) => boolean,
                optional(:created) => created | integer,
                optional(:currency) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.ShippingRate.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/shipping_rates", [], [])

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

    @doc "<p>Returns the shipping rate object with the given ID.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/shipping_rates/{shipping_rate_token}`\n"
    (
      @spec retrieve(
              shipping_rate_token :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.ShippingRate.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(shipping_rate_token, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/shipping_rates/{shipping_rate_token}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "shipping_rate_token",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "shipping_rate_token",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [shipping_rate_token]
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

    @doc "<p>Creates a new shipping rate object.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/shipping_rates`\n"
    (
      @spec create(
              params :: %{
                optional(:delivery_estimate) => delivery_estimate,
                optional(:display_name) => binary,
                optional(:expand) => list(binary),
                optional(:fixed_amount) => fixed_amount,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:tax_behavior) => :exclusive | :inclusive | :unspecified,
                optional(:tax_code) => binary,
                optional(:type) => :fixed_amount
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.ShippingRate.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/shipping_rates", [], [])

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

    @doc "<p>Updates an existing shipping rate object.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/shipping_rates/{shipping_rate_token}`\n"
    (
      @spec update(
              shipping_rate_token :: binary(),
              params :: %{
                optional(:active) => boolean,
                optional(:expand) => list(binary),
                optional(:fixed_amount) => fixed_amount,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:tax_behavior) => :exclusive | :inclusive | :unspecified
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.ShippingRate.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(shipping_rate_token, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/shipping_rates/{shipping_rate_token}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "shipping_rate_token",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "shipping_rate_token",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [shipping_rate_token]
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

defmodule Stripe.PromotionCode do
  use Stripe.Entity

  @moduledoc "A Promotion Code represents a customer-redeemable code for a [coupon](https://stripe.com/docs/api#coupons). It can be used to\ncreate multiple codes for a single coupon."
  (
    defstruct [
      :active,
      :code,
      :coupon,
      :created,
      :customer,
      :expires_at,
      :id,
      :livemode,
      :max_redemptions,
      :metadata,
      :object,
      :restrictions,
      :times_redeemed
    ]

    @typedoc "The `promotion_code` type.\n\n  * `active` Whether the promotion code is currently active. A promotion code is only active if the coupon is also valid.\n  * `code` The customer-facing code. Regardless of case, this code must be unique across all active promotion codes for each customer.\n  * `coupon` \n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `customer` The customer that this promotion code can be used by.\n  * `expires_at` Date at which the promotion code can no longer be redeemed.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `max_redemptions` Maximum number of times this promotion code can be redeemed.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `restrictions` \n  * `times_redeemed` Number of times this promotion code has been used.\n"
    @type t :: %__MODULE__{
            active: boolean,
            code: binary,
            coupon: Stripe.Coupon.t(),
            created: integer,
            customer: (binary | Stripe.Customer.t() | Stripe.DeletedCustomer.t()) | nil,
            expires_at: integer | nil,
            id: binary,
            livemode: boolean,
            max_redemptions: integer | nil,
            metadata: term | nil,
            object: binary,
            restrictions: term,
            times_redeemed: integer
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
    @typedoc "Settings that restrict the redemption of the promotion code."
    @type restrictions :: %{
            optional(:currency_options) => map(),
            optional(:first_time_transaction) => boolean,
            optional(:minimum_amount) => integer,
            optional(:minimum_amount_currency) => binary
          }
  )

  (
    nil

    @doc "<p>Retrieves the promotion code with the given ID. In order to retrieve a promotion code by the customer-facing <code>code</code> use <a href=\"/docs/api/promotion_codes/list\">list</a> with the desired <code>code</code>.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/promotion_codes/{promotion_code}`\n"
    (
      @spec retrieve(
              promotion_code :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PromotionCode.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(promotion_code, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/promotion_codes/{promotion_code}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "promotion_code",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "promotion_code",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [promotion_code]
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

    @doc "<p>A promotion code points to a coupon. You can optionally restrict the code to a specific customer, redemption limit, and expiration date.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/promotion_codes`\n"
    (
      @spec create(
              params :: %{
                optional(:active) => boolean,
                optional(:code) => binary,
                optional(:coupon) => binary,
                optional(:customer) => binary,
                optional(:expand) => list(binary),
                optional(:expires_at) => integer,
                optional(:max_redemptions) => integer,
                optional(:metadata) => %{optional(binary) => binary},
                optional(:restrictions) => restrictions
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PromotionCode.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/promotion_codes", [], [])

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

    @doc "<p>Updates the specified promotion code by setting the values of the parameters passed. Most fields are, by design, not editable.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/promotion_codes/{promotion_code}`\n"
    (
      @spec update(
              promotion_code :: binary(),
              params :: %{
                optional(:active) => boolean,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:restrictions) => restrictions
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.PromotionCode.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(promotion_code, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/promotion_codes/{promotion_code}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "promotion_code",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "promotion_code",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [promotion_code]
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

    @doc "<p>Returns a list of your promotion codes.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/promotion_codes`\n"
    (
      @spec list(
              params :: %{
                optional(:active) => boolean,
                optional(:code) => binary,
                optional(:coupon) => binary,
                optional(:created) => created | integer,
                optional(:customer) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.PromotionCode.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/promotion_codes", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )
end
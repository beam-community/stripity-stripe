defmodule Stripe.Plan do
  use Stripe.Entity

  @moduledoc "You can now model subscriptions more flexibly using the [Prices API](https://stripe.com/docs/api#prices). It replaces the Plans API and is backwards compatible to simplify your migration.\n\nPlans define the base price, currency, and billing cycle for recurring purchases of products.\n[Products](https://stripe.com/docs/api#products) help you track inventory or provisioning, and plans help you track pricing. Different physical goods or levels of service should be represented by products, and pricing options should be represented by plans. This approach lets you change prices without having to change your provisioning scheme.\n\nFor example, you might have a single \"gold\" product that has plans for $10/month, $100/year, €9/month, and €90/year.\n\nRelated guides: [Set up a subscription](https://stripe.com/docs/billing/subscriptions/set-up-subscription) and more about [products and prices](https://stripe.com/docs/products-prices/overview)."
  (
    defstruct [
      :active,
      :aggregate_usage,
      :amount,
      :amount_decimal,
      :billing_scheme,
      :created,
      :currency,
      :id,
      :interval,
      :interval_count,
      :livemode,
      :metadata,
      :nickname,
      :object,
      :product,
      :tiers,
      :tiers_mode,
      :transform_usage,
      :trial_period_days,
      :usage_type
    ]

    @typedoc "The `plan` type.\n\n  * `active` Whether the plan can be used for new purchases.\n  * `aggregate_usage` Specifies a usage aggregation strategy for plans of `usage_type=metered`. Allowed values are `sum` for summing up all usage during a period, `last_during_period` for using the last usage record reported within a period, `last_ever` for using the last usage record ever (across period bounds) or `max` which uses the usage record with the maximum reported usage during a period. Defaults to `sum`.\n  * `amount` The unit amount in %s to be charged, represented as a whole integer if possible. Only set if `billing_scheme=per_unit`.\n  * `amount_decimal` The unit amount in %s to be charged, represented as a decimal string with at most 12 decimal places. Only set if `billing_scheme=per_unit`.\n  * `billing_scheme` Describes how to compute the price per period. Either `per_unit` or `tiered`. `per_unit` indicates that the fixed amount (specified in `amount`) will be charged per unit in `quantity` (for plans with `usage_type=licensed`), or per unit of total usage (for plans with `usage_type=metered`). `tiered` indicates that the unit pricing will be computed using a tiering strategy as defined using the `tiers` and `tiers_mode` attributes.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `currency` Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).\n  * `id` Unique identifier for the object.\n  * `interval` The frequency at which a subscription is billed. One of `day`, `week`, `month` or `year`.\n  * `interval_count` The number of intervals (specified in the `interval` attribute) between subscription billings. For example, `interval=month` and `interval_count=3` bills every 3 months.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `nickname` A brief description of the plan, hidden from customers.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `product` The product whose pricing this plan determines.\n  * `tiers` Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to `tiered`. See also the documentation for `billing_scheme`.\n  * `tiers_mode` Defines if the tiering price should be `graduated` or `volume` based. In `volume`-based tiering, the maximum quantity within a period determines the per unit price. In `graduated` tiering, pricing can change as the quantity grows.\n  * `transform_usage` Apply a transformation to the reported usage or set quantity before computing the amount billed. Cannot be combined with `tiers`.\n  * `trial_period_days` Default number of trial days when subscribing a customer to this plan using [`trial_from_plan=true`](https://stripe.com/docs/api#create_subscription-trial_from_plan).\n  * `usage_type` Configures how the quantity per period should be determined. Can be either `metered` or `licensed`. `licensed` automatically bills the `quantity` set when adding it to a subscription. `metered` aggregates the total usage based on usage records. Defaults to `licensed`.\n"
    @type t :: %__MODULE__{
            active: boolean,
            aggregate_usage: binary | nil,
            amount: integer | nil,
            amount_decimal: binary | nil,
            billing_scheme: binary,
            created: integer,
            currency: binary,
            id: binary,
            interval: binary,
            interval_count: integer,
            livemode: boolean,
            metadata: term | nil,
            nickname: binary | nil,
            object: binary,
            product: (binary | Stripe.Product.t() | Stripe.DeletedProduct.t()) | nil,
            tiers: term,
            tiers_mode: binary | nil,
            transform_usage: term | nil,
            trial_period_days: integer | nil,
            usage_type: binary
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
    @typedoc "The product whose pricing the created plan will represent. This can either be the ID of an existing product, or a dictionary containing fields used to create a [service product](https://stripe.com/docs/api#product_object-type)."
    @type product :: %{
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
    @type transform_usage :: %{optional(:divide_by) => integer, optional(:round) => :down | :up}
  )

  (
    nil

    @doc "<p>Returns a list of your plans.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/plans`\n"
    (
      @spec list(
              params :: %{
                optional(:active) => boolean,
                optional(:created) => created | integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:product) => binary,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Plan.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/plans", [], [])

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

    @doc "<p>You can now model subscriptions more flexibly using the <a href=\"#prices\">Prices API</a>. It replaces the Plans API and is backwards compatible to simplify your migration.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/plans`\n"
    (
      @spec create(
              params :: %{
                optional(:active) => boolean,
                optional(:aggregate_usage) => :last_during_period | :last_ever | :max | :sum,
                optional(:amount) => integer,
                optional(:amount_decimal) => binary,
                optional(:billing_scheme) => :per_unit | :tiered,
                optional(:currency) => binary,
                optional(:expand) => list(binary),
                optional(:id) => binary,
                optional(:interval) => :day | :month | :week | :year,
                optional(:interval_count) => integer,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:nickname) => binary,
                optional(:product) => product | binary,
                optional(:tiers) => list(tiers),
                optional(:tiers_mode) => :graduated | :volume,
                optional(:transform_usage) => transform_usage,
                optional(:trial_period_days) => integer,
                optional(:usage_type) => :licensed | :metered
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Plan.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/plans", [], [])

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

    @doc "<p>Retrieves the plan with the given ID.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/plans/{plan}`\n"
    (
      @spec retrieve(
              plan :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Plan.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(plan, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/plans/{plan}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "plan",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "plan",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [plan]
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

    @doc "<p>Updates the specified plan by setting the values of the parameters passed. Any parameters not provided are left unchanged. By design, you cannot change a plan’s ID, amount, currency, or billing cycle.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/plans/{plan}`\n"
    (
      @spec update(
              plan :: binary(),
              params :: %{
                optional(:active) => boolean,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:nickname) => binary,
                optional(:product) => binary,
                optional(:trial_period_days) => integer
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.Plan.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(plan, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/plans/{plan}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "plan",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "plan",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [plan]
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

    @doc "<p>Deleting plans means new subscribers can’t be added. Existing subscribers aren’t affected.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/plans/{plan}`\n"
    (
      @spec delete(plan :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedPlan.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def delete(plan, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/plans/{plan}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "plan",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "plan",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [plan]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )
end

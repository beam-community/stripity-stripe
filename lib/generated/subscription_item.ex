defmodule Stripe.SubscriptionItem do
  use Stripe.Entity

  @moduledoc "Subscription items allow you to create customer subscriptions with more than\none plan, making it easy to represent complex billing relationships."
  (
    defstruct [
      :created,
      :current_period_end,
      :current_period_start,
      :discounts,
      :id,
      :metadata,
      :object,
      :plan,
      :price,
      :quantity,
      :subscription,
      :tax_rates
    ]

    @typedoc "The `subscription_item` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `current_period_end` The end time of this subscription item's current billing period.\n  * `current_period_start` The start time of this subscription item's current billing period.\n  * `discounts` The discounts applied to the subscription item. Subscription item discounts are applied before subscription discounts. Use `expand[]=discounts` to expand each discount.\n  * `id` Unique identifier for the object.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `plan` \n  * `price` \n  * `quantity` The [quantity](https://stripe.com/docs/subscriptions/quantities) of the plan to which the customer should be subscribed.\n  * `subscription` The `subscription` this `subscription_item` belongs to.\n  * `tax_rates` The tax rates which apply to this `subscription_item`. When set, the `default_tax_rates` on the subscription do not apply to this `subscription_item`.\n"
    @type t :: %__MODULE__{
            created: integer,
            current_period_end: integer,
            current_period_start: integer,
            discounts: term,
            id: binary,
            metadata: term,
            object: binary,
            plan: Stripe.Plan.t(),
            price: Stripe.Price.t(),
            quantity: integer,
            subscription: binary,
            tax_rates: term | nil
          }
  )

  (
    @typedoc nil
    @type discounts :: %{
            optional(:coupon) => binary,
            optional(:discount) => binary,
            optional(:promotion_code) => binary
          }
  )

  (
    @typedoc "Data used to generate a new [Price](https://stripe.com/docs/api/prices) object inline."
    @type price_data :: %{
            optional(:currency) => binary,
            optional(:product) => binary,
            optional(:recurring) => recurring,
            optional(:tax_behavior) => :exclusive | :inclusive | :unspecified,
            optional(:unit_amount) => integer,
            optional(:unit_amount_decimal) => binary
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

    @doc "<p>Deletes an item from the subscription. Removing a subscription item from a subscription will not cancel the subscription.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/subscription_items/{item}`\n"
    (
      @spec delete(
              item :: binary(),
              params :: %{
                optional(:clear_usage) => boolean,
                optional(:proration_behavior) => :always_invoice | :create_prorations | :none,
                optional(:proration_date) => integer
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.DeletedSubscriptionItem.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def delete(item, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/subscription_items/{item}",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "item",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "item",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [item]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Returns a list of your subscription items for a given subscription.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/subscription_items`\n"
    (
      @spec list(
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:subscription) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.SubscriptionItem.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/subscription_items", [], [])

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

    @doc "<p>Retrieves the subscription item with the given ID.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/subscription_items/{item}`\n"
    (
      @spec retrieve(
              item :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.SubscriptionItem.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(item, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/subscription_items/{item}",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "item",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "item",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [item]
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

    @doc "<p>Adds a new item to an existing subscription. No existing items will be changed or replaced.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/subscription_items`\n"
    (
      @spec create(
              params :: %{
                optional(:discounts) => list(discounts) | binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary},
                optional(:payment_behavior) =>
                  :allow_incomplete
                  | :default_incomplete
                  | :error_if_incomplete
                  | :pending_if_incomplete,
                optional(:plan) => binary,
                optional(:price) => binary,
                optional(:price_data) => price_data,
                optional(:proration_behavior) => :always_invoice | :create_prorations | :none,
                optional(:proration_date) => integer,
                optional(:quantity) => integer,
                optional(:subscription) => binary,
                optional(:tax_rates) => list(binary) | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.SubscriptionItem.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/subscription_items", [], [])

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

    @doc "<p>Updates the plan or quantity of an item on a current subscription.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/subscription_items/{item}`\n"
    (
      @spec update(
              item :: binary(),
              params :: %{
                optional(:discounts) => list(discounts) | binary,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:off_session) => boolean,
                optional(:payment_behavior) =>
                  :allow_incomplete
                  | :default_incomplete
                  | :error_if_incomplete
                  | :pending_if_incomplete,
                optional(:plan) => binary,
                optional(:price) => binary,
                optional(:price_data) => price_data,
                optional(:proration_behavior) => :always_invoice | :create_prorations | :none,
                optional(:proration_date) => integer,
                optional(:quantity) => integer,
                optional(:tax_rates) => list(binary) | binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.SubscriptionItem.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(item, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/subscription_items/{item}",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "item",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "item",
                  properties: [],
                  title: nil,
                  type: "string"
                }
              }
            ],
            [item]
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
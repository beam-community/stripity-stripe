defmodule Stripe.SubscriptionItem do
  use Stripe.Entity

  @moduledoc "Subscription items allow you to create customer subscriptions with more than\none plan, making it easy to represent complex billing relationships."
  (
    defstruct [
      :billing_thresholds,
      :created,
      :id,
      :metadata,
      :object,
      :plan,
      :price,
      :quantity,
      :subscription,
      :tax_rates
    ]

    @typedoc "The `subscription_item` type.\n\n  * `billing_thresholds` Define thresholds at which an invoice will be sent, and the related subscription advanced to a new billing period\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `id` Unique identifier for the object.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `plan` \n  * `price` \n  * `quantity` The [quantity](https://stripe.com/docs/subscriptions/quantities) of the plan to which the customer should be subscribed.\n  * `subscription` The `subscription` this `subscription_item` belongs to.\n  * `tax_rates` The tax rates which apply to this `subscription_item`. When set, the `default_tax_rates` on the subscription do not apply to this `subscription_item`.\n"
    @type t :: %__MODULE__{
            billing_thresholds: term | nil,
            created: integer,
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
    @type billing_thresholds :: %{optional(:usage_gte) => integer}
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
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "item",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "item",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
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
                optional(:billing_thresholds) => billing_thresholds | binary,
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
                optional(:billing_thresholds) => billing_thresholds | binary,
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
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "item",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "item",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
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
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "item",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "item",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
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

    @doc "<p>For the specified subscription item, returns a list of summary objects. Each object in the list provides usage information that’s been summarized from multiple usage records and over a subscription billing period (e.g., 15 usage records in the month of September).</p>\n\n<p>The list is sorted in reverse-chronological order (newest first). The first list item represents the most current usage period that hasn’t ended yet. Since new usage records can still be added, the returned summary information for the subscription item’s ID should be seen as unstable until the subscription billing period ends.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/subscription_items/{subscription_item}/usage_record_summaries`\n"
    (
      @spec usage_record_summaries(
              subscription_item :: binary(),
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.UsageRecordSummary.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def usage_record_summaries(subscription_item, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/subscription_items/{subscription_item}/usage_record_summaries",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "subscription_item",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "subscription_item",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [subscription_item]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )
end

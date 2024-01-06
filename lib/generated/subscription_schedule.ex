defmodule Stripe.SubscriptionSchedule do
  use Stripe.Entity

  @moduledoc "A subscription schedule allows you to create and manage the lifecycle of a subscription by predefining expected changes.\n\nRelated guide: [Subscription schedules](https://stripe.com/docs/billing/subscriptions/subscription-schedules)"
  (
    defstruct [
      :application,
      :canceled_at,
      :completed_at,
      :created,
      :current_phase,
      :customer,
      :default_settings,
      :end_behavior,
      :id,
      :livemode,
      :metadata,
      :object,
      :phases,
      :released_at,
      :released_subscription,
      :status,
      :subscription,
      :test_clock
    ]

    @typedoc "The `subscription_schedule` type.\n\n  * `application` ID of the Connect Application that created the schedule.\n  * `canceled_at` Time at which the subscription schedule was canceled. Measured in seconds since the Unix epoch.\n  * `completed_at` Time at which the subscription schedule was completed. Measured in seconds since the Unix epoch.\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `current_phase` Object representing the start and end dates for the current phase of the subscription schedule, if it is `active`.\n  * `customer` ID of the customer who owns the subscription schedule.\n  * `default_settings` \n  * `end_behavior` Behavior of the subscription schedule and underlying subscription when it ends. Possible values are `release` or `cancel` with the default being `release`. `release` will end the subscription schedule and keep the underlying subscription running. `cancel` will end the subscription schedule and cancel the underlying subscription.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `metadata` Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `phases` Configuration for the subscription schedule's phases.\n  * `released_at` Time at which the subscription schedule was released. Measured in seconds since the Unix epoch.\n  * `released_subscription` ID of the subscription once managed by the subscription schedule (if it is released).\n  * `status` The present status of the subscription schedule. Possible values are `not_started`, `active`, `completed`, `released`, and `canceled`. You can read more about the different states in our [behavior guide](https://stripe.com/docs/billing/subscriptions/subscription-schedules).\n  * `subscription` ID of the subscription managed by the subscription schedule.\n  * `test_clock` ID of the test clock this subscription schedule belongs to.\n"
    @type t :: %__MODULE__{
            application: (binary | term | term) | nil,
            canceled_at: integer | nil,
            completed_at: integer | nil,
            created: integer,
            current_phase: term | nil,
            customer: binary | Stripe.Customer.t() | Stripe.DeletedCustomer.t(),
            default_settings: term,
            end_behavior: binary,
            id: binary,
            livemode: boolean,
            metadata: term | nil,
            object: binary,
            phases: term,
            released_at: integer | nil,
            released_subscription: binary | nil,
            status: binary,
            subscription: (binary | Stripe.Subscription.t()) | nil,
            test_clock: (binary | Stripe.TestHelpers.TestClock.t()) | nil
          }
  )

  (
    @typedoc nil
    @type add_invoice_items :: %{
            optional(:price) => binary,
            optional(:price_data) => price_data,
            optional(:quantity) => integer,
            optional(:tax_rates) => list(binary) | binary
          }
  )

  (
    @typedoc "Automatic tax settings for this phase."
    @type automatic_tax :: %{optional(:enabled) => boolean}
  )

  (
    @typedoc nil
    @type billing_thresholds :: %{
            optional(:amount_gte) => integer,
            optional(:reset_billing_cycle_anchor) => boolean
          }
  )

  (
    @typedoc nil
    @type canceled_at :: %{
            optional(:gt) => integer,
            optional(:gte) => integer,
            optional(:lt) => integer,
            optional(:lte) => integer
          }
  )

  (
    @typedoc nil
    @type completed_at :: %{
            optional(:gt) => integer,
            optional(:gte) => integer,
            optional(:lt) => integer,
            optional(:lte) => integer
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
    @typedoc "Object representing the subscription schedule's default settings."
    @type default_settings :: %{
            optional(:application_fee_percent) => number,
            optional(:automatic_tax) => automatic_tax,
            optional(:billing_cycle_anchor) => :automatic | :phase_start,
            optional(:billing_thresholds) => billing_thresholds | binary,
            optional(:collection_method) => :charge_automatically | :send_invoice,
            optional(:default_payment_method) => binary,
            optional(:description) => binary | binary,
            optional(:invoice_settings) => invoice_settings,
            optional(:on_behalf_of) => binary | binary,
            optional(:transfer_data) => transfer_data | binary
          }
  )

  (
    @typedoc "All invoices will be billed using the specified settings."
    @type invoice_settings :: %{optional(:days_until_due) => integer}
  )

  (
    @typedoc nil
    @type items :: %{
            optional(:billing_thresholds) => billing_thresholds | binary,
            optional(:metadata) => %{optional(binary) => binary},
            optional(:plan) => binary,
            optional(:price) => binary,
            optional(:price_data) => price_data,
            optional(:quantity) => integer,
            optional(:tax_rates) => list(binary) | binary
          }
  )

  (
    @typedoc nil
    @type phases :: %{
            optional(:add_invoice_items) => list(add_invoice_items),
            optional(:application_fee_percent) => number,
            optional(:automatic_tax) => automatic_tax,
            optional(:billing_cycle_anchor) => :automatic | :phase_start,
            optional(:billing_thresholds) => billing_thresholds | binary,
            optional(:collection_method) => :charge_automatically | :send_invoice,
            optional(:coupon) => binary,
            optional(:currency) => binary,
            optional(:default_payment_method) => binary,
            optional(:default_tax_rates) => list(binary) | binary,
            optional(:description) => binary | binary,
            optional(:end_date) => integer,
            optional(:invoice_settings) => invoice_settings,
            optional(:items) => list(items),
            optional(:iterations) => integer,
            optional(:metadata) => %{optional(binary) => binary},
            optional(:on_behalf_of) => binary,
            optional(:proration_behavior) => :always_invoice | :create_prorations | :none,
            optional(:transfer_data) => transfer_data,
            optional(:trial) => boolean,
            optional(:trial_end) => integer
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
    @typedoc nil
    @type released_at :: %{
            optional(:gt) => integer,
            optional(:gte) => integer,
            optional(:lt) => integer,
            optional(:lte) => integer
          }
  )

  (
    @typedoc nil
    @type transfer_data :: %{
            optional(:amount_percent) => number,
            optional(:destination) => binary
          }
  )

  (
    nil

    @doc "<p>Retrieves the list of your subscription schedules.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/subscription_schedules`\n"
    (
      @spec list(
              params :: %{
                optional(:canceled_at) => canceled_at | integer,
                optional(:completed_at) => completed_at | integer,
                optional(:created) => created | integer,
                optional(:customer) => binary,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:released_at) => released_at | integer,
                optional(:scheduled) => boolean,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.SubscriptionSchedule.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/subscription_schedules", [], [])

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

    @doc "<p>Creates a new subscription schedule object. Each customer can have up to 500 active or scheduled subscriptions.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/subscription_schedules`\n"
    (
      @spec create(
              params :: %{
                optional(:customer) => binary,
                optional(:default_settings) => default_settings,
                optional(:end_behavior) => :cancel | :none | :release | :renew,
                optional(:expand) => list(binary),
                optional(:from_subscription) => binary,
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:phases) => list(phases),
                optional(:start_date) => integer | :now
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.SubscriptionSchedule.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/subscription_schedules", [], [])

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

    @doc "<p>Retrieves the details of an existing subscription schedule. You only need to supply the unique subscription schedule identifier that was returned upon subscription schedule creation.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/subscription_schedules/{schedule}`\n"
    (
      @spec retrieve(
              schedule :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.SubscriptionSchedule.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(schedule, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/subscription_schedules/{schedule}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "schedule",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "schedule",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [schedule]
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

    @doc "<p>Updates an existing subscription schedule.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/subscription_schedules/{schedule}`\n"
    (
      @spec update(
              schedule :: binary(),
              params :: %{
                optional(:default_settings) => default_settings,
                optional(:end_behavior) => :cancel | :none | :release | :renew,
                optional(:expand) => list(binary),
                optional(:metadata) => %{optional(binary) => binary} | binary,
                optional(:phases) => list(phases),
                optional(:proration_behavior) => :always_invoice | :create_prorations | :none
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.SubscriptionSchedule.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def update(schedule, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/subscription_schedules/{schedule}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "schedule",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "schedule",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [schedule]
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

    @doc "<p>Cancels a subscription schedule and its associated subscription immediately (if the subscription schedule has an active subscription). A subscription schedule can only be canceled if its status is <code>not_started</code> or <code>active</code>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/subscription_schedules/{schedule}/cancel`\n"
    (
      @spec cancel(
              schedule :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:invoice_now) => boolean,
                optional(:prorate) => boolean
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.SubscriptionSchedule.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def cancel(schedule, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/subscription_schedules/{schedule}/cancel",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "schedule",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "schedule",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [schedule]
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

    @doc "<p>Releases the subscription schedule immediately, which will stop scheduling of its phases, but leave any existing subscription in place. A schedule can only be released if its status is <code>not_started</code> or <code>active</code>. If the subscription schedule is currently associated with a subscription, releasing it will remove its <code>subscription</code> property and set the subscription’s ID to the <code>released_subscription</code> property.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/subscription_schedules/{schedule}/release`\n"
    (
      @spec release(
              schedule :: binary(),
              params :: %{
                optional(:expand) => list(binary),
                optional(:preserve_cancel_date) => boolean
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.SubscriptionSchedule.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def release(schedule, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/subscription_schedules/{schedule}/release",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "schedule",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "schedule",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [schedule]
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

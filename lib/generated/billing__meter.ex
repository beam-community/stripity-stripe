# credo:disable-for-this-file
defmodule Stripe.Billing.Meter do
  use Stripe.Entity

  @moduledoc "Meters specify how to aggregate meter events over a billing period. Meter events represent the actions that customers take in your system. Meters attach to prices and form the basis of the bill.\n\nRelated guide: [Usage based billing](https://docs.stripe.com/billing/subscriptions/usage-based)"
  (
    defstruct [
      :created,
      :customer_mapping,
      :default_aggregation,
      :display_name,
      :event_name,
      :event_time_window,
      :id,
      :livemode,
      :object,
      :status,
      :status_transitions,
      :updated,
      :value_settings
    ]

    @typedoc "The `billing.meter` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `customer_mapping` \n  * `default_aggregation` \n  * `display_name` The meter's name.\n  * `event_name` The name of the meter event to record usage for. Corresponds with the `event_name` field on meter events.\n  * `event_time_window` The time window which meter events have been pre-aggregated for, if any.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `status` The meter's status.\n  * `status_transitions` \n  * `updated` Time at which the object was last updated. Measured in seconds since the Unix epoch.\n  * `value_settings` \n"
    @type t :: %__MODULE__{
            created: integer,
            customer_mapping: term,
            default_aggregation: term,
            display_name: binary,
            event_name: binary,
            event_time_window: binary | nil,
            id: binary,
            livemode: boolean,
            object: binary,
            status: binary,
            status_transitions: term,
            updated: integer,
            value_settings: term
          }
  )

  (
    @typedoc "Fields that specify how to map a meter event to a customer."
    @type customer_mapping :: %{optional(:event_payload_key) => binary, optional(:type) => :by_id}
  )

  (
    @typedoc "The default settings to aggregate a meter's events with."
    @type default_aggregation :: %{optional(:formula) => :count | :last | :sum}
  )

  (
    @typedoc "Fields that specify how to calculate a meter event's value."
    @type value_settings :: %{optional(:event_payload_key) => binary}
  )

  (
    nil

    @doc "<p>Retrieve a list of billing meters.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/billing/meters`\n"
    (
      @spec list(
              params :: %{
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:starting_after) => binary,
                optional(:status) => :active | :inactive
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Billing.Meter.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/billing/meters", [], [])

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

    @doc "<p>Retrieves a billing meter given an ID.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/billing/meters/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.Meter.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/billing/meters/{id}",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "id",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "id",
                  properties: [],
                  title: nil,
                  type: "string"
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

    @doc "<p>Creates a billing meter.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/billing/meters`\n"
    (
      @spec create(
              params :: %{
                optional(:customer_mapping) => customer_mapping,
                optional(:default_aggregation) => default_aggregation,
                optional(:display_name) => binary,
                optional(:event_name) => binary,
                optional(:event_time_window) => :day | :hour,
                optional(:expand) => list(binary),
                optional(:value_settings) => value_settings
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.Meter.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/billing/meters", [], [])

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

    @doc "<p>Updates a billing meter.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/billing/meters/{id}`\n"
    (
      @spec update(
              id :: binary(),
              params :: %{optional(:display_name) => binary, optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.Meter.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def update(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/billing/meters/{id}",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "id",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "id",
                  properties: [],
                  title: nil,
                  type: "string"
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

  (
    nil

    @doc "<p>When a meter is deactivated, no more meter events will be accepted for this meter. You can’t attach a deactivated meter to a price.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/billing/meters/{id}/deactivate`\n"
    (
      @spec deactivate(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.Meter.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def deactivate(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/billing/meters/{id}/deactivate",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "id",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "id",
                  properties: [],
                  title: nil,
                  type: "string"
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

  (
    nil

    @doc "<p>When a meter is reactivated, events for this meter can be accepted and you can attach the meter to a price.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/billing/meters/{id}/reactivate`\n"
    (
      @spec reactivate(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.Meter.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def reactivate(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/billing/meters/{id}/reactivate",
            [
              %{
                __struct__: OpenApiGen.Blueprint.Parameter,
                in: "path",
                name: "id",
                required: true,
                schema: %{
                  __struct__: OpenApiGen.Blueprint.Parameter.Schema,
                  any_of: [],
                  items: [],
                  name: "id",
                  properties: [],
                  title: nil,
                  type: "string"
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

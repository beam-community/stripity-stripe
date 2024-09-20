defmodule Stripe.Billing.Alert do
  use Stripe.Entity

  @moduledoc "A billing alert is a resource that notifies you when a certain usage threshold on a meter is crossed. For example, you might create a billing alert to notify you when a certain user made 100 API requests."
  (
    defstruct [
      :alert_type,
      :filter,
      :id,
      :livemode,
      :object,
      :status,
      :title,
      :usage_threshold_config
    ]

    @typedoc "The `billing.alert` type.\n\n  * `alert_type` Defines the type of the alert.\n  * `filter` Limits the scope of the alert to a specific [customer](https://stripe.com/docs/api/customers).\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `status` Status of the alert. This can be active, inactive or archived.\n  * `title` Title of the alert.\n  * `usage_threshold_config` Encapsulates configuration of the alert to monitor usage on a specific [Billing Meter](https://stripe.com/docs/api/billing/meter).\n"
    @type t :: %__MODULE__{
            alert_type: binary,
            filter: term | nil,
            id: binary,
            livemode: boolean,
            object: binary,
            status: binary | nil,
            title: binary,
            usage_threshold_config: term | nil
          }
  )

  (
    @typedoc "Filters to limit the scope of an alert."
    @type filter :: %{
            optional(:customer) => binary,
            optional(:subscription) => binary,
            optional(:subscription_item) => binary
          }
  )

  (
    @typedoc "The configuration of the usage threshold."
    @type usage_threshold_config :: %{
            optional(:gte) => integer,
            optional(:meter) => binary,
            optional(:recurrence) => :one_time
          }
  )

  (
    nil

    @doc "<p>Lists billing active and inactive alerts</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/billing/alerts`\n"
    (
      @spec list(
              params :: %{
                optional(:alert_type) => :usage_threshold,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:meter) => binary,
                optional(:starting_after) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Billing.Alert.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/billing/alerts", [], [])

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

    @doc "<p>Retrieves a billing alert given an ID</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/billing/alerts/{id}`\n"
    (
      @spec retrieve(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.Alert.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def retrieve(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/billing/alerts/{id}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "id",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "id",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
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

    @doc "<p>Creates a billing alert</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/billing/alerts`\n"
    (
      @spec create(
              params :: %{
                optional(:alert_type) => :usage_threshold,
                optional(:expand) => list(binary),
                optional(:filter) => filter,
                optional(:title) => binary,
                optional(:usage_threshold_config) => usage_threshold_config
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.Alert.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/billing/alerts", [], [])

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

    @doc "<p>Reactivates this alert, allowing it to trigger again.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/billing/alerts/{id}/activate`\n"
    (
      @spec activate(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.Alert.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def activate(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/billing/alerts/{id}/activate",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "id",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "id",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
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

    @doc "<p>Archives this alert, removing it from the list view and APIs. This is non-reversible.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/billing/alerts/{id}/archive`\n"
    (
      @spec archive(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.Alert.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def archive(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/billing/alerts/{id}/archive",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "id",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "id",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
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

    @doc "<p>Deactivates this alert, preventing it from triggering.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/billing/alerts/{id}/deactivate`\n"
    (
      @spec deactivate(
              id :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.Alert.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def deactivate(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/billing/alerts/{id}/deactivate",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "id",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "id",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
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

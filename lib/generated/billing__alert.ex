# credo:disable-for-this-file
defmodule Stripe.Billing.Alert do
  use Stripe.Entity

  @moduledoc "A billing alert is a resource that notifies you when a certain usage threshold on a meter is crossed. For example, you might create a billing alert to notify you when a certain user made 100 API requests."
  (
    defstruct [:alert_type, :id, :livemode, :object, :status, :title, :usage_threshold]

    @typedoc "The `billing.alert` type.\n\n  * `alert_type` Defines the type of the alert.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `status` Status of the alert. This can be active, inactive or archived.\n  * `title` Title of the alert.\n  * `usage_threshold` Encapsulates configuration of the alert to monitor usage on a specific [Billing Meter](https://stripe.com/docs/api/billing/meter).\n"
    @type t :: %__MODULE__{
            alert_type: binary,
            id: binary,
            livemode: boolean,
            object: binary,
            status: binary | nil,
            title: binary,
            usage_threshold: term | nil
          }
  )

  (
    @typedoc nil
    @type filters :: %{optional(:customer) => binary, optional(:type) => :customer}
  )

  (
    @typedoc "The configuration of the usage threshold."
    @type usage_threshold :: %{
            optional(:filters) => list(filters),
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

    @doc "<p>Creates a billing alert</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/billing/alerts`\n"
    (
      @spec create(
              params :: %{
                optional(:alert_type) => :usage_threshold,
                optional(:expand) => list(binary),
                optional(:title) => binary,
                optional(:usage_threshold) => usage_threshold
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

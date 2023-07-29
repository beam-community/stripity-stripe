defmodule Stripe.TestHelpers.TestClock do
  use Stripe.Entity

  @moduledoc "A test clock enables deterministic control over objects in testmode. With a test clock, you can create\nobjects at a frozen time in the past or future, and advance to a specific future time to observe webhooks and state changes. After the clock advances,\nyou can either validate the current state of your scenario (and test your assumptions), change the current state of your scenario (and test more complex scenarios), or keep advancing forward in time."
  (
    defstruct [:created, :deletes_after, :frozen_time, :id, :livemode, :name, :object, :status]

    @typedoc "The `test_helpers.test_clock` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `deletes_after` Time at which this clock is scheduled to auto delete.\n  * `frozen_time` Time at which all objects belonging to this clock are frozen.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `name` The custom name supplied at creation.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `status` The status of the Test Clock.\n"
    @type t :: %__MODULE__{
            created: integer,
            deletes_after: integer,
            frozen_time: integer,
            id: binary,
            livemode: boolean,
            name: binary | nil,
            object: binary,
            status: binary
          }
  )

  (
    nil

    @doc "<p>Retrieves a test clock.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/test_helpers/test_clocks/{test_clock}`\n"
    (
      @spec retrieve(
              test_clock :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.TestHelpers.TestClock.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(test_clock, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/test_clocks/{test_clock}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "test_clock",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "test_clock",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [test_clock]
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

    @doc "<p>Creates a new test clock that can be attached to new customers and quotes.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/test_clocks`\n"
    (
      @spec create(
              params :: %{
                optional(:expand) => list(binary),
                optional(:frozen_time) => integer,
                optional(:name) => binary
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.TestHelpers.TestClock.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/test_helpers/test_clocks", [], [])

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

    @doc "<p>Deletes a test clock.</p>\n\n#### Details\n\n * Method: `delete`\n * Path: `/v1/test_helpers/test_clocks/{test_clock}`\n"
    (
      @spec delete(test_clock :: binary(), opts :: Keyword.t()) ::
              {:ok, Stripe.DeletedTestHelpers.TestClock.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def delete(test_clock, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/test_clocks/{test_clock}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "test_clock",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "test_clock",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [test_clock]
          )

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_method(:delete)
        |> Stripe.Request.make_request()
      end
    )
  )

  (
    nil

    @doc "<p>Starts advancing a test clock to a specified time in the future. Advancement is done when status changes to <code>Ready</code>.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/test_helpers/test_clocks/{test_clock}/advance`\n"
    (
      @spec advance(
              test_clock :: binary(),
              params :: %{optional(:expand) => list(binary), optional(:frozen_time) => integer},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.TestHelpers.TestClock.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def advance(test_clock, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/test_helpers/test_clocks/{test_clock}/advance",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "test_clock",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "test_clock",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [test_clock]
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

    @doc "<p>Returns a list of your test clocks.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/test_helpers/test_clocks`\n"
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
              {:ok, Stripe.List.t(Stripe.TestHelpers.TestClock.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/test_helpers/test_clocks", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )
end

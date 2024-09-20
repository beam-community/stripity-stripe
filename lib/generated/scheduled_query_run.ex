defmodule Stripe.ScheduledQueryRun do
  use Stripe.Entity

  @moduledoc "If you have [scheduled a Sigma query](https://stripe.com/docs/sigma/scheduled-queries), you'll\nreceive a `sigma.scheduled_query_run.created` webhook each time the query\nruns. The webhook contains a `ScheduledQueryRun` object, which you can use to\nretrieve the query results."
  (
    defstruct [
      :created,
      :data_load_time,
      :error,
      :file,
      :id,
      :livemode,
      :object,
      :result_available_until,
      :sql,
      :status,
      :title
    ]

    @typedoc "The `scheduled_query_run` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `data_load_time` When the query was run, Sigma contained a snapshot of your Stripe data at this time.\n  * `error` \n  * `file` The file object representing the results of the query.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `result_available_until` Time at which the result expires and is no longer available for download.\n  * `sql` SQL for the query.\n  * `status` The query's execution status, which will be `completed` for successful runs, and `canceled`, `failed`, or `timed_out` otherwise.\n  * `title` Title of the query.\n"
    @type t :: %__MODULE__{
            created: integer,
            data_load_time: integer,
            error: term,
            file: Stripe.File.t() | nil,
            id: binary,
            livemode: boolean,
            object: binary,
            result_available_until: integer,
            sql: binary,
            status: binary,
            title: binary
          }
  )

  (
    nil

    @doc "<p>Returns a list of scheduled query runs.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/sigma/scheduled_query_runs`\n"
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
              {:ok, Stripe.List.t(Stripe.ScheduledQueryRun.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/sigma/scheduled_query_runs", [], [])

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

    @doc "<p>Retrieves the details of an scheduled query run.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/sigma/scheduled_query_runs/{scheduled_query_run}`\n"
    (
      @spec retrieve(
              scheduled_query_run :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.ScheduledQueryRun.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(scheduled_query_run, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/sigma/scheduled_query_runs/{scheduled_query_run}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "scheduled_query_run",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "scheduled_query_run",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [scheduled_query_run]
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
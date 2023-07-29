defmodule Stripe.Reporting.ReportType do
  use Stripe.Entity

  @moduledoc "The Report Type resource corresponds to a particular type of report, such as\nthe \"Activity summary\" or \"Itemized payouts\" reports. These objects are\nidentified by an ID belonging to a set of enumerated values. See\n[API Access to Reports documentation](https://stripe.com/docs/reporting/statements/api)\nfor those Report Type IDs, along with required and optional parameters.\n\nNote that certain report types can only be run based on your live-mode data (not test-mode\ndata), and will error when queried without a [live-mode API key](https://stripe.com/docs/keys#test-live-modes)."
  (
    defstruct [
      :data_available_end,
      :data_available_start,
      :default_columns,
      :id,
      :livemode,
      :name,
      :object,
      :updated,
      :version
    ]

    @typedoc "The `reporting.report_type` type.\n\n  * `data_available_end` Most recent time for which this Report Type is available. Measured in seconds since the Unix epoch.\n  * `data_available_start` Earliest time for which this Report Type is available. Measured in seconds since the Unix epoch.\n  * `default_columns` List of column names that are included by default when this Report Type gets run. (If the Report Type doesn't support the `columns` parameter, this will be null.)\n  * `id` The [ID of the Report Type](https://stripe.com/docs/reporting/statements/api#available-report-types), such as `balance.summary.1`.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `name` Human-readable name of the Report Type\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `updated` When this Report Type was latest updated. Measured in seconds since the Unix epoch.\n  * `version` Version of the Report Type. Different versions report with the same ID will have the same purpose, but may take different run parameters or have different result schemas.\n"
    @type t :: %__MODULE__{
            data_available_end: integer,
            data_available_start: integer,
            default_columns: term | nil,
            id: binary,
            livemode: boolean,
            name: binary,
            object: binary,
            updated: integer,
            version: integer
          }
  )

  (
    nil

    @doc "<p>Retrieves the details of a Report Type. (Certain report types require a <a href=\"https://stripe.com/docs/keys#test-live-modes\">live-mode API key</a>.)</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/reporting/report_types/{report_type}`\n"
    (
      @spec retrieve(
              report_type :: binary(),
              params :: %{optional(:expand) => list(binary)},
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Reporting.ReportType.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def retrieve(report_type, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/reporting/report_types/{report_type}",
            [
              %OpenApiGen.Blueprint.Parameter{
                in: "path",
                name: "report_type",
                required: true,
                schema: %OpenApiGen.Blueprint.Parameter.Schema{
                  name: "report_type",
                  title: nil,
                  type: "string",
                  items: [],
                  properties: [],
                  any_of: []
                }
              }
            ],
            [report_type]
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

    @doc "<p>Returns a full list of Report Types.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/reporting/report_types`\n"
    (
      @spec list(params :: %{optional(:expand) => list(binary)}, opts :: Keyword.t()) ::
              {:ok, Stripe.List.t(Stripe.Reporting.ReportType.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/reporting/report_types", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:get)
        |> Stripe.Request.make_request()
      end
    )
  )
end

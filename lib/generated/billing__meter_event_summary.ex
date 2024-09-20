defmodule Stripe.Billing.MeterEventSummary do
  use Stripe.Entity

  @moduledoc "A billing meter event summary represents an aggregated view of a customer's billing meter events within a specified timeframe. It indicates how much\nusage was accrued by a customer for that period."
  (
    defstruct [:aggregated_value, :end_time, :id, :livemode, :meter, :object, :start_time]

    @typedoc "The `billing.meter_event_summary` type.\n\n  * `aggregated_value` Aggregated value of all the events within `start_time` (inclusive) and `end_time` (inclusive). The aggregation strategy is defined on meter via `default_aggregation`.\n  * `end_time` End timestamp for this event summary (exclusive). Must be aligned with minute boundaries.\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `meter` The meter associated with this event summary.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `start_time` Start timestamp for this event summary (inclusive). Must be aligned with minute boundaries.\n"
    @type t :: %__MODULE__{
            aggregated_value: term,
            end_time: integer,
            id: binary,
            livemode: boolean,
            meter: binary,
            object: binary,
            start_time: integer
          }
  )

  (
    nil

    @doc "<p>Retrieve a list of billing meter event summaries.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/billing/meters/{id}/event_summaries`\n"
    (
      @spec list(
              id :: binary(),
              params :: %{
                optional(:customer) => binary,
                optional(:end_time) => integer,
                optional(:ending_before) => binary,
                optional(:expand) => list(binary),
                optional(:limit) => integer,
                optional(:start_time) => integer,
                optional(:starting_after) => binary,
                optional(:value_grouping_window) => :day | :hour
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.List.t(Stripe.Billing.MeterEventSummary.t())}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def list(id, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/billing/meters/{id}/event_summaries",
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
end
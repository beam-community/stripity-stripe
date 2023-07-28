defmodule Stripe.UsageRecordSummary do
  use Stripe.Entity
  @moduledoc ""
  (
    defstruct [:id, :invoice, :livemode, :object, :period, :subscription_item, :total_usage]

    @typedoc "The `usage_record_summary` type.\n\n  * `id` Unique identifier for the object.\n  * `invoice` The invoice in which this usage period has been billed for.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `period` \n  * `subscription_item` The ID of the subscription item this summary is describing.\n  * `total_usage` The total usage within this usage period.\n"
    @type t :: %__MODULE__{
            id: binary,
            invoice: binary | nil,
            livemode: boolean,
            object: binary,
            period: term,
            subscription_item: binary,
            total_usage: integer
          }
  )

  (
    nil

    @doc "<p>For the specified subscription item, returns a list of summary objects. Each object in the list provides usage information that’s been summarized from multiple usage records and over a subscription billing period (e.g., 15 usage records in the month of September).</p>\n\n<p>The list is sorted in reverse-chronological order (newest first). The first list item represents the most current usage period that hasn’t ended yet. Since new usage records can still be added, the returned summary information for the subscription item’s ID should be seen as unstable until the subscription billing period ends.</p>\n\n#### Details\n\n * Method: `get`\n * Path: `/v1/subscription_items/{subscription_item}/usage_record_summaries`\n"
    (
      @spec list(
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
      def list(subscription_item, params \\ %{}, opts \\ []) do
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
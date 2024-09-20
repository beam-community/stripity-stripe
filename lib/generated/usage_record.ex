defmodule Stripe.UsageRecord do
  use Stripe.Entity

  @moduledoc "Usage records allow you to report customer usage and metrics to Stripe for\nmetered billing of subscription prices.\n\nRelated guide: [Metered billing](https://stripe.com/docs/billing/subscriptions/metered-billing)\n\nThis is our legacy usage-based billing API. See the [updated usage-based billing docs](https://docs.stripe.com/billing/subscriptions/usage-based)."
  (
    defstruct [:id, :livemode, :object, :quantity, :subscription_item, :timestamp]

    @typedoc "The `usage_record` type.\n\n  * `id` Unique identifier for the object.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `quantity` The usage quantity for the specified date.\n  * `subscription_item` The ID of the subscription item this usage record contains data for.\n  * `timestamp` The timestamp when this usage occurred.\n"
    @type t :: %__MODULE__{
            id: binary,
            livemode: boolean,
            object: binary,
            quantity: integer,
            subscription_item: binary,
            timestamp: integer
          }
  )

  (
    nil

    @doc "<p>Creates a usage record for a specified subscription item and date, and fills it with a quantity.</p>\n\n<p>Usage records provide <code>quantity</code> information that Stripe uses to track how much a customer is using your service. With usage information and the pricing model set up by the <a href=\"https://stripe.com/docs/billing/subscriptions/metered-billing\">metered billing</a> plan, Stripe helps you send accurate invoices to your customers.</p>\n\n<p>The default calculation for usage is to add up all the <code>quantity</code> values of the usage records within a billing period. You can change this default behavior with the billing plan’s <code>aggregate_usage</code> <a href=\"/docs/api/plans/create#create_plan-aggregate_usage\">parameter</a>. When there is more than one usage record with the same timestamp, Stripe adds the <code>quantity</code> values together. In most cases, this is the desired resolution, however, you can change this behavior with the <code>action</code> parameter.</p>\n\n<p>The default pricing model for metered billing is <a href=\"/docs/api/plans/object#plan_object-billing_scheme\">per-unit pricing</a>. For finer granularity, you can configure metered billing to have a <a href=\"https://stripe.com/docs/billing/subscriptions/tiers\">tiered pricing</a> model.</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/subscription_items/{subscription_item}/usage_records`\n"
    (
      @spec create(
              subscription_item :: binary(),
              params :: %{
                optional(:action) => :increment | :set,
                optional(:expand) => list(binary),
                optional(:quantity) => integer,
                optional(:timestamp) => :now | integer
              },
              opts :: Keyword.t()
            ) :: {:ok, Stripe.UsageRecord.t()} | {:error, Stripe.ApiErrors.t()} | {:error, term()}
      def create(subscription_item, params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params(
            "/v1/subscription_items/{subscription_item}/usage_records",
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
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end

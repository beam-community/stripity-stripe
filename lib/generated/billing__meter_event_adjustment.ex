defmodule Stripe.Billing.MeterEventAdjustment do
  use Stripe.Entity

  @moduledoc "A billing meter event adjustment is a resource that allows you to cancel a meter event. For example, you might create a billing meter event adjustment to cancel a meter event that was created in error or attached to the wrong customer."
  (
    defstruct [:cancel, :event_name, :livemode, :object, :status, :type]

    @typedoc "The `billing.meter_event_adjustment` type.\n\n  * `cancel` Specifies which event to cancel.\n  * `event_name` The name of the meter event. Corresponds with the `event_name` field on a meter.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `status` The meter event adjustment's status.\n  * `type` Specifies whether to cancel a single event or a range of events for a time period. Time period cancellation is not supported yet.\n"
    @type t :: %__MODULE__{
            cancel: term | nil,
            event_name: binary,
            livemode: boolean,
            object: binary,
            status: binary,
            type: binary
          }
  )

  (
    @typedoc "Specifies which event to cancel."
    @type cancel :: %{optional(:identifier) => binary}
  )

  (
    nil

    @doc "<p>Creates a billing meter event adjustment</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/billing/meter_event_adjustments`\n"
    (
      @spec create(
              params :: %{
                optional(:cancel) => cancel,
                optional(:event_name) => binary,
                optional(:expand) => list(binary),
                optional(:type) => :cancel
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.MeterEventAdjustment.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path =
          Stripe.OpenApi.Path.replace_path_params("/v1/billing/meter_event_adjustments", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end

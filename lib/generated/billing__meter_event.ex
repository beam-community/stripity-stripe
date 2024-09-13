defmodule Stripe.Billing.MeterEvent do
  use Stripe.Entity

  @moduledoc "A billing meter event represents a customer's usage of a product. Meter events are used to bill a customer based on their usage.\nMeter events are associated with billing meters, which define the shape of the event's payload and how those events are aggregated for billing."
  (
    defstruct [:created, :event_name, :identifier, :livemode, :object, :payload, :timestamp]

    @typedoc "The `billing.meter_event` type.\n\n  * `created` Time at which the object was created. Measured in seconds since the Unix epoch.\n  * `event_name` The name of the meter event. Corresponds with the `event_name` field on a meter.\n  * `identifier` A unique identifier for the event.\n  * `livemode` Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.\n  * `object` String representing the object's type. Objects of the same type share the same value.\n  * `payload` The payload of the event. This contains the fields corresponding to a meter's `customer_mapping.event_payload_key` (default is `stripe_customer_id`) and `value_settings.event_payload_key` (default is `value`). Read more about the [payload](https://stripe.com/docs/billing/subscriptions/usage-based/recording-usage#payload-key-overrides).\n  * `timestamp` The timestamp passed in when creating the event. Measured in seconds since the Unix epoch.\n"
    @type t :: %__MODULE__{
            created: integer,
            event_name: binary,
            identifier: binary,
            livemode: boolean,
            object: binary,
            payload: term,
            timestamp: integer
          }
  )

  (
    nil

    @doc "<p>Creates a billing meter event</p>\n\n#### Details\n\n * Method: `post`\n * Path: `/v1/billing/meter_events`\n"
    (
      @spec create(
              params :: %{
                optional(:event_name) => binary,
                optional(:expand) => list(binary),
                optional(:identifier) => binary,
                optional(:payload) => map(),
                optional(:timestamp) => integer
              },
              opts :: Keyword.t()
            ) ::
              {:ok, Stripe.Billing.MeterEvent.t()}
              | {:error, Stripe.ApiErrors.t()}
              | {:error, term()}
      def create(params \\ %{}, opts \\ []) do
        path = Stripe.OpenApi.Path.replace_path_params("/v1/billing/meter_events", [], [])

        Stripe.Request.new_request(opts)
        |> Stripe.Request.put_endpoint(path)
        |> Stripe.Request.put_params(params)
        |> Stripe.Request.put_method(:post)
        |> Stripe.Request.make_request()
      end
    )
  )
end
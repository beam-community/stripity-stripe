defmodule Stripe.Telemetry do
  @moduledoc """
  Telemetry integration.

  Unless specified, all times are in `:native` units.

  Stripe executes the following events:

  ### Request Start
  `[:stripe, :request, :start]` - Executed before an api call is made

  #### Measurements
    * `:system_time` - The system time.

  #### Metadata
    * `:attempt` - The number of attempts for this request
    * `:method` - The http method used
    * `:url` - The url used

  ### Request Stop
  `[:stripe, :request, :stop]` - Executed after an api call ended.

  #### Measurements
    * `:duration` - Time taken from the request start event.

  #### Metadata
    * `:attempt` - The number of attempts for this request
    * `:error` - The Stripe error if any
    * `:status` - The http status code
    * `:request_id` - Request ID returned by Stripe
    * `:result` -> `:ok` for succesful requests, `:error` otherwise
    * `:method` - The http method used
    * `:url` - The url used

  ### Request Exception
  `[:stripe, :request, :exception]` - Executed when an exception occurs while executing
    an api call.
  #### Measurements
    * `:duration` - The time it took since the start before raising the exception.

  #### Metadata

    * `:attempt` - The number of attempts for this request
    * `:method` - The http method used
    * `:url` - The url used
    * `:kind` - The type of exception.
    * `:reason` - Error description or error data.
    * `:stacktrace` - The stacktrace.



  """
  @doc false
  # Used to easily create :start, :stop, :exception events.
  def span(event, start_metadata, fun) do
    :telemetry.span(
      [:stripe, event],
      start_metadata,
      fun
    )
  end
end

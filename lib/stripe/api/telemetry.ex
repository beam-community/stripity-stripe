defmodule Stripe.API.Telemetry do
  @moduledoc false

  @event ~w[stripe request]a

  @doc """
  Emits `[:stripe, :request, :start]` and `[:stripe, :request, :stop]` events.

  One pair of events is emitted per attempt, retries included, carrying the endpoint, the API
  version, the HTTP method, the URL without its query string, the retry count and, on stop, the
  status code.

  ## Request Options

    * `:telemetry_metadata` - a map merged into the metadata of both events.
  """
  @spec attach(Req.Request.t(), keyword) :: Req.Request.t()
  def attach(%Req.Request{} = request, options \\ []) do
    request
    |> Req.Request.register_options([:telemetry_metadata])
    |> Req.Request.merge_options(options)
    |> Req.Request.append_request_steps(stripe_telemetry: &start/1)
    |> Req.Request.prepend_response_steps(stripe_telemetry: &stop/1)
    |> Req.Request.prepend_error_steps(stripe_telemetry: &stop/1)
  end

  defp start(request) do
    telemetry_metadata = Req.Request.get_option(request, :telemetry_metadata) || %{}

    metadata =
      Map.merge(telemetry_metadata, %{
        telemetry_span_context: make_ref(),
        stripe_api_endpoint: request.url.path,
        stripe_api_version: List.first(Req.Request.get_header(request, "stripe-version")),
        http_method: request.method,
        http_retry_count: Req.Request.get_private(request, :req_retry_count, 0),
        http_status_code: nil,
        http_url: URI.to_string(%{request.url | query: nil})
      })

    monotonic_time = System.monotonic_time()

    :telemetry.execute(
      @event ++ [:start],
      %{monotonic_time: monotonic_time, system_time: System.system_time()},
      metadata
    )

    Req.Request.put_private(request, :stripe_telemetry, {monotonic_time, metadata})
  end

  defp stop({request, response_or_exception}) do
    {start_time, metadata} = Req.Request.get_private(request, :stripe_telemetry)
    monotonic_time = System.monotonic_time()

    metadata =
      case response_or_exception do
        %Req.Response{status: status} -> Map.put(metadata, :http_status_code, status)
        _exception -> metadata
      end

    :telemetry.execute(
      @event ++ [:stop],
      %{monotonic_time: monotonic_time, duration: monotonic_time - start_time},
      metadata
    )

    {request, response_or_exception}
  end
end

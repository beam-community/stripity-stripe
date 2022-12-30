defmodule Stripe.OpenApi do
  @moduledoc false

  alias Stripe.OpenApi

  defmacro __using__(opts) do
    quote do
      @pipeline Stripe.OpenApi.pipeline(unquote(opts))

      {:ok, blueprint} = Stripe.OpenApi.run(@pipeline)

      @version blueprint.api_version
    end
  end

  def pipeline(options \\ []) do
    [
      {OpenApi.Phases.Parse, options},
      {OpenApi.Phases.BuildModules, options},
      {OpenApi.Phases.BuildOperations, options},
      {OpenApi.Phases.BuildDocumentation, options},
      {OpenApi.Phases.Compile, options},
      {OpenApi.Phases.Version, options}
    ]
  end

  def run(pipeline) do
    {:ok, _} =
      pipeline
      |> List.flatten()
      |> run_phase(%OpenApiGen.Blueprint{})
  end

  defp run_phase(pipeline, input)

  defp run_phase([], input) do
    {:ok, input}
  end

  defp run_phase([phase_config | todo], input) do
    {phase, options} = phase_invocation(phase_config)

    case phase.run(input, options) do
      {:ok, result} ->
        run_phase(todo, result)

      {:error, message} ->
        {:error, message}

      _ ->
        {:error, "Last phase did not return a valid result tuple."}
    end
  end

  defp phase_invocation({phase, options}) when is_list(options) do
    {phase, options}
  end

  defp phase_invocation(phase) do
    {phase, []}
  end
end

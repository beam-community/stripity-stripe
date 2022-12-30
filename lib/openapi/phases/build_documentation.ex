defmodule Stripe.OpenApi.Phases.BuildDocumentation do
  @moduledoc false
  def run(blueprint, _options \\ []) do
    operations =
      Enum.map(blueprint.operations, fn {key, operation} ->
        {key, build_description(operation)}
      end)
      |> Map.new()

    {:ok, %{blueprint | operations: operations}}
  end

  defp build_description(operation) do
    %{operation | description: do_build_description(operation)}
  end

  defp do_build_description(operation) do
    description = operation.description

    """
    #{description}

    #### Details

     * Method: `#{operation.method}`
     * Path: `#{operation.path}`
    """
  end
end

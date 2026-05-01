defmodule Stripe.OpenApi.Phases.Parse do
  @moduledoc false
  def run(blueprint, options \\ []) do
    contents = options |> Keyword.fetch!(:path) |> File.read!()
    parsed_contents = Jason.decode!(contents)
    {:ok, %{blueprint | source: parsed_contents}}
  end
end

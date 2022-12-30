defmodule Stripe.OpenApi.Phases.Parse do
  @moduledoc false
  def run(blueprint, options \\ []) do
    contents = File.read!(Keyword.fetch!(options, :path))
    parsed_contents = Jason.decode!(contents)
    {:ok, %{blueprint | source: parsed_contents}}
  end
end

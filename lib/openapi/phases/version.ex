defmodule Stripe.OpenApi.Phases.Version do
  @moduledoc false
  def run(blueprint, _options) do
    {:ok, %{blueprint | api_version: blueprint.source["info"]["version"]}}
  end
end

defmodule Mix.Tasks.Stripe.Generate do
  @moduledoc "The hello mix task: `mix stripe.generate`"
  use Mix.Task

  def run(_) do
    opts = [
      path:
        [:code.priv_dir(:stripity_stripe), "openapi", "spec3.sdk.json"]
        |> Path.join(),
      base_url: "https://api.stripe.com"
    ]

    pipeline = Stripe.OpenApi.pipeline(opts)

    {:ok, _blueprint} = Stripe.OpenApi.run(pipeline)

    IO.puts("Generated Stripe SDK successfully!")
  end
end

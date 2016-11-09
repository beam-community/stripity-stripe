defmodule Stripe.Mixfile do
  use Mix.Project

  def project do
    [
      app: :stripity_stripe,
      version: "2.0.0",
      description: description(),
      package: package(),
      elixir: "~> 1.1",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      deps: deps
    ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: {Stripe, []},
      env: env(),
      applications: apps(Mix.env)
    ]
  end

  defp env() do
    [
      stripity_stripe: [
        api_base_url: "https://api.stripe.com/v1/",
        use_connection_pool: true,
        pool_options: [
          timeout: 5_000,
          max_connections: 10
        ]
      ]
    ]
  end

  defp apps(:test), do: [:bypass | apps()]
  defp apps(_), do: apps()

  defp apps(), do: [:hackney, :poison, :logger]

  defp deps do
    [
      {:bypass, "~> 0.5", only: :test},
      {:earmark, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.14", only: :dev},
      {:excoveralls, "~> 0.5", only: :test},
      {:hackney, "~> 1.6"},
      {:inch_ex, "~> 0.5", only: [:dev, :test]},
      {:poison, "~> 2.0"}
    ]
  end

  defp description do
    """
    A Stripe Library for Elixir.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Dan Matthews", "Josh Smith"],
      licenses: ["New BSD"],
      links: %{
        "GitHub" => "https://github.com/code-corps/stripity-stripe"
      }
    ]
  end
end

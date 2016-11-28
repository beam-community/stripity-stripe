defmodule Stripe.Mixfile do
  use Mix.Project

  def project do
    [
      app: :stripity_stripe,
      deps: deps,
      description: description(),
      elixir: "~> 1.3",
      package: package(),
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      test_coverage: [tool: ExCoveralls],
      version: "2.0.0-alpha.4"
    ]
  end

  # Configuration for the OTP application
  def application do
    [
      applications: apps(Mix.env),
      env: env(),
      mod: {Stripe, []}
    ]
  end

  defp env() do
    [
      api_base_url: "https://api.stripe.com/v1/",
      pool_options: [
        timeout: 5_000,
        max_connections: 10
      ],
      use_connection_pool: true
    ]
  end

  defp apps(:test), do: [:bypass | apps()]
  defp apps(_), do: apps()
  defp apps(), do: [:hackney, :logger, :poison]

  defp deps do
    [
      {:bypass, "~> 0.5", only: :test},
      {:earmark, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.14", only: :dev},
      {:excoveralls, "~> 0.5", only: :test},
      {:hackney, "~> 1.6"},
      {:inch_ex, "~> 0.5", only: [:dev, :test]},
      {:poison, "~> 2.0 or ~> 3.0"}
    ]
  end

  defp description do
    """
    A Stripe client for Elixir.
    """
  end

  defp package do
    [
      files: ["lib", "LICENSE*", "mix.exs", "README*"],
      licenses: ["New BSD"],
      links: %{
        "GitHub" => "https://github.com/code-corps/stripity-stripe"
      },
      maintainers: ["Dan Matthews", "Josh Smith"]
    ]
  end
end

defmodule Stripe.Mixfile do
  use Mix.Project

  def project do
    [
      app: :stripity_stripe,
      deps: deps(),
      description: description(),
      dialyzer: [plt_add_apps: [:mix]],
      elixir: "~> 1.4",
      package: package(),
      elixirc_paths: elixirc_paths(Mix.env()),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      test_coverage: [tool: ExCoveralls],
      version: "2.0.0-beta.1"
    ]
  end

  # Configuration for the OTP application
  def application do
    [
      applications: apps(Mix.env()),
      env: env(),
      mod: {Stripe, []}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp env() do
    [
      api_base_url: "https://api.stripe.com/v1/",
      api_upload_url: "https://files.stripe.com/v1/",
      pool_options: [
        timeout: 5_000,
        max_connections: 10
      ],
      use_connection_pool: true
    ]
  end

  defp apps(:test), do: [:bypass | apps()]
  defp apps(_), do: apps()
  defp apps(), do: [:hackney, :logger, :poison, :uri_query]

  defp deps do
    [
      {:bypass, "~> 0.8.1", only: :test},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:earmark, "~> 1.2.5", only: :dev},
      {:ex_doc, "~> 0.18.3", only: :dev},
      {:excoveralls, "~> 0.8.1", only: :test},
      {:hackney, "~> 1.12.1"},
      {:inch_ex, "~> 0.5", only: [:dev, :test]},
      {:poison, "~> 2.0 or ~> 3.0"},
      {:uri_query, "~> 0.1.2"},
      {:exexec, "~> 0.1.0", only: :test}
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
      maintainers: ["Dan Matthews", "Josh Smith", "Nikola Begedin"]
    ]
  end
end

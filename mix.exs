defmodule Stripe.Mixfile do
  use Mix.Project

  def project do
    [ app: :stripity_stripe,
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
      deps: deps]
  end

  # Configuration for the OTP application
  def application do
    [
      applications: [:httpoison]
    ]
  end

  defp deps do
    [
      {:httpoison, ">= 0.0.0" },
      {:poison, ">= 0.0.0", optional: true},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:earmark, ">= 0.0.0", only: :dev},
      {:excoveralls, ">= 0.0.0", only: :test},
      {:mock, ">= 0.0.0", only: :test},
      {:inch_ex, ">= 0.0.0", only: [:dev, :test]}
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
        "GitHub" => "https://github.com/code-corps/stripity-stripe",
        "Docs" => "https://hexdocs.pm/stripity_stripe"
      }
    ]
  end

end

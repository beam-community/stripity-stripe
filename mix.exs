defmodule Stripe.Mixfile do
  use Mix.Project

  def project do
    [ app: :stripity_stripe,
      version: "1.4.0",
      description: description,
      package: package,
      elixir: "~> 1.1",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      deps: deps(Mix.env) ]
  end

  # Configuration for the OTP application
  def application do
    [
      applications: [:httpoison]
    ]
  end

  defp deps(:dev) do
    deps(:prod)
  end

  defp deps(:test) do
    deps(:dev)
  end

  defp deps(:prod) do
    [
      {:httpoison, "~> 0.9.0" },
      {:poison, "~> 1.5 or ~> 2.1.0", optional: true},
      {:ex_doc, "~> 0.7", only: :dev},
      {:earmark, ">= 0.0.0", only: :dev},
      {:excoveralls, "~> 0.5.4", only: :test},
      {:mock, "~> 0.1.1", only: :test},
      {:inch_ex, "~> 0.5.1", only: [:dev, :test]},

      {:apex, "~> 0.5.0", only: [:dev, :test]}
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
      maintainers: ["Rob Conery","Nic Rioux"],
      licenses: ["New BSD"],
      links: %{
        "GitHub" => "https://github.com/robconery/stripity-stripe",
        "Docs" => "https://hexdocs.pm/stripity_stripe"
      }
    ]
  end

end

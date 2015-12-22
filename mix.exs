defmodule Stripe.Mixfile do
  use Mix.Project

  def project do
    [ app: :stripity_stripe,
      version: "1.0.0",
      description: "A Stripe Library for Elixir",
      package: package,
      elixir: "~> 1.1.1",
      deps: deps(Mix.env) ]
  end

  # Configuration for the OTP application
  def application do
    [
      applications: [:httpoison],
      mod: { Stripe, [] }
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
      {:httpoison, "~> 0.7.4" },
      {:hackney, "~> 1.3.2" }, # not included in hex version of httpoison :(
      {:poison, "~> 1.5"},
      {:ex_doc, "~> 0.7", only: :dev},
      {:earmark, ">= 0.0.0"}
    ]
  end

  def package do
    [
      maintainers: ["Rob Conery","Nic Rioux"],
      licenses: ["New BSD"],
      links: %{"GitHub" => "https://github.com/robconery/stripity-stripe"}
    ]
  end

end

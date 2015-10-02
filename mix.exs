defmodule Stripe.Mixfile do
  use Mix.Project

  def project do
    [ app: :stripe,
      version: "0.2.0",
      elixir: "~> 1.0.5",
      deps: deps(Mix.env) ]
  end

  # Configuration for the OTP application
  def application do
    [mod: { Stripe, [] }]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  # Returns the list of development dependencies
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
      {:poison, "~> 1.5"}
    ]
  end
end

defmodule Stripe.Mixfile do
  use Mix.Project

  @source_url "https://github.com/code-corps/stripity_stripe"
  @version "2.12.1"

  def project do
    [
      app: :stripity_stripe,
      version: @version,
      elixir: "~> 1.10",
      deps: deps(),
      docs: docs(),
      package: package(),
      elixirc_paths: elixirc_paths(Mix.env()),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      dialyzer: [
        plt_add_apps: [:mix],
        plt_file: {:no_warn, "priv/plts/stripity_stripe.plt"}
      ],
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Configuration for the OTP application
  def application do
    [
      applications: apps(Mix.env()),
      extra_applications: [:plug],
      env: env(),
      mod: {Stripe, []}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp env do
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

  defp apps(:test), do: apps()
  defp apps(_), do: apps()
  defp apps, do: [:hackney, :logger, :jason, :uri_query]

  defp deps do
    [
      {:dialyxir, "1.1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:excoveralls, "~> 0.14.1", only: :test},
      {:hackney, "~> 1.15"},
      {:inch_ex, "~> 2.0", only: [:dev, :test]},
      {:mox, "~> 0.4", only: :test},
      {:jason, "~> 1.1"},
      {:uri_query, "~> 0.1.2"},
      {:exexec, "~> 0.1.0", only: :test},
      {:plug, "~> 1.0", optional: true}
    ]
  end

  defp docs do
    [
      extras: [
        "CHANGELOG.md": [title: "Changelog"],
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "master",
      formatters: ["html"],
      groups_for_modules: groups_for_modules(),
      nest_modules_by_prefix: nest_modules_by_prefix()
    ]
  end

  defp package do
    [
      description: "A Stripe client for Elixir.",
      files: ["lib", "LICENSE*", "mix.exs", "README*", "CHANGELOG*"],
      licenses: ["BSD-3-Clause"],
      maintainers: [
        "Dan Matthews",
        "Josh Smith",
        "Nikola Begedin",
        "Scott Newcomer"
      ],
      links: %{
        "GitHub" => @source_url
      }
    ]
  end

  defp groups_for_modules do
    [
      "Core Resources": [
        Stripe.Balance,
        Stripe.BalanceTransaction,
        Stripe.Charge,
        Stripe.Customer,
        Stripe.Dispute,
        Stripe.Event,
        Stripe.FileUpload,
        Stripe.FileLink,
        Stripe.Mandate,
        Stripe.PaymentIntent,
        Stripe.Payout,
        Stripe.Price,
        Stripe.Product,
        Stripe.Refund,
        Stripe.SetupIntent,
        Stripe.TaxID,
        Stripe.Token
      ],
      "Payment Methods": [
        Stripe.BankAccount,
        Stripe.Card,
        Stripe.PaymentMethod,
        Stripe.Source
      ],
      Checkout: [
        Stripe.Session
      ],
      Billing: [
        Stripe.Coupon,
        Stripe.CreditNote,
        Stripe.CreditNoteLineItem,
        Stripe.CustomerTransactionBalance,
        Stripe.Discount,
        Stripe.Invoice,
        Stripe.Invoiceitem,
        Stripe.LineItem,
        Stripe.Product,
        Stripe.Plan,
        Stripe.Subscription,
        Stripe.SubscriptionItem,
        Stripe.SubscriptionItem.Usage,
        Stripe.SubscriptionSchedule,
        Stripe.TaxRate
      ],
      "Billing Portal": [
        Stripe.BillingPortal.Session
      ],
      Connect: [
        Stripe.Account,
        Stripe.ApplicationFee,
        Stripe.Capability,
        Stripe.Connect.OAuth,
        Stripe.Connect.OAuth.AuthorizeResponse,
        Stripe.Connect.OAuth.DeauthorizeResponse,
        Stripe.Connect.OAuth.TokenResponse,
        Stripe.CountrySpec,
        Stripe.ExternalAccount,
        Stripe.FeeRefund,
        Stripe.LoginLink,
        Stripe.Recipient,
        Stripe.Topup,
        Stripe.Transfer,
        Stripe.TransferReversal
      ],
      Fraud: [
        Stripe.Review
      ],
      Identity: [
        Stripe.Identity.VerificationSession,
        Stripe.Identity.VerificationReport
      ],
      Issuing: [
        Stripe.Issuing.Authorization,
        Stripe.Issuing.Card,
        Stripe.Issuing.Cardholder,
        Stripe.Issuing.Transaction,
        Stripe.Issuing.Types
      ],
      "Relay/Orders": [
        Stripe.Order,
        Stripe.OrderItem,
        Stripe.OrderReturn,
        Stripe.Relay.Product,
        Stripe.Sku
      ],
      Terminal: [
        Stripe.Terminal.ConnectionToken,
        Stripe.Terminal.Location,
        Stripe.Terminal.Reader
      ],
      Utilities: [
        Stripe.Config,
        Stripe.Converter,
        Stripe.Types
      ]
    ]
  end

  def nest_modules_by_prefix() do
    [
      Stripe.Connect.OAuth,
      Stripe.Connect.OAuth.AuthorizeResponse,
      Stripe.Connect.OAuth.TokenResponse,
      Stripe.Connect.OAuth.DeauthorizeResponse
    ]
  end
end

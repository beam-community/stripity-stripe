use Mix.Config

import_config "*.secret.exs"

config :exvcr, [
  filter_sensitive_data: [
    [
      pattern: Application.get_env(:stripity_stripe, :api_key, System.get_env("STRIPE_SECRET_KEY")),
      placeholder: "STRIPE_SECRET_KEY"
    ]
  ]
]

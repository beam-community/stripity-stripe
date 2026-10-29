import Config

if File.exists?("config/config.secret.exs") do
  import_config "config.secret.exs"
end

config :erlexec,
  # erlexec is very particular about how it is run as root
  user: System.get_env("USER")

if config_env() == :test do
  # Tests record requests through `Stripe.StripeCase.RecordingClient`, which forwards them to
  # the hackney client, or to the Req client when running `STRIPE_HTTP_CLIENT=req mix test`.
  test_http_client =
    case System.get_env("STRIPE_HTTP_CLIENT") do
      "req" -> Stripe.HTTPClient.Req
      _ -> Stripe.HTTPClient.Hackney
    end

  config :stripity_stripe,
    http_client: Stripe.StripeCase.RecordingClient,
    test_http_client: test_http_client
end

ExUnit.start()
# Stripe.start
Application.ensure_all_started(:erlexec)
Application.ensure_all_started(:exexec)
ExUnit.configure(exclude: [disabled: true], seed: 0)
Logger.configure(level: :info)

{:ok, pid} = Stripe.StripeMock.start_link(port: 12123, global: true)
Process.sleep(250)
Application.put_env(:stripity_stripe, :api_base_url, "http://localhost:12123/v1/")
Application.put_env(:stripity_stripe, :api_key, "sk_test_123")

defmodule Helper do
  @fixture_path "./test/fixtures/"

  def load_fixture(filename) do
    File.read!(@fixture_path <> filename) |> Poison.decode!()
  end
end

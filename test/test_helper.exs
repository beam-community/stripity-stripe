ExUnit.start
#Stripe.start
Application.ensure_all_started(:erlexec)
Application.ensure_all_started(:exexec)
ExUnit.configure [exclude: [disabled: true], seed: 0 ]

defmodule Helper do
	@fixture_path "./test/fixtures/"

  def load_fixture(filename) do
    File.read!(@fixture_path <> filename) |> Poison.decode!
  end
end

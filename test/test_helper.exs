ExUnit.start
#Stripe.start
ExUnit.configure [exclude: [disabled: true], seed: 0 ]

defmodule Helper do
	@fixture_path "./test/fixtures/"

  def load_fixture(filename) do
    File.read!(@fixture_path <> filename) |> Poison.decode!
  end
end

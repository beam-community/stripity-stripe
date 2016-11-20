defmodule Stripe.Convert do
  @moduledoc false

  @doc """
  Converts data into its necessary format.
  """
  def with_format(nil, :datetime), do: nil
  def with_format(value, :datetime) do
    {:ok, result} = DateTime.from_unix(value)
    result
  end
  def with_format(value, _), do: value
end

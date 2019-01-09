defmodule Stripe.Config do
  @moduledoc """
  Utility that handles interaction with the application's configuration
  """

  @base_key :stripity_stripe

  @doc """
  Resolves the given key from the application's configuration returning the
  wrapped expanded value. If the value was a function it get's evaluated, if
  the value vas a touple of three elements it gets applied.
  """
  @spec resolve(any) :: any
  def resolve(key) do
    Application.get_env(@base_key, key)
    |> expand_value()
  end

  defp expand_value({module, function, args})
  when is_atom(function) and is_list(args)
  do
    apply(module, function, args)
  end
  defp expand_value(value) when is_function(value) do
    value.()
  end
  defp expand_value(value), do: value
end

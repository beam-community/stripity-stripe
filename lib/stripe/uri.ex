defmodule Stripe.URI do
  @moduledoc """
  Stripe URI helpers to encode nested dictionaries as query_params.
  """

  defmacro __using__(_) do
    quote do
      defp build_url(ext \\ "") do
        if ext != "", do: ext = "/" <> ext

        @base <> ext
      end
    end
  end

  @doc """
  Takes a flat or nested HashDict and turns it into proper query values.

  ## Example
  card = HashDict.new([
    card: HashDict.new([
      number: 424242424242,
      exp_year: 2014
    ])
  ])

  Stripe.URI.encode_query(card) # card[number]=424242424242&card[exp_year]=2014
  """
  def encode_query(list) do
    Enum.map_join list, "&", fn x ->
      pair(x)
    end
  end

  defp pair({key, value}) do
    cond do
      Enumerable.impl_for(value) ->
        pair(to_string(key), [], value)
      true ->
        param_name = key |> to_string |> URI.encode
        param_value = value |> to_string |> URI.encode

        "#{param_name}=#{param_value}"
    end
  end

  defp pair(root, parents, values) do
    Enum.map_join values, "&", fn {key, value} ->
      cond do
        Enumerable.impl_for(value) ->
          pair(root, parents ++ [key], value)
        true ->
          build_key(root, parents ++ [key]) <> to_string(value)
      end
    end
  end

  defp build_key(root, parents) do
    path = Enum.map_join parents, "", fn x ->
      param = x |> to_string |> URI.encode
      "[#{param}]"
    end

    "#{root}#{path}="
  end
end

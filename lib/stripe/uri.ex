defmodule Stripe.URI do
  @moduledoc false
  @http_param_sep "&"

  defmacro __using__(_) do
    quote do
      defp build_url(""), do: @base
      defp build_url(ext), do: @base <> "/" <> ext
    end
  end

  @doc """
  Takes a map and turns it into proper query values.

  ## Parameters
    - list: a map of query parameters and values, which may themselves be maps

  ## Examples
  iex> Stripe.URI.encode_query(%{"card": %{"number": 1234, "exp_year": 2014}})
  "card[exp_year]=2014&card[number]=1234"
  """
  @spec encode_query(Enum.t) :: String.t
  def encode_query(list) do
    Enum.map_join list, @http_param_sep, &(pair(&1))
  end

  defp pair({key, values})
  when is_list(values) or is_map(values) do
    pair(to_string(key), [], values)
  end

  defp pair({key, value}) do
    "#{encoded_string(key)}=#{encoded_string(value)}"
  end

  defp pair(root, parents, values) do
    Enum.map_join values, @http_param_sep, fn {key, value} ->
      new_parents = [key | parents]
      case is_list(value) || is_map(value) do
        true ->
          pair(root, new_parents, value)
        _ ->
          build_key(root, Enum.reverse(new_parents)) <> encoded_string(value)
      end
    end
  end

  defp build_key(root, parents) do
    path = Enum.map_join parents, "", fn x ->
      "[#{encoded_string(x)}]"
    end

    "#{root}#{path}="
  end

  defp encoded_string(value), do: value |> to_string |> URI.encode_www_form
end

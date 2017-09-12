defmodule Stripe.Entity do
  @callback __from_json__(data :: map) :: map

  defmacro __using__(_opts) do
    quote do
      require Stripe.Entity
      import Stripe.Entity, only: [from_json: 2]
      @behaviour Stripe.Entity
      def __from_json__(data), do: data
      defoverridable [__from_json__: 1]
    end
  end

  defmacro from_json(param, do: block) do
    quote do
      def __from_json__(unquote(param)) do
        import Stripe.Entity, only: [cast_to_atom: 2, cast_each: 3, cast_path: 3]
        unquote(block)
      end
    end
  end

  def cast_to_atom(%{} = data, keys) when is_list(keys) do
    Enum.reduce(keys, data, fn key, data -> cast_to_atom(data, key) end)
  end

  def cast_to_atom(%{} = data, key) do
    key = List.wrap(key)
    maybe_update_in(data, key, maybe(&String.to_atom/1))
  end

  def cast_each(%{} = data, keys, fun) when is_list(keys) and is_function(fun) do
    Enum.reduce(keys, data, fn key, data -> cast_each(data, key, fun) end)
  end

  def cast_each(%{} = data, key, fun) when is_function(fun) do
    key = List.wrap(key)
    maybe_update_in(data, key, maybe(&Enum.map(&1, fun)))
  end

  def cast_path(%{} = data, path, fun) when is_function(fun) do
    maybe_update_in(data, path, fun)
  end

  defp maybe(fun) do
    fn nil -> nil; arg -> fun.(arg) end
  end

  defp maybe_update_in(data, path, fun) do
    case get_in(data, path) do
      nil -> data
      val -> put_in(data, path, fun.(val))
    end
  end
end

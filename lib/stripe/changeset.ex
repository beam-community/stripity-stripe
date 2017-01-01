defmodule Stripe.Changeset do
  alias Stripe.Util

  @doc """
  Takes changes as a map with atom or string keys, a nested schema map,
  and an optional list of keys that can be unset.

  Returns a whitelisted map that can be used to send to Stripe.
  """
  @spec cast(map, map, atom, list) :: map
  def cast(changes, schema, operation, nullable_keys \\ []) do
    keys = Map.keys(schema)
    changes = Util.atomize_keys(changes)

    Enum.reduce(keys, %{}, fn key, acc ->
      schema_value = schema[key]
      change = Map.get(changes, key)
      acc |> apply_changes(key, change, operation, schema_value, nullable_keys)
    end)
  end

  defp apply_changes(acc, key, change, op, schema_value, _) when is_map(change) and not is_list(schema_value) do
    Map.put(acc, key, cast(change, schema_value, op))
  end
  defp apply_changes(acc, key, change, op, schema_value, nullable_keys) do
    check_operation(acc, key, change, op, schema_value, nullable_keys)
  end

  defp check_operation(acc, key, change, op, ops, nullable_keys) do
    case Enum.member?(ops, op) do
      true  -> attempt_change(acc, key, change, nullable_keys)
      false -> acc
    end
  end

  defp attempt_change(acc, key, nil = change, nullable_keys) do
    case Enum.member?(nullable_keys, key) do
      true  -> put_change(acc, key, change)
      false -> acc
    end
  end
  defp attempt_change(acc, key, change, _nullable_keys), do: put_change(acc, key, change)

  defp put_change(acc, key, change) do
    Map.put(acc, key, change)
  end
end

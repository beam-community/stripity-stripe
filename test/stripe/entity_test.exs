defmodule Stripe.EntityTest do
  use ExUnit.Case, async: true
  import Stripe.Entity

  defmodule SampleEntity do
    use Stripe.Entity

    from_json data do
      data
      |> cast_to_atom(:foo)
    end
  end

  defmodule SampleEntity2 do
    use Stripe.Entity
  end

  test "a module using Stripe.Entity has a default implementation of `__from_json__/1`" do
    map = %{foo: "bar"}
    assert SampleEntity2.__from_json__(map) == map
  end

  test "a module using Stripe.Entity and the `from_json/2` macro defines a `__from_json__/1` function with the user's logic" do
    map = %{foo: "bar", abc: "xyz"}
    expected = %{foo: :bar, abc: "xyz"}
    assert SampleEntity.__from_json__(map) == expected
  end

  test "cast_to_atom/2 casts a single key or multiple keys to an atom, even when some don't exist or are nil" do
    assert cast_to_atom(%{foo: "bar", abc: "xyz"}, :foo) == %{foo: :bar, abc: "xyz"}
    assert cast_to_atom(%{foo: "bar", abc: "xyz"}, [:foo, :abc]) == %{foo: :bar, abc: :xyz}
    assert cast_to_atom(%{}, :foo) == %{}
    assert cast_to_atom(%{foo: "bar", xyz: nil}, [:foo, :abc, :xyz]) == %{foo: :bar, xyz: nil}
  end

  test "cast_each/3 casts each element of a list according to the given function with a single or multiple keys, even when some are missing or nil" do
    map = %{foo: [%{foo: "bar"}, %{foo: "xyz"}]}
    expected = %{foo: [%{foo: :bar}, %{foo: :xyz}]}
    assert cast_each(map, :foo, &cast_to_atom(&1, :foo)) == expected

    map = %{foo: [%{foo: "bar"}, %{foo: "xyz"}], bar: [%{foo: "bar"}]}
    expected = %{foo: [%{foo: :bar}, %{foo: :xyz}], bar: [%{foo: :bar}]}
    assert cast_each(map, [:foo, :bar], &cast_to_atom(&1, :foo)) == expected

    map = %{foo: nil, bar: [%{foo: "bar"}], abc: []}
    expected = %{foo: nil, bar: [%{foo: :bar}], abc: []}
    assert cast_each(map, [:foo, :bar, :baz, :abc], &cast_to_atom(&1, :foo)) == expected
  end

  test "cast_path/3 casts the element at the given path according to the given function, no errors when the path is missing" do
    map = %{
      foo: %{
        bar: "abc"
      }
    }

    expected = %{
      foo: %{
        bar: :abc
      }
    }

    assert cast_path(map, [:foo], &cast_to_atom(&1, :bar)) == expected

    map = %{
      foo: nil
    }

    expected = %{
      foo: nil
    }

    assert cast_path(map, [:foo, :bar], &cast_to_atom(&1, :baz)) == expected
  end
end

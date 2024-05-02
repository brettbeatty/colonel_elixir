defmodule Colonel.ExperimentalTest do
  use ExUnit.Case, async: true
  import Colonel.Experimental
  doctest Colonel.Experimental

  describe "recursive/1" do
    test "creates a simple recursive function" do
      fun =
        recursive fn
          1, acc ->
            acc

          value, acc ->
            super(value - 1, acc * value)
        end

      assert fun.(5, 1) == 120
    end

    test "works with guard clauses" do
      fun =
        recursive fn
          x when x < 5 ->
            [x | super(x + 1)]

          5 ->
            []
        end

      assert fun.(0) == [0, 1, 2, 3, 4]
    end

    test "works with multiple guard clauses" do
      fun =
        recursive fn
          value, acc when is_atom(value) when is_binary(value) ->
            [value | acc]

          [head | tail], acc ->
            super(tail, super(head, acc))

          _value, acc ->
            acc
        end

      assert fun.([:a, "b", ?c, ["d", [:e]], ~c"f"], [?g]) == [:e, "d", "b", :a, ?g]
    end

    test "works with 0-arity functions" do
      fun =
        recursive fn ->
          receive do
            msg -> [msg | super()]
          after
            0 -> []
          end
        end

      send(self(), :a)
      send(self(), :b)
      send(self(), :c)

      assert fun.() == [:a, :b, :c]
    end

    test "does not conflict with injected variables" do
      self_fun = fn x, y, z -> {x, y, z} end
      arg1 = "arg 1"
      arg2 = make_ref()

      fun =
        recursive fn
          [:self_fun | steps] ->
            assert self_fun.(:a, :b, :c) == {:a, :b, :c}
            super(steps)

          [:arg1 | steps] ->
            assert arg1 == "arg 1"
            super(steps)

          [:arg2] ->
            arg2
        end

      assert fun.([:self_fun, :arg1, :arg2]) == arg2
    end
  end
end

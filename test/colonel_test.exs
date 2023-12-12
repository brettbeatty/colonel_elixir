defmodule ColonelTest do
  use ExUnit.Case, async: true
  doctest Colonel

  test "greets the world" do
    assert Colonel.hello() == :world
  end
end

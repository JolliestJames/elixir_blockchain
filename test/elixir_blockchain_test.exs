defmodule ElixirBlockchainTest do
  use ExUnit.Case
  doctest ElixirBlockchain

  test "greets the world" do
    assert ElixirBlockchain.hello() == :world
  end
end

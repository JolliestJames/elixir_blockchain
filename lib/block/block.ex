defmodule Block do
  defstruct [:data, :timestamp, :previous, :current]

  @doc "Build a new block for given data and previous hash"
  def new(data, previous) do
    %Block{
      data: data,
      previous: previous,
      timestamp: NaiveDateTime.utc_now,
    }
  end

  @doc "Build the initial block of the chain"
  def zero do
    %Block{
      data: "ZERO_DATA",
      previous: "ZERO_HASH",
      timestamp: NaiveDateTime.utc_now,
    }
  end

  @doc "Validate block"
  def valid?(%Block{} = block) do
    Crypto.hash(block) == block.hash
  end

  def valid?(%Block{} = current, %Block{} = previous) do
    (current.previous == previous.current) && valid?(current)
  end
end

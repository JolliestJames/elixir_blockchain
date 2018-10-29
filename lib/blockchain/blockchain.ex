defmodule Blockchain do
  @doc "Create a new blockchain"
  def new do
    [ Crypto.put_hash(Block.zero) ]
  end

  @doc "Insert given data as a new block in the blockchain"
  def insert(blockchain, data) when is_list(blockchain) do
    %Block{hash: previous} = hd(blockchain)
    block =
      data
      |> Block.new(previous)
      |> Crypto.put_hash
    [ block | blockchain ]
  end

  @doc "Validate the blockchain"
  def valid?(blockchain) when is_list(blockchain) do
    zero = Enum.reduce_while(blockchain, nil, fn previous, current ->
      cond do
        current == nil ->
          {:cont, previous}
        Block.valid?(current, previous) ->
          {:cont, previous}
        true ->
          {:halt, false}
      end
    end)
    if zero, do: Block.valid?(zero), else: false
  end
end

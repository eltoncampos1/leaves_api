defmodule Leafs.Ports.Repository do
  alias Leaf.Core.Leaf

  @adapter Application.compile_env!(:leafs, [__MODULE__, :adapter])

  @callback create(leaf :: Leaf.t()) :: :ok | :error
  @callback get(id :: binary()) :: Leaf.t() | nil
  @callback all() :: [Leaf.t()]

  @spec create(leaf :: Leaf.t()) :: :ok | :error
  defdelegate create(leaf), to: @adapter

  @spec get(id :: binary()) :: Leaf.t() | nil
  defdelegate get(id), to: @adapter

  @spec all() :: [Leaf.t()]
  defdelegate all(), to: @adapter

  def adapter, do: @adapter
end

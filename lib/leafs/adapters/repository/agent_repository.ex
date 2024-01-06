defmodule Leafs.Adapters.Repository.AgentRepository do
  @behaviour Leafs.Ports.Repository

  use Agent
  alias Leafs.Core.Leaf

  def start_link(initial_value \\ []) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def create(%Leaf{} = leaf) do
    Agent.update(__MODULE__, fn state -> [leaf | state] end)
  end

  def get(id) do
    Agent.get(__MODULE__, &Enum.find(&1, fn leaf -> leaf.id == id end))
  end

  def all do
    Agent.get(__MODULE__, & &1)
  end
end

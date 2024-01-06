defmodule Leafs.Adapters.Repository.GenServerRepository do
  @moduledoc """
  GenServer Repository Adapter
  """
  @behaviour Leafs.Ports.Repository
  use GenServer

  alias Leafs.Core.Leaf

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(state \\ []) do
    {:ok, state}
  end

  def get(id) do
    GenServer.call(__MODULE__, {:get, id})
  end

  def all() do
    GenServer.call(__MODULE__, {:all})
  end

  def create(%Leaf{} = leaf) do
    GenServer.cast(__MODULE__, {:create, leaf})
  end

  def handle_call({:all}, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:get, id}, _from, state) do
    {:reply, Enum.find(state, fn leaf -> leaf.id == id end), state}
  end

  def handle_cast({:create, %Leaf{} = leaf}, state) do
    {:noreply, [leaf | state]}
  end
end

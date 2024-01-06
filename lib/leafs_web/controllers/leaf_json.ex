defmodule LeafsWeb.LeafJSON do
  alias Leafs.Core.Leaf

  def index(%{leafs: leafs}) do
    %{data: for(leaf <- leafs, do: data(leaf))}
  end

  def show(%{leaf: leaf}) do
    %{data: data(leaf)}
  end

  def errors(%{errors: errors}) when is_list(errors) do
    IO.inspect(errors)
    %{errors: for(error <- errors, do: error(error))}
  end

  defp error({field, msg}) do
    %{field => msg}
  end

  defp data(%Leaf{} = leaf) do
    %{
      id: leaf.id,
      name: leaf.name,
      color: leaf.color,
      origin: leaf.origin
    }
  end
end

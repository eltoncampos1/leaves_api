defmodule Leafs.Core.Leaf do
  defstruct ~w(id name color origin)a

  def new(name, color, origin) do
    %__MODULE__{id: generate_id(), name: name, color: color, origin: origin}
  end

  defp generate_id, do: UUID.uuid4()
end

defmodule Leafs do
  @moduledoc """
  Leafs keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Leafs.Ports.Repository, as: Repo
  alias Leafs.Boundary.LeafValidator
  alias Leafs.Core.Leaf

  def all do
    Repo.all()
  end

  def create(params) do
    with :ok <- LeafValidator.errors(params),
         %Leaf{} = leaf <- Leaf.new(params["name"], params["color"], params["origin"]),
         :ok <- Repo.create(leaf) do
      {:ok, leaf}
    end
  end

  def get_by_id(id) when is_binary(id) do
    case Repo.get(id) do
      nil -> {:error, :not_found}
      %Leaf{} = leaf -> {:ok, leaf}
    end
  end

  def get_by_id(_id), do: {:error, :invalid_id}
end

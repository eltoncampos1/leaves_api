defmodule LeafsWeb.LeafController do
  use LeafsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.json", leafs: Leafs.all())
  end

  def show(conn, %{"id" => id}) do
    case Leafs.get_by_id(id) do
      {:ok, leaf} -> render(conn, "show.json", leaf: leaf)
      {:error, :not_found} -> send_resp(conn, 404, "Not Found")
    end
  end

  def create(conn, params) do
    case Leafs.create(params) do
      {:ok, leaf} -> render(conn, "show.json", leaf: leaf)
      errors -> render(conn, "errors.json", errors: errors)
    end
  end
end

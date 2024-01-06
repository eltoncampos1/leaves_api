defmodule LeafsWeb.ErrorJSONTest do
  use LeafsWeb.ConnCase, async: true

  test "renders 404" do
    assert LeafsWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert LeafsWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end

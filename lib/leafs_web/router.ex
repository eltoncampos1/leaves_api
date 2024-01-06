defmodule LeafsWeb.Router do
  use LeafsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {LeafsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LeafsWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api", LeafsWeb do
    pipe_through :api

    resources "/leaves", LeafController
  end

  # Other scopes may use custom stacks.
  # scope "/api", LeafsWeb do
  #   pipe_through :api
  # end
end

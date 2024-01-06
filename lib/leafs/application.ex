defmodule Leafs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  @repo Leafs.Ports.Repository.adapter()

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      LeafsWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:leafs, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Leafs.PubSub},
      # Start a worker by calling: Leafs.Worker.start_link(arg)
      # {Leafs.Worker, arg},
      # Start to serve requests, typically the last entry
      LeafsWeb.Endpoint,
      @repo
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Leafs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LeafsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

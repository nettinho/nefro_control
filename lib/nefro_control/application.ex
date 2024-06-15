defmodule NefroControl.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NefroControlWeb.Telemetry,
      NefroControl.Repo,
      {DNSCluster, query: Application.get_env(:nefro_control, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: NefroControl.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: NefroControl.Finch},
      # Start a worker by calling: NefroControl.Worker.start_link(arg)
      # {NefroControl.Worker, arg},
      # Start to serve requests, typically the last entry
      NefroControlWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NefroControl.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NefroControlWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

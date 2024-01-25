defmodule NomeDoProjeto.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NomeDoProjetoWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:nome_do_projeto, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: NomeDoProjeto.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: NomeDoProjeto.Finch},
      # Start a worker by calling: NomeDoProjeto.Worker.start_link(arg)
      # {NomeDoProjeto.Worker, arg},
      # Start to serve requests, typically the last entry
      NomeDoProjetoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NomeDoProjeto.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NomeDoProjetoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

defmodule Kyoko.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Kyoko.Repo,
      # Start the Telemetry supervisor
      KyokoWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Kyoko.PubSub},
      # Start the Endpoint (http/https)
      KyokoWeb.Endpoint,
      # Start a worker by calling: Kyoko.Worker.start_link(arg)
      # {Kyoko.Worker, arg}
      KyokoWeb.Presence
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Kyoko.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KyokoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

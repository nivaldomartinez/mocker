defmodule Mocker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MockerWeb.Telemetry,
      # Start the Ecto repository
      Mocker.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Mocker.PubSub},
      # Start the Endpoint (http/https)
      MockerWeb.Endpoint
      # Start a worker by calling: Mocker.Worker.start_link(arg)
      # {Mocker.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mocker.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MockerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

defmodule ToyRobot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Must be started when using this implementation
      #ToyRobot.Server
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ToyRobot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule ToyRobot do
  @behaviour ToyRobot.Behaviour
  #@implementation ToyRobot.Simple
  @implementation ToyRobot.Server

  @impl true
  defdelegate get(), to: @implementation

  @impl true
  defdelegate report(robot), to: @implementation

  @impl true
  defdelegate move(robot), to: @implementation

  @impl true
  defdelegate left(robot), to: @implementation

  @impl true
  defdelegate right(robot), to: @implementation

  @impl true
  defdelegate place(robot, x, y, f), to: @implementation
end

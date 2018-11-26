defmodule ToyRobot.Behaviour do
  @type robot :: any()
  @type direction :: String.t()

  @callback get() :: robot()

  @callback report(robot()) :: robot()
  @callback place(robot(), x :: integer(), y :: integer(), f :: direction()) :: robot()
  @callback move(robot) :: robot()
  @callback left(robot) :: robot()
  @callback right(robot) :: robot()
end

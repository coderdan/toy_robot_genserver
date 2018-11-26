defmodule ToyRobot do
  @behaviour ToyRobot.Behaviour
  defstruct [:x, :y, :f]

  defguard is_grid(x) when is_integer(x) and x in 0..5
  defguard is_compass(f) when f in ["N", "S", "E", "W"]
  defguard is_place(x, y, f) when is_grid(x) and is_grid(y) and is_compass(f)

  @impl true
  def report(%ToyRobot{} = robot) do
    robot
  end

  @impl true
  def place(%ToyRobot{} = robot, x, y, f) when is_place(x, y, f) do
    %{robot | x: x, y: y, f: f}
  end
  def place(robot, _, _, _), do: robot

  @impl true
  def left(%ToyRobot{f: "N"} = robot), do: %{robot | f: "W"}
  def left(%ToyRobot{f: "E"} = robot), do: %{robot | f: "N"}
  def left(%ToyRobot{f: "S"} = robot), do: %{robot | f: "E"}
  def left(%ToyRobot{f: "W"} = robot), do: %{robot | f: "S"}
  def left(r), do: r

  @impl ToyRobot.Behaviour
  def right(%ToyRobot{f: "N"} = robot), do: %{robot | f: "E"}
  def right(%ToyRobot{f: "E"} = robot), do: %{robot | f: "S"}
  def right(%ToyRobot{f: "S"} = robot), do: %{robot | f: "W"}
  def right(%ToyRobot{f: "W"} = robot), do: %{robot | f: "N"}
  def right(r), do: r

  @impl true
  def move(%ToyRobot{y: y, f: "N"} = robot) when y < 5 do
    %{robot | y: y + 1}
  end
  def move(%ToyRobot{y: y, f: "S"} = robot) when y > 0 do
    %{robot | y: y - 1}
  end
  def move(%ToyRobot{x: x, f: "E"} = robot) when x < 5 do
    %{robot | x: x + 1}
  end
  def move(%ToyRobot{x: x, f: "W"} = robot) when x > 0 do
    %{robot | x: x - 1}
  end
  def move(r), do: r
end

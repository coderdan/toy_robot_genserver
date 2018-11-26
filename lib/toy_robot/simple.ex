defmodule ToyRobot.Simple do
  @behaviour ToyRobot.Behaviour
  defstruct [:x, :y, :f]

  defguard is_grid(x) when is_integer(x) and x in 0..5
  defguard is_compass(f) when f in ["N", "S", "E", "W"]
  defguard is_place(x, y, f) when is_grid(x) and is_grid(y) and is_compass(f)

  @impl true
  def get do
    %__MODULE__{}
  end

  @impl true
  def report(%__MODULE__{} = robot) do
    robot
  end

  @impl true
  def place(%__MODULE__{} = robot, x, y, f) when is_place(x, y, f) do
    %{robot | x: x, y: y, f: f}
  end
  def place(robot, _, _, _), do: robot

  @impl true
  def left(%__MODULE__{f: "N"} = robot), do: %{robot | f: "W"}
  def left(%__MODULE__{f: "E"} = robot), do: %{robot | f: "N"}
  def left(%__MODULE__{f: "S"} = robot), do: %{robot | f: "E"}
  def left(%__MODULE__{f: "W"} = robot), do: %{robot | f: "S"}
  def left(r), do: r

  @impl ToyRobot.Behaviour
  def right(%__MODULE__{f: "N"} = robot), do: %{robot | f: "E"}
  def right(%__MODULE__{f: "E"} = robot), do: %{robot | f: "S"}
  def right(%__MODULE__{f: "S"} = robot), do: %{robot | f: "W"}
  def right(%__MODULE__{f: "W"} = robot), do: %{robot | f: "N"}
  def right(r), do: r

  @impl true
  def move(%__MODULE__{y: y, f: "N"} = robot) when y < 5 do
    %{robot | y: y + 1}
  end
  def move(%__MODULE__{y: y, f: "S"} = robot) when y > 0 do
    %{robot | y: y - 1}
  end
  def move(%__MODULE__{x: x, f: "E"} = robot) when x < 5 do
    %{robot | x: x + 1}
  end
  def move(%__MODULE__{x: x, f: "W"} = robot) when x > 0 do
    %{robot | x: x - 1}
  end
  def move(r), do: r
end

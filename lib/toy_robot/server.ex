defmodule ToyRobot.Server do
  use GenServer
  @behaviour ToyRobot.Behaviour

  @impl ToyRobot.Behaviour
  def report(robot) do
    GenServer.call(robot, :report)
  end

  @impl ToyRobot.Behaviour
  def place(robot, x, y, f) do
    GenServer.call(robot, {:place, x, y, f})
  end

  @impl ToyRobot.Behaviour
  def move(robot) do
    GenServer.call(robot, :move)
  end

  @impl ToyRobot.Behaviour
  def left(robot) do
    GenServer.call(robot, :left)
  end

  @impl ToyRobot.Behaviour
  def right(robot) do
    GenServer.call(robot, :right)
  end

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl GenServer
  def init(_opts) do
    {:ok, %ToyRobot{}}
  end

  @impl GenServer
  def handle_call(:report, _from, state) do
    state
    |> ToyRobot.report
    |> do_reply
  end
  def handle_call({:place, x, y, f}, _from, state) do
    state
    |> ToyRobot.place(x, y, f)
    |> do_reply
  end
  def handle_call(:move, _from, state) do
    state
    |> ToyRobot.move
    |> do_reply
  end
  def handle_call(:left, _from, state) do
    state
    |> ToyRobot.left
    |> do_reply
  end
  def handle_call(:right, _from, state) do
    state
    |> ToyRobot.right
    |> do_reply
  end
  def handle_call(_, _, state) do
    {:reply, :error, state}
  end

  defp do_reply(state) do
    {:reply, state, state}
  end
end

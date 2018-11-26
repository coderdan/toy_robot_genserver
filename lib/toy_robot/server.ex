defmodule ToyRobot.Server do
  use GenServer
  @behaviour ToyRobot.Behaviour

  @impl ToyRobot.Behaviour
  def get do
    __MODULE__
  end

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

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl GenServer
  def init(_opts) do
    {:ok, %ToyRobot.Simple{}}
  end

  @impl GenServer
  def handle_call(:report, _from, state) do
    state
    |> ToyRobot.Simple.report
    |> do_reply
  end
  def handle_call({:place, x, y, f}, _from, state) do
    state
    |> ToyRobot.Simple.place(x, y, f)
    |> do_reply
  end
  def handle_call(:move, _from, state) do
    state
    |> ToyRobot.Simple.move
    |> do_reply
  end
  def handle_call(:left, _from, state) do
    state
    |> ToyRobot.Simple.left
    |> do_reply
  end
  def handle_call(:right, _from, state) do
    state
    |> ToyRobot.Simple.right
    |> do_reply
  end
  def handle_call(_, _, state) do
    {:reply, :error, state}
  end

  defp do_reply(state) do
    {:reply, state, state}
  end
end

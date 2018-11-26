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

  def start_link(args \\ []) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  @impl GenServer
  def init(args) do
    handler = Keyword.get(args, :handler, ToyRobot.Simple)

    {:ok, {handler, handler.get()}}
  end

  @impl GenServer
  def handle_call(:report, _from, {handler, robot} = state) do
    robot
    |> handler.report
    |> do_reply(state)
  end
  def handle_call({:place, x, y, f}, _from, {handler, robot} = state) do
    robot
    |> handler.place(x, y, f)
    |> do_reply(state)
  end
  def handle_call(:move, _from, {handler, robot} = state) do
    robot
    |> handler.move
    |> do_reply(state)
  end
  def handle_call(:left, _from, {handler, robot} = state) do
    robot
    |> handler.left
    |> do_reply(state)
  end
  def handle_call(:right, _from, {handler, robot} = state) do
    robot
    |> handler.right
    |> do_reply(state)
  end
  def handle_call(_, _, state) do
    {:reply, :error, state}
  end

  defp do_reply(reply, {handler, _old_state}) do
    {:reply, reply, {handler, reply}}
  end
end

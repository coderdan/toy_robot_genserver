defmodule ToyRobot do
  use GenServer

  defguard is_grid(x) when is_integer(x)
  defguard is_compass(f) when f in ["N", "S", "E", "W"]
  defguard is_place(x, y, f) when is_grid(x) and is_grid(y) and is_compass(f)
  defguard can_move?(x) when x > 0 and x < 5

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_opts) do
    {:ok, :unplaced}
  end

  def report do
    GenServer.call(__MODULE__, :report)
  end

  def place(x, y, f) do
    GenServer.call(__MODULE__, {:place, x, y, f})
  end

  def move do
    GenServer.call(__MODULE__, :move)
  end

  def left do
    GenServer.call(__MODULE__, :left)
  end

  def handle_call(:report, _from, state) do
    {:reply, state, state}
  end
  def handle_call({:place, x, y, f}, _from, _state) when is_place(x, y, f) do
    reply_ok({x, y, f})
  end
  def handle_call(:move, _from, {x, y, "N"}) when can_move?(y) do
    reply_ok({x, y + 1, "N"})
  end

  def handle_call(:left, _from, {x, y, "N"}), do: reply_ok({x, y, "W"})
  def handle_call(:left, _from, {x, y, "W"}), do: reply_ok({x, y, "S"})
  def handle_call(:left, _from, {x, y, "S"}), do: reply_ok({x, y, "E"})
  def handle_call(:left, _from, {x, y, "E"}), do: reply_ok({x, y, "N"})


  def handle_call(:right, _from, {x, y, "N"}), do: reply_ok({x, y, "E"})
  def handle_call(:right, _from, {x, y, "W"}), do: reply_ok({x, y, "N"})
  def handle_call(:right, _from, {x, y, "S"}), do: reply_ok({x, y, "W"})
  def handle_call(:right, _from, {x, y, "E"}), do: reply_ok({x, y, "S"})

  def handle_call(_, _, state), do: reply_err(state)

  defp reply_ok(state), do: {:reply, :ok, state}
  defp reply_err(state), do: {:reply, :error, state}
end

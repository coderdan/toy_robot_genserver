defmodule ToyRobot do
  use GenServer

  defguard is_grid(x) when is_integer(x)
  defguard is_compass(f) when f in ["N", "S", "E", "W"]
  defguard is_place(x, y, f) when is_grid(x) and is_grid(y) and is_compass(f)
  defguard can_move?(x) when x > 0 and x < 5

  @directions ["N", "E", "S", "W"]

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

  def right do
    GenServer.call(__MODULE__, :right)
  end

  def handle_call(:report, _from, {x, y, [f | _]} = state) do
    {:reply, {x, y, f}, state}
  end
  def handle_call({:place, x, y, f}, _from, _state) when is_place(x, y, f) do
    reply_ok({x, y, set_direction(f)})
  end
  def handle_call(:move, _from, {x, y, ["N" | _] = f}) when y <= 5 do
    reply_ok({x, y + 1, f})
  end
  def handle_call(:move, _from, {x, y, ["S" | _] = f}) when y >= 0 do
    reply_ok({x, y - 1, f})
  end
  def handle_call(:move, _from, {x, y, ["W" | _] = f}) when x >= 0 do
    reply_ok({x - 1, y, f})
  end
  def handle_call(:move, _from, {x, y, ["E" | _] = f}) when x <= 5 do
    reply_ok({x + 1, y, f})
  end
  def handle_call(:left, _from, {x, y, f}) do
    reply_ok({x, y, r_left(f)})
  end
  def handle_call(:right, _from, {x, y, f}) do
    reply_ok({x, y, r_right(f)})
  end
  def handle_call(_, _, state) do
    {:reply, :error, state}
  end

  defp reply_ok(state), do: {:reply, :ok, state}

  defp r_right([curr | rest]) do
    rest ++ [curr]
  end
  defp r_left([a, b, c, d]) do
    [d, a, b, c]
  end

  defp set_direction(facing) do
    Enum.reduce_while(@directions, @directions, fn _, [f | _] = acc ->
      if f == facing, do: {:halt, acc}, else: {:cont, r_right(acc)}
    end)
  end
end

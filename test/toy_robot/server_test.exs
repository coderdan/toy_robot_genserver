defmodule ToyRobotTest.Server do
  use ExUnit.Case, async: true
  import Mox

  setup :verify_on_exit!
  setup :set_mox_global

  setup_all do
    Mox.defmock(ToyRobotTest.RobotMock, for: ToyRobot.Behaviour)

    :ok
  end

  setup do
    expect(ToyRobotTest.RobotMock, :get, fn -> ToyRobotTest.RobotMock end)

    {:ok, pid} = GenServer.start_link(ToyRobot.Server, handler: ToyRobotTest.RobotMock)

    [pid: pid]
  end

  describe "place/4" do
    setup do
      expect(ToyRobotTest.RobotMock, :place, fn _, x, y, f ->
        {x, y, f}
      end)

      :ok
    end

    test "that the robot is placed", %{pid: pid} do
      assert ToyRobot.Server.place(pid, 1, 1, "N") == {1, 1, "N"}
    end
  end

  describe "move/1" do
    setup do
      expect(ToyRobotTest.RobotMock, :move, fn _ ->
        100
      end)

      :ok
    end

    test "that the robot is moved", %{pid: pid} do
      assert ToyRobot.Server.move(pid) == 100
    end
  end
end

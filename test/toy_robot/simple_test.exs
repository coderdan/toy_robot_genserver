defmodule ToyRobotTest.Simple do
  use ExUnit.Case
  doctest ToyRobot.Simple

  describe "place/4" do
    # Great candidate for property testing!
    test "that the robot is placed within the board" do
      assert match?(
        %ToyRobot.Simple{x: 1, y: 1, f: "N"},
        ToyRobot.Simple.place(%ToyRobot.Simple{}, 1, 1, "N")
      )
    end

    test "that the robot is not placed if params are out of range" do
      assert match?(
        %ToyRobot.Simple{x: nil, y: nil, f: nil},
        ToyRobot.Simple.place(%ToyRobot.Simple{}, 10, 10, "N")
      )
    end
  end

  describe "move/1" do
    test "that the robot moves north when facing north" do
      assert match?(
        %ToyRobot.Simple{y: 1},
        ToyRobot.Simple.move(%ToyRobot.Simple{x: 0, y: 0, f: "N"})
      )
    end

    test "that the robot moves south when facing south" do
      assert match?(
        %ToyRobot.Simple{y: 4},
        ToyRobot.Simple.move(%ToyRobot.Simple{x: 0, y: 5, f: "S"})
      )
    end
  end
end

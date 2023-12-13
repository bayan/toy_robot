require "test_helper"

class TestFindPath < Minitest::Test
  include TableDirection::Constants

  def test_ignore_find_path_while_off_table
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    refute robot.on_table?
    simulation = Simulation.new(stage, robot)
    assert_output("") do
      Command::FindPath.execute(simulation, Vector[1, 2])
    end
  end

  def test_path_to_robot_location
    stage = Stage.new(0..5, 0..5)
    position = Vector[3, 3]
    robot = Robot.new(position: position, direction: NORTH_VECTOR)
    simulation = Simulation.new(stage, robot)
    assert_output("[3, 3]\n") do
      Command::FindPath.execute(simulation, position)
    end
  end

  def test_find_path_no_obstacles
    stage = Stage.new(0..5, 0..5)
    position = Vector[3, 3]
    robot = Robot.new(position: position, direction: NORTH_VECTOR)
    simulation = Simulation.new(stage, robot)
    assert_output("[3, 3] -> [3, 4] -> [3, 5]\n") do
      Command::FindPath.execute(simulation, Vector[3, 5])
    end
  end

  def test_find_path_with_obstacles
    stage = Stage.new(0..5, 0..5)
    position = Vector[3, 3]
    robot = Robot.new(position: position, direction: NORTH_VECTOR)
    simulation = Simulation.new(stage, robot)
    simulation.add_obstacle_at(Vector[3, 4])
    assert_output("[3, 3] -> [4, 3] -> [4, 4] -> [4, 5] -> [3, 5]\n") do
      Command::FindPath.execute(simulation, Vector[3, 5])
    end
  end

  def test_cannot_find_path_if_completely_blocked
    stage = Stage.new(0..5, 0..5)
    position = Vector[1, 3]
    robot = Robot.new(position: position, direction: NORTH_VECTOR)
    simulation = Simulation.new(stage, robot)
    simulation.add_obstacle_at(Vector[0, 2])
    simulation.add_obstacle_at(Vector[1, 2])
    simulation.add_obstacle_at(Vector[2, 2])
    simulation.add_obstacle_at(Vector[2, 3])
    simulation.add_obstacle_at(Vector[2, 4])
    simulation.add_obstacle_at(Vector[2, 5])
    assert_output("") do
      Command::FindPath.execute(simulation, Vector[3, 1])
    end
  end

  def test_ignore_off_table_destination
    stage = Stage.new(0..5, 0..5)
    position = Vector[3, 3]
    robot = Robot.new(position: position, direction: NORTH_VECTOR)
    simulation = Simulation.new(stage, robot)
    assert_output("") do
      Command::FindPath.execute(simulation, Vector[9, 8])
    end
  end
end

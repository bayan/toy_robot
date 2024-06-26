# frozen_string_literal: true

require "test_helper"

class TestSimulation < Minitest::Test
  include TableDirection::Constants

  def test_cannot_place_robot_on_an_obstacle
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    obstacles = [Vector[2, 3]]
    simulation = Simulation.new(stage, robot, obstacles)
    simulation.process_command("PLACE 2,3,NORTH")
    refute robot.on_table?
  end

  def test_cannot_place_obstacle_on_a_robot
    stage = Stage.new(0..5, 0..5)
    position = Vector[2, 3]
    robot = Robot.new(position:, direction: NORTH_VECTOR)
    simulation = Simulation.new(stage, robot)
    simulation.add_obstacle_at(position)
    assert simulation.obstacles.empty?
  end

  def test_can_only_have_one_obstacle_at_a_given_location
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    obstacle = Vector[2, 3]
    simulation = Simulation.new(stage, robot)
    3.times do
      simulation.add_obstacle_at(obstacle)
    end
    assert simulation.obstacles.size == 1
  end

  def test_cannot_move_robot_onto_an_obstacle
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    position = Vector[2, 3]
    simulation = Simulation.new(stage, robot)
    simulation.add_obstacle_at(position)
    simulation.process_command("PLACE 2,2,NORTH")
    assert robot.on_table?
    assert robot.position == Vector[2, 2]
    simulation.process_command("MOVE")
    assert robot.position == Vector[2, 2]
  end

  def test_ignore_invalid_command_strings
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    obstacles = []
    simulation = Simulation.new(stage, robot, obstacles)
    command_strings = [
      "foobar",
      "invalid",
      "boargb fsdgisd fgqweorawsfg",
      "",
      "∫∆ˆ∑ˆ∆˜∂˜å•ø∂µπº•£ª£ƒµµµåº•™¡™£¡™£˜Ô˜ÔıÍ¨ÔÍÓÓ·"
    ]
    command_strings.each do |command_string|
      simulation.process_command(command_string)
      assert_nil robot.position
      assert_nil robot.direction
      refute robot.on_table?
    end
  end

  def test_example_command_sequence_1
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    obstacles = []
    simulation = Simulation.new(stage, robot, obstacles)
    command_strings = [
      "PLACE 0,0,NORTH",
      "MOVE",
      "REPORT"
    ]
    assert_output("Output: 0,1,NORTH\n") do
      command_strings.each do |command_string|
        simulation.process_command(command_string)
      end
    end
  end

  def test_example_command_sequence_2
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    obstacles = []
    simulation = Simulation.new(stage, robot, obstacles)
    command_strings = [
      "PLACE 0,0,NORTH",
      "MOVE",
      "REPORT"
    ]
    assert_output("Output: 0,1,NORTH\n") do
      command_strings.each do |command_string|
        simulation.process_command(command_string)
      end
    end
  end

  def test_example_command_sequence_3
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    obstacles = []
    simulation = Simulation.new(stage, robot, obstacles)
    command_strings = [
      "PLACE 1,2,EAST",
      "MOVE",
      "MOVE",
      "LEFT",
      "MOVE",
      "REPORT"
    ]
    assert_output("Output: 3,3,NORTH\n") do
      command_strings.each do |command_string|
        simulation.process_command(command_string)
      end
    end
  end

  def test_ignore_all_commands_prior_to_initial_placement
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    obstacles = []
    simulation = Simulation.new(stage, robot, obstacles)
    command_strings = %w[MOVE RIGHT REPORT LEFT MOVE REPORT]
    command_strings.each do |command_string|
      simulation.process_command(command_string)
      assert_nil robot.position
      assert_nil robot.direction
      refute robot.on_table?
    end
    simulation.process_command("PLACE 1,2,EAST")
    assert_equal robot.position, Vector[1, 2]
    assert_equal robot.direction, EAST_VECTOR
  end

  def test_multiple_placements
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    obstacles = []
    simulation = Simulation.new(stage, robot, obstacles)

    simulation.process_command("PLACE 1,2,WEST")
    assert_equal robot.position, Vector[1, 2]
    assert_equal robot.direction, WEST_VECTOR

    simulation.process_command("PLACE 4,5,NORTH")
    assert_equal robot.position, Vector[4, 5]
    assert_equal robot.direction, NORTH_VECTOR
  end

  def test_ignore_find_path_while_off_table
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    refute robot.on_table?
    simulation = Simulation.new(stage, robot)
    path = simulation.robot_path_to(Vector[1, 2])
    assert path.empty?
  end

  def test_path_to_robot_location
    stage = Stage.new(0..5, 0..5)
    position = Vector[3, 3]
    robot = Robot.new(position:, direction: NORTH_VECTOR)
    simulation = Simulation.new(stage, robot)
    assert_output("[3, 3]\n") do
      Command::FindPath.execute(simulation, position)
    end
    path = simulation.robot_path_to(Vector[3, 3])
    assert_equal path, [Vector[3, 3]]
  end

  def test_find_path_no_obstacles
    stage = Stage.new(0..5, 0..5)
    position = Vector[3, 3]
    robot = Robot.new(position:, direction: NORTH_VECTOR)
    simulation = Simulation.new(stage, robot)
    path = simulation.robot_path_to(Vector[3, 5])
    assert_equal path, [Vector[3, 3], Vector[3, 4], Vector[3, 5]]
  end

  def test_find_path_with_obstacles
    stage = Stage.new(0..5, 0..5)
    position = Vector[3, 3]
    robot = Robot.new(position:, direction: NORTH_VECTOR)
    simulation = Simulation.new(stage, robot)
    simulation.add_obstacle_at(Vector[3, 4])
    simulation.add_obstacle_at(Vector[2, 4])
    path = simulation.robot_path_to(Vector[3, 5])
    assert_equal path, [Vector[3, 3], Vector[4, 3], Vector[4, 4], Vector[4, 5], Vector[3, 5]]
  end

  def test_cannot_find_path_if_completely_blocked
    stage = Stage.new(0..5, 0..5)
    position = Vector[1, 3]
    robot = Robot.new(position:, direction: NORTH_VECTOR)
    simulation = Simulation.new(stage, robot)
    simulation.add_obstacle_at(Vector[0, 2])
    simulation.add_obstacle_at(Vector[1, 2])
    simulation.add_obstacle_at(Vector[2, 2])
    simulation.add_obstacle_at(Vector[2, 3])
    simulation.add_obstacle_at(Vector[2, 4])
    simulation.add_obstacle_at(Vector[2, 5])
    path = simulation.robot_path_to(Vector[3, 1])
    assert path.empty?
  end

  def test_ignore_off_table_destination
    stage = Stage.new(0..5, 0..5)
    position = Vector[3, 3]
    robot = Robot.new(position:, direction: NORTH_VECTOR)
    simulation = Simulation.new(stage, robot)
    path = simulation.robot_path_to(Vector[9, 8])
    assert path.empty?
  end

  def test_ignore_path_to_obstacle
    stage = Stage.new(0..5, 0..5)
    target_position = Vector[3, 4]
    robot = Robot.new(position: Vector[3, 3], direction: NORTH_VECTOR)
    simulation = Simulation.new(stage, robot)
    simulation.add_obstacle_at(target_position)
    path = simulation.robot_path_to(target_position)
    assert_equal path, []
    assert path.empty?
  end
end

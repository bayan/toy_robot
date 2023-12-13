require "test_helper"

class TestCommandsPlace < Minitest::Test
  include TableDirection::Constants

  def test_places_a_robot_on_the_table
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    refute robot.on_table?
    position = Vector[3, 1]
    direction = EAST_VECTOR
    Command::Place.execute(stage, robot, position, direction)
    assert robot.on_table?
    assert_equal robot.position, position
    assert_equal robot.direction, direction
  end

  def test_ignore_initial_placement_without_direction
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    position = Vector[3, 1]
    Command::Place.execute(stage, robot, position)
    refute robot.on_table?
    assert_nil robot.position
    assert_nil robot.direction
  end

  def test_ignore_initial_placement_without_position
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    position = nil
    direction = WEST_VECTOR
    Command::Place.execute(stage, robot, position, direction)
    refute robot.on_table?
    assert_nil robot.position
    assert_nil robot.direction
  end

  def test_ignore_new_placement_without_direction
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    robot.move_to(Vector[4, 5])
    robot.face_direction(NORTH_VECTOR)
    position = Vector[3, 1]
    Command::Place.execute(stage, robot, position)
    assert robot.on_table?
    assert_equal robot.position, Vector[4, 5]
    assert_equal robot.direction, NORTH_VECTOR
  end

  def test_ignore_new_placement_without_position
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    robot.move_to(Vector[4, 5])
    robot.face_direction(NORTH_VECTOR)
    position = nil
    direction = WEST_VECTOR
    Command::Place.execute(stage, robot, position, direction)
    assert robot.on_table?
    assert_equal robot.position, Vector[4, 5]
    assert_equal robot.direction, NORTH_VECTOR
  end

  def test_matches_valid_command_string
    assert Command::Place.valid_format?("PLACE 123,654,NORTH")
    assert Command::Place.valid_format?("PLACE -123,-654,SOUTH")
    assert Command::Place.valid_format?("PLACE -123,654,SOUTH")
  end

  def test_does_not_match_invalid_command_string
    refute Command::Place.valid_format?("PLACE 0,2,4,8,16,32,64,128,EAST")
    refute Command::Place.valid_format?("PLACE 71,WEST")
    refute Command::Place.valid_format?("place 123,654,NORTH")
    refute Command::Place.valid_format?("PLACE -123;-654;SOUTH")
    refute Command::Place.valid_format?("PLACE 0,a2,4,8,16,32,64,128,EAST")
    refute Command::Place.valid_format?("PLACE 71,,WEST")
    refute Command::Place.valid_format?("PLACE WEST")
    refute Command::Place.valid_format?("PLACE")
    refute Command::Place.valid_format?("MOVE")
    refute Command::Place.valid_format?("REPORT")
    refute Command::Place.valid_format?("LEFT")
    refute Command::Place.valid_format?("RIGHT")
  end

  def test_executes_valid_command_string
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    refute robot.on_table?
    command_string = "PLACE 0,5,NORTH"
    Command::Place.parse_and_execute(stage, robot, command_string)
    assert robot.on_table?
    assert_equal robot.position, Vector[0, 5]
    assert_equal robot.direction, NORTH_VECTOR
  end

  def test_ignores_invalid_command_string
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    refute robot.on_table?
    command_string = "PLACE 0,5,UP"
    Command::Place.parse_and_execute(stage, robot, command_string)
    refute robot.on_table?
    refute_equal robot.position, Vector[0, 5]
    refute_equal robot.direction, NORTH_VECTOR
  end
end

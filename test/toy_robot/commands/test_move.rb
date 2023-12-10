require "test_helper"

class TestCommandsMove < Minitest::Test

  include TableDirection::Constants

  def test_ignore_move_while_off_table
    stage = Table.build(0..5, 0..5)
    robot = Robot.new
    refute robot.on_table?
    Command::Move.execute(stage, robot)
    refute robot.on_table?
    assert_nil robot.position
    assert_nil robot.direction
  end

  def test_move_north
    stage = Table.build(0..5, 0..5)
    robot = Robot.new(position: Vector[3,3], direction: NORTH_VECTOR)
    Command::Move.execute(stage, robot)
    assert_equal robot.position, Vector[3,4]
    assert_equal robot.direction, NORTH_VECTOR
  end

  def test_move_south
    stage = Table.build(0..5, 0..5)
    robot = Robot.new(position: Vector[3,3], direction: SOUTH_VECTOR)
    Command::Move.execute(stage, robot)
    assert_equal robot.position, Vector[3,2]
    assert_equal robot.direction, SOUTH_VECTOR
  end

  def test_move_east
    stage = Table.build(0..5, 0..5)
    robot = Robot.new(position: Vector[3,3], direction: EAST_VECTOR)
    Command::Move.execute(stage, robot)
    assert_equal robot.position, Vector[4,3]
    assert_equal robot.direction, EAST_VECTOR
  end

  def test_move_west
    stage = Table.build(0..5, 0..5)
    robot = Robot.new(position: Vector[3,3], direction: WEST_VECTOR)
    Command::Move.execute(stage, robot)
    assert_equal robot.position, Vector[2,3]
    assert_equal robot.direction, WEST_VECTOR
  end

  def test_prevent_falling_off_north_side_of_table
    stage = Table.build(0..5, 0..5)
    robot = Robot.new(position: Vector[3,5], direction: NORTH_VECTOR)
    Command::Move.execute(stage, robot)
    assert_equal robot.position, Vector[3,5]
    assert_equal robot.direction, NORTH_VECTOR
  end

  def test_prevent_falling_off_south_side_of_table
    stage = Table.build(0..5, 0..5)
    robot = Robot.new(position: Vector[2,0], direction: SOUTH_VECTOR)
    Command::Move.execute(stage, robot)
    assert_equal robot.position, Vector[2,0]
    assert_equal robot.direction, SOUTH_VECTOR
  end

  def test_prevent_falling_off_east_side_of_table
    stage = Table.build(0..5, 0..5)
    robot = Robot.new(position: Vector[5,1], direction: EAST_VECTOR)
    Command::Move.execute(stage, robot)
    assert_equal robot.position, Vector[5,1]
    assert_equal robot.direction, EAST_VECTOR
  end

  def test_prevent_falling_off_west_side_of_table
    stage = Table.build(0..5, 0..5)
    robot = Robot.new(position: Vector[0,0], direction: WEST_VECTOR)
    Command::Move.execute(stage, robot)
    assert_equal robot.position, Vector[0,0]
    assert_equal robot.direction, WEST_VECTOR
  end

  def test_matches_valid_command_string
    assert Command::Move.valid_format?('MOVE')
  end
  
  def test_does_not_match_invalid_command_string
    refute Command::Move.valid_format?('MOVE NORTH')
    refute Command::Move.valid_format?('MOVE MOVE')
    refute Command::Move.valid_format?('move')
    refute Command::Move.valid_format?('MOVIE')
    refute Command::Move.valid_format?('PLACE 123,654,NORTH')
    refute Command::Move.valid_format?('REPORT')
    refute Command::Move.valid_format?('LEFT')
    refute Command::Move.valid_format?('RIGHT')
  end

  def test_executes_valid_command_string
    stage = Table.build(0..5, 0..5)
    robot = Robot.new(position: Vector[3,3], direction: NORTH_VECTOR)
    Command::Move.parse_and_execute(stage, robot, 'MOVE')
    assert_equal robot.position, Vector[3,4]
    assert_equal robot.direction, NORTH_VECTOR
  end

  def test_ignores_invalid_command_string
    stage = Table.build(0..5, 0..5)
    robot = Robot.new(position: Vector[3,3], direction: NORTH_VECTOR)
    Command::Move.parse_and_execute(stage, robot, 'MOVE IT')
    assert_equal robot.position, Vector[3,3]
    assert_equal robot.direction, NORTH_VECTOR
  end

end

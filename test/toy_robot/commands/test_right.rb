require "test_helper"

class TestCommandsRight < Minitest::Test

  include TableDirection::Constants

  def test_ignore_right_while_off_table
    stage = Table.build(0..5, 0..5)
    robot = Robot.new
    refute robot.on_table?
    Command::Right.execute(stage, robot)
    refute robot.on_table?
    assert_nil robot.position
    assert_nil robot.direction
  end

  def test_turn_right_from_north
    stage = Table.build(0..5, 0..5)
    robot = Robot.new(position: Vector[4,2], direction: NORTH_VECTOR)
    Command::Right.execute(stage, robot)
    assert_equal robot.position, Vector[4,2]
    assert_equal robot.direction, EAST_VECTOR
  end

  def test_turn_from_south
    stage = Table.build(0..5, 0..5)
    robot = Robot.new(position: Vector[4,2], direction: SOUTH_VECTOR)
    Command::Right.execute(stage, robot)
    assert_equal robot.position, Vector[4,2]
    assert_equal robot.direction, WEST_VECTOR
  end

  def test_turn_from_east
    stage = Table.build(0..5, 0..5)
    robot = Robot.new(position: Vector[4,2], direction: EAST_VECTOR)
    Command::Right.execute(stage, robot)
    assert_equal robot.position, Vector[4,2]
    assert_equal robot.direction, SOUTH_VECTOR
  end

  def test_turn_from_west
    stage = Table.build(0..5, 0..5)
    robot = Robot.new(position: Vector[4,2], direction: WEST_VECTOR)
    Command::Right.execute(stage, robot)
    assert_equal robot.position, Vector[4,2]
    assert_equal robot.direction, NORTH_VECTOR
  end

  def test_right_turns_from_corners
    stage = Table.build(0..5, 0..5)
    corners = [Vector[0,0], Vector[0,5], Vector[5,0], Vector[5,5]]
    corners.each do |corner|
      robot = Robot.new(position: corner, direction: NORTH_VECTOR)

      Command::Right.execute(stage, robot)
      assert_equal robot.position, corner
      assert_equal robot.direction, EAST_VECTOR

      Command::Right.execute(stage, robot)
      assert_equal robot.position, corner
      assert_equal robot.direction, SOUTH_VECTOR

      Command::Right.execute(stage, robot)
      assert_equal robot.position, corner
      assert_equal robot.direction, WEST_VECTOR

      Command::Right.execute(stage, robot)
      assert_equal robot.position, corner
      assert_equal robot.direction, NORTH_VECTOR
    end
  end

  def test_ignore_move_if_off_table
    stage = Table.build(0..5, 0..5)
    robot = Robot.new
    Command::Right.execute(stage, robot)
    refute robot.on_table?
    assert_nil robot.position
    assert_nil robot.direction
  end

  def test_matches_valid_command_string
    assert Command::Right.valid_format?('RIGHT')
  end
  
  def test_does_not_match_invalid_command_string
    refute Command::Right.valid_format?('RIGHT TURN')
    refute Command::Right.valid_format?('right')
    refute Command::Right.valid_format?('Go RIGHT')
    refute Command::Right.valid_format?('L')
    refute Command::Right.valid_format?('PLACE 123,654,NORTH')
    refute Command::Right.valid_format?('REPORT')
    refute Command::Right.valid_format?('LEFT')
  end

  def test_executes_valid_command_string
    stage = Table.build(0..5, 0..5)
    robot = Robot.new(position: Vector[3,3], direction: NORTH_VECTOR)
    Command::Right.parse_and_execute(stage, robot, 'RIGHT')
    assert_equal robot.position, Vector[3,3]
    assert_equal robot.direction, EAST_VECTOR
  end

  def test_ignores_invalid_command_string
    stage = Table.build(0..5, 0..5)
    robot = Robot.new(position: Vector[3,3], direction: NORTH_VECTOR)
    Command::Right.parse_and_execute(stage, robot, 'Righto!')
    assert_equal robot.position, Vector[3,3]
    assert_equal robot.direction, NORTH_VECTOR
  end

end

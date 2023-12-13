require "test_helper"

class TestCommandsLeft < Minitest::Test
  include TableDirection::Constants

  def test_ignore_left_while_off_table
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    refute robot.on_table?
    obstacles = []
    Command::Left.execute(stage, robot, obstacles)
    refute robot.on_table?
    assert_nil robot.position
    assert_nil robot.direction
  end

  def test_turn_left_from_north
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new(position: Vector[4, 2], direction: NORTH_VECTOR)
    obstacles = []
    Command::Left.execute(stage, robot, obstacles)
    assert_equal robot.position, Vector[4, 2]
    assert_equal robot.direction, WEST_VECTOR
  end

  def test_turn_from_south
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new(position: Vector[4, 2], direction: SOUTH_VECTOR)
    obstacles = []
    Command::Left.execute(stage, robot, obstacles)
    assert_equal robot.position, Vector[4, 2]
    assert_equal robot.direction, EAST_VECTOR
  end

  def test_turn_from_east
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new(position: Vector[4, 2], direction: EAST_VECTOR)
    obstacles = []
    Command::Left.execute(stage, robot, obstacles)
    assert_equal robot.position, Vector[4, 2]
    assert_equal robot.direction, NORTH_VECTOR
  end

  def test_turn_from_west
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new(position: Vector[4, 2], direction: WEST_VECTOR)
    obstacles = []
    Command::Left.execute(stage, robot, obstacles)
    assert_equal robot.position, Vector[4, 2]
    assert_equal robot.direction, SOUTH_VECTOR
  end

  def test_left_turns_from_corners
    stage = Stage.new(0..5, 0..5)
    corners = [Vector[0, 0], Vector[0, 5], Vector[5, 0], Vector[5, 5]]
    corners.each do |corner|
      robot = Robot.new(position: corner, direction: NORTH_VECTOR)

      obstacles = []
      Command::Left.execute(stage, robot, obstacles)
      assert_equal robot.position, corner
      assert_equal robot.direction, WEST_VECTOR

      obstacles = []
      Command::Left.execute(stage, robot, obstacles)
      assert_equal robot.position, corner
      assert_equal robot.direction, SOUTH_VECTOR

      obstacles = []
      Command::Left.execute(stage, robot, obstacles)
      assert_equal robot.position, corner
      assert_equal robot.direction, EAST_VECTOR

      obstacles = []
      Command::Left.execute(stage, robot, obstacles)
      assert_equal robot.position, corner
      assert_equal robot.direction, NORTH_VECTOR
    end
  end

  def test_ignore_move_if_off_table
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    obstacles = []
    Command::Left.execute(stage, robot, obstacles)
    refute robot.on_table?
    assert_nil robot.position
    assert_nil robot.direction
  end

  def test_matches_valid_command_string
    assert Command::Left.valid_format?("LEFT")
  end

  def test_does_not_match_invalid_command_string
    refute Command::Left.valid_format?("LEFT TURN")
    refute Command::Left.valid_format?("left")
    refute Command::Left.valid_format?("Go LEFT")
    refute Command::Left.valid_format?("L")
    refute Command::Left.valid_format?("PLACE 123,654,NORTH")
    refute Command::Left.valid_format?("REPORT")
    refute Command::Left.valid_format?("RIGHT")
  end

  def test_executes_valid_command_string
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new(position: Vector[3, 3], direction: NORTH_VECTOR)
    obstacles = []
    Command::Left.parse_and_execute(stage, robot, obstacles, "LEFT")
    assert_equal robot.position, Vector[3, 3]
    assert_equal robot.direction, WEST_VECTOR
  end

  def test_ignores_invalid_command_string
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new(position: Vector[3, 3], direction: NORTH_VECTOR)
    obstacles = []
    Command::Left.parse_and_execute(stage, robot, obstacles, "leeeefffftttt!")
    assert_equal robot.position, Vector[3, 3]
    assert_equal robot.direction, NORTH_VECTOR
  end
end

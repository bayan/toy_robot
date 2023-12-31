require "test_helper"

class TestCommandsReport < Minitest::Test
  include TableDirection::Constants

  def test_ignore_report_while_off_table
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new
    refute robot.on_table?
    obstacles = []
    simulation = Simulation.new(stage, robot, obstacles)
    assert_output("") do
      Command::Report.execute(simulation)
    end
  end

  def test_report_direction_and_position
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new(position: Vector[4, 1], direction: NORTH_VECTOR)
    obstacles = []
    simulation = Simulation.new(stage, robot, obstacles)
    assert_output("Output: 4,1,NORTH\n") do
      Command::Report.execute(simulation)
    end
  end

  def test_matches_valid_command_string
    assert Command::Report.valid_format?("REPORT")
  end

  def test_does_not_match_invalid_command_string
    refute Command::Report.valid_format?("report")
    refute Command::Report.valid_format?("R")
    refute Command::Report.valid_format?("REpoRT")
    refute Command::Report.valid_format?("PLACE 123,654,NORTH")
    refute Command::Report.valid_format?("MOVE")
    refute Command::Report.valid_format?("LEFT")
    refute Command::Report.valid_format?("RIGHT")
  end

  def test_executes_valid_command_string
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new(position: Vector[3, 3], direction: NORTH_VECTOR)
    obstacles = []
    simulation = Simulation.new(stage, robot, obstacles)
    assert_output("Output: 3,3,NORTH\n") do
      Command::Report.parse_and_execute(simulation, "REPORT")
    end
  end

  def test_ignores_invalid_command_string
    stage = Stage.new(0..5, 0..5)
    robot = Robot.new(position: Vector[3, 3], direction: NORTH_VECTOR)
    obstacles = []
    simulation = Simulation.new(stage, robot, obstacles)
    assert_output("") do
      Command::Report.parse_and_execute(simulation, "RIPOURT")
    end
  end
end

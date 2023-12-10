require "test_helper"

class TestStringProcessor < Minitest::Test
  include TableDirection::Constants

  def test_ignore_invalid_command_strings
    stage = Table.build(0..5, 0..5)
    robot = Robot.new
    command_strings = [
      "foobar",
      "invalid",
      "boargb fsdgisd fgqweorawsfg",
      "",
      "∫∆ˆ∑ˆ∆˜∂˜å•ø∂µπº•£ª£ƒµµµåº•™¡™£¡™£˜Ô˜ÔıÍ¨ÔÍÓÓ·"
    ]
    command_strings.each do |command_string|
      Command::StringProcessor.process_command(stage, robot, command_string)
      assert_nil robot.position
      assert_nil robot.direction
      refute robot.on_table?
    end
  end

  def test_example_command_sequence_1
    stage = Table.build(0..5, 0..5)
    robot = Robot.new
    command_strings = [
      "PLACE 0,0,NORTH",
      "MOVE",
      "REPORT"
    ]
    assert_output("0,1,NORTH\n") do
      command_strings.each do |command_string|
        Command::StringProcessor.process_command(stage, robot, command_string)
      end
    end
  end

  def test_example_command_sequence_2
    stage = Table.build(0..5, 0..5)
    robot = Robot.new
    command_strings = [
      "PLACE 0,0,NORTH",
      "MOVE",
      "REPORT"
    ]
    assert_output("0,1,NORTH\n") do
      command_strings.each do |command_string|
        Command::StringProcessor.process_command(stage, robot, command_string)
      end
    end
  end

  def test_example_command_sequence_3
    stage = Table.build(0..5, 0..5)
    robot = Robot.new
    command_strings = [
      "PLACE 1,2,EAST",
      "MOVE",
      "MOVE",
      "LEFT",
      "MOVE",
      "REPORT"
    ]
    assert_output("3,3,NORTH\n") do
      command_strings.each do |command_string|
        Command::StringProcessor.process_command(stage, robot, command_string)
      end
    end
  end

  def test_ignore_all_commands_prior_to_initial_placement
    stage = Table.build(0..5, 0..5)
    robot = Robot.new
    command_strings = %w[MOVE RIGHT REPORT LEFT MOVE REPORT]
    command_strings.each do |command_string|
      Command::StringProcessor.process_command(stage, robot, command_string)
      assert_nil robot.position
      assert_nil robot.direction
      refute robot.on_table?
    end
    Command::StringProcessor.process_command(stage, robot, "PLACE 1,2,EAST")
    assert_equal robot.position, Vector[1, 2]
    assert_equal robot.direction, EAST_VECTOR
  end

  def test_multiple_placements
    stage = Table.build(0..5, 0..5)
    robot = Robot.new

    Command::StringProcessor.process_command(stage, robot, "PLACE 1,2,WEST")
    assert_equal robot.position, Vector[1, 2]
    assert_equal robot.direction, WEST_VECTOR

    Command::StringProcessor.process_command(stage, robot, "PLACE 4,5,NORTH")
    assert_equal robot.position, Vector[4, 5]
    assert_equal robot.direction, NORTH_VECTOR
  end
end

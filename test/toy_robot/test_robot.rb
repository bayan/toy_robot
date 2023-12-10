# frozen_string_literal: true

require "test_helper"

class TestRobot < Minitest::Test

  def test_robot_starts_off_the_table
    robot = Robot.new
    refute robot.on_table?
  end

  def test_initial_move_to_sets_the_position
    robot = Robot.new
    position = Vector[123,456]
    robot.move_to(position)
    assert_equal robot.position, position
  end
  
  def test_initial_face_direction_sets_the_direction
    robot = Robot.new
    direction = Vector[345,678]
    robot.face_direction(direction)
    assert_equal robot.direction, direction
  end
  
  def test_move_changes_the_position
    robot = Robot.new
    position = Vector[123,456]
    robot.move_to(position)
    new_position = Vector[9,2]
    robot.move_to(new_position)
    assert_equal robot.position, new_position
  end

  def test_face_direction_changes_the_direction
    robot = Robot.new
    direction = Vector[345,678]
    robot.face_direction(direction)
    new_direction = Vector[-1,3]
    robot.face_direction(new_direction)
    assert_equal robot.direction, new_direction
  end

  def test_robot_with_position_but_no_direction_is_off_the_table
    robot = Robot.new
    position = Vector[123,456]
    robot.move_to(position)
    refute_nil robot.position
    assert_nil robot.direction
    refute robot.on_table?    
  end

  def test_robot_with_direction_but_no_position_is_off_the_table
    robot = Robot.new
    direction = Vector[345,678]
    robot.face_direction(direction)
    assert_nil robot.position
    refute_nil robot.direction
    refute robot.on_table?    
  end

  def test_robot_with_both_position_and_direction_is_on_the_table
    robot = Robot.new
    position = Vector[123,456]
    robot.move_to(position)
    direction = Vector[345,678]
    robot.face_direction(direction)
    refute_nil robot.position
    refute_nil robot.direction
    assert robot.on_table?    
  end

  def test_robot_can_be_taken_off_the_table
    robot = Robot.new
    position = Vector[123,456]
    robot.move_to(position)
    direction = Vector[345,678]
    robot.face_direction(direction)
    assert robot.on_table?    
    robot.move_to(nil)
    robot.face_direction(nil)
    refute robot.on_table?    
  end

end

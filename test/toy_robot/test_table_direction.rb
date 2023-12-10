# frozen_string_literal: true

require "test_helper"

class TestTableDirection < Minitest::Test

  include TableDirection::Constants

  def test_rotate_north_clockwise_gives_east
    assert_equal TableDirection.rotate_clockwise_90_degrees(NORTH_VECTOR), EAST_VECTOR
  end

  def test_rotate_east_clockwise_gives_south
    assert_equal TableDirection.rotate_clockwise_90_degrees(EAST_VECTOR), SOUTH_VECTOR
  end

  def test_rotate_south_clockwise_gives_west
    assert_equal TableDirection.rotate_clockwise_90_degrees(SOUTH_VECTOR), WEST_VECTOR
  end

  def test_rotate_west_clockwise_gives_north
    assert_equal TableDirection.rotate_clockwise_90_degrees(WEST_VECTOR), NORTH_VECTOR
  end

  def test_rotate_north_anticlockwise_gives_west
    assert_equal TableDirection.rotate_anticlockwise_90_degrees(NORTH_VECTOR), WEST_VECTOR
  end

  def test_rotate_east_anticlockwise_gives_north
    assert_equal TableDirection.rotate_anticlockwise_90_degrees(EAST_VECTOR), NORTH_VECTOR
  end

  def test_rotate_south_anticlockwise_gives_east
    assert_equal TableDirection.rotate_anticlockwise_90_degrees(SOUTH_VECTOR), EAST_VECTOR
  end

  def test_rotate_west_anticlockwise_gives_south
    assert_equal TableDirection.rotate_anticlockwise_90_degrees(WEST_VECTOR), SOUTH_VECTOR
  end

  def test_north_points_up
    assert_equal DIRECTIONS_BY_VECTOR[Vector[0,1]], NORTH
  end

  def test_south_points_down
    assert_equal DIRECTIONS_BY_VECTOR[Vector[0,-1]], SOUTH
  end

  def test_east_points_right
    assert_equal DIRECTIONS_BY_VECTOR[Vector[1,0]], EAST
  end

  def test_west_points_left
    assert_equal DIRECTIONS_BY_VECTOR[Vector[-1,0]], WEST
  end

  def test_rotate_unlabelled_directions_clockwise
    direction = Vector[99,-17]
    new_direction = TableDirection.rotate_clockwise_90_degrees(direction)
    assert_equal new_direction, Vector[-17, -99]
  end

  def test_rotate_unlabelled_directions_anticlockwise
    direction = Vector[99,-17]
    new_direction = TableDirection.rotate_anticlockwise_90_degrees(direction)
    assert_equal new_direction, Vector[17, 99]
  end

end

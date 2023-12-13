# frozen_string_literal: true

require "test_helper"

class TestObstacle < Minitest::Test
  def test_obstacle_needs_a_position
    assert_raises(ArgumentError) { Obstacle.new }
    assert_raises(ArgumentError) { Obstacle.new(position: nil) }
    assert_raises(ArgumentError) { Obstacle.new(position: "NOT A VECTOR") }

    position = Vector[1,1]
    obstacle = Obstacle.new(position: position)
    assert_equal obstacle.position, position
  end

end

# frozen_string_literal: true

require "matrix"

module ToyRobot
  module TableDirection
    module Constants
      NORTH = "NORTH"
      EAST = "EAST"
      SOUTH = "SOUTH"
      WEST = "WEST"

      NORTH_VECTOR = Vector[0, 1].freeze
      EAST_VECTOR = Vector[1, 0].freeze
      SOUTH_VECTOR = Vector[0, -1].freeze
      WEST_VECTOR = Vector[-1, 0].freeze

      DIRECTIONS_BY_LABEL = {
        NORTH => NORTH_VECTOR,
        EAST => EAST_VECTOR,
        SOUTH => SOUTH_VECTOR,
        WEST => WEST_VECTOR
      }.freeze

      DIRECTIONS_BY_VECTOR = DIRECTIONS_BY_LABEL.invert.freeze
    end

    def self.rotate_clockwise_90_degrees(direction)
      Vector[direction[1], -direction[0]]
    end

    def self.rotate_anticlockwise_90_degrees(direction)
      Vector[-direction[1], direction[0]]
    end
  end
end

# frozen_string_literal: true

require 'matrix'
require_relative 'table_direction'

module ToyRobot
  class Robot
    include TableDirection::Constants

    attr_reader :position, :direction

    def initialize(position: nil, direction: nil)
      @position = position
      @direction = direction
    end

    def move_to(position)
      @position = position
    end

    def face_direction(direction)
      @direction = direction
    end

    def on_table?
      !!(position && direction)
    end

    def direction_label
      DIRECTIONS_BY_VECTOR[direction]
    end
  end
end

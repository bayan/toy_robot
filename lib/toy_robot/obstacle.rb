# frozen_string_literal: true

require "matrix"
require_relative "table_direction"

module ToyRobot
  class Obstacle

    attr_reader :position

    def initialize(position:)
      raise ArgumentError, "Invalid position type. Must use a Vector." unless position.instance_of? Vector
      @position = position
    end

  end
end

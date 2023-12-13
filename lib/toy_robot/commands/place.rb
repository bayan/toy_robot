# frozen_string_literal: true

require_relative "base"

module ToyRobot
  module Command
    class Place < Base
      FORMAT = /^PLACE\s+(-?\d+),(-?\d+),(NORTH|SOUTH|EAST|WEST)$/

      def self.execute(stage, robot, obstacles, *arguments)
        position, direction = arguments
        if stage.valid_position?(position) && stage.valid_direction?(direction)
          robot.move_to(position)
          robot.face_direction(direction)
        end
      end

      class << self
        private

        def parse_arguments(command_string)
          args = FORMAT.match(command_string).captures
          x = args[0].to_i
          y = args[1].to_i
          position = Vector[x, y]
          direction_label = args[2]
          direction = DIRECTIONS_BY_LABEL[direction_label]
          [position, direction]
        end
      end
    end
  end
end

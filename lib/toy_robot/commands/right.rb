# frozen_string_literal: true

require_relative "base"

module ToyRobot
  module Command
    class Right < Base
      FORMAT = /^RIGHT$/

      def self.execute(simulation, *arguments)
        robot = simulation.robot
        return unless robot.on_table?

        direction = TableDirection.rotate_clockwise_90_degrees(robot.direction)
        robot.face_direction(direction)
      end
    end
  end
end

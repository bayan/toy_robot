# frozen_string_literal: true

require_relative "base"

module ToyRobot
  module Command
    class Left < Base
      FORMAT = /^LEFT$/

      def self.execute(stage, robot, *arguments)
        if robot.on_table?
          direction = TableDirection.rotate_anticlockwise_90_degrees(robot.direction)
          robot.face_direction(direction)
        end
      end
    end
  end
end

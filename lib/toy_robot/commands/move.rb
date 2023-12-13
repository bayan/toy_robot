# frozen_string_literal: true

require_relative "base"

module ToyRobot
  module Command
    class Move < Base
      FORMAT = /^MOVE$/

      def self.execute(stage, robot, obstacles, *arguments)
        if robot.on_table?
          position = robot.position + robot.direction
          if stage.valid_position?(position)
            robot.move_to(position)
          end
        end
      end
    end
  end
end

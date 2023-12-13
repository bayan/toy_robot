# frozen_string_literal: true

require_relative "base"

module ToyRobot
  module Command
    class Move < Base
      FORMAT = /^MOVE$/

      def self.execute(simulation, *arguments)
        stage = simulation.stage
        robot = simulation.robot
        if robot.on_table?
          position = robot.position + robot.direction
          if stage.valid_position?(position) && simulation.position_vacant?(position)
            robot.move_to(position)
          end
        end
      end
    end
  end
end

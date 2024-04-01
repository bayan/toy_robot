# frozen_string_literal: true

require_relative 'base'

module ToyRobot
  module Command
    class Move < Base
      FORMAT = /^MOVE$/

      def self.execute(simulation, *arguments)
        robot = simulation.robot
        return unless robot.on_table?

        position = robot.position + robot.direction
        return unless simulation.position_valid_and_vacant?(position)

        robot.move_to(position)
      end
    end
  end
end

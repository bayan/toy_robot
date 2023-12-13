# frozen_string_literal: true

require_relative "base"

module ToyRobot
  module Command
    class Report < Base
      FORMAT = /^REPORT$/

      def self.execute(stage, robot, obstacles, *arguments)
        if robot.on_table?
          puts "Output: #{robot.position.to_a.join(",")},#{robot.direction_label}"
        end
      end
    end
  end
end

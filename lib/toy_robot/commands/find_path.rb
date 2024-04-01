# frozen_string_literal: true

require_relative "base"

module ToyRobot
  module Command
    class FindPath < Base
      FORMAT = /^PATH\s+(-?\d+),(-?\d+)$/

      def self.execute(simulation, *arguments)
        position = arguments.last
        stage = simulation.stage
        return unless stage.valid_position?(position)

        path = simulation.robot_path_to(position)
        return if path.empty?

        puts path.map(&:to_a).map(&:to_s).join(" -> ")
      end

      class << self
        private

        def parse_arguments(command_string)
          args = FORMAT.match(command_string).captures
          x = args[0].to_i
          y = args[1].to_i
          position = Vector[x, y]
          [position]
        end
      end
    end
  end
end

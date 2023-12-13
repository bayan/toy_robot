# frozen_string_literal: true

require "matrix"
require_relative "../table_direction"

module ToyRobot
  module Command
    class Base
      include TableDirection::Constants

      FORMAT = nil # Override in subclasses

      def self.valid_format?(command_string)
        !!self::FORMAT.match?(command_string)
      end

      def self.execute(stage, robot, obstacles, *arguments)
        raise NotImplementedError, "Abstract method Base.execute called."
      end

      def self.parse_and_execute(stage, robot, obstacles, command_string)
        return unless valid_format?(command_string)
        arguments = parse_arguments(command_string)
        execute(stage, robot, obstacles, *arguments)
      end

      class << self
        include TableDirection::Constants

        private

        def parse_arguments(command_string)
          []
        end
      end
    end
  end
end

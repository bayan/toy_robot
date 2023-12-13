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

      def self.execute(simulation, *arguments)
        raise NotImplementedError, "Abstract method Base.execute called."
      end

      def self.parse_and_execute(simulation, command_string)
        return unless valid_format?(command_string)
        arguments = parse_arguments(command_string)
        execute(simulation, *arguments)
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

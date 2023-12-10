# frozen_string_literal: true

require 'matrix'
require_relative '../table_direction'

module ToyRobot
  module Command
    class Base

      include TableDirection::Constants

      FORMAT = nil # Override in subclasses

      def self.valid_format?(command_string)
        !!self::FORMAT.match?(command_string)
      end
    
      def self.execute(stage, robot, *arguments)
        raise NotImplementedError, "Abstract method Base.execute called."
      end
      
      def self.parse_and_execute(stage, robot, command_string)
        return unless valid_format?(command_string)
        arguments = parse_arguments(command_string)
        execute(stage, robot, *arguments)
      end
      
      private
      
      def self.parse_arguments(command_string)
        []
      end
    
    end
  end
end

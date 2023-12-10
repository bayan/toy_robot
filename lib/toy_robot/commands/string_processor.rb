# frozen_string_literal: true

require_relative "place"
require_relative "move"
require_relative "left"
require_relative "right"
require_relative "report"

module ToyRobot
  module Command
    module StringProcessor
      COMMANDS = [
        Place,
        Report,
        Move,
        Left,
        Right
      ]

      def self.process_command(stage, robot, command_string)
        COMMANDS
          .find { |command| command.valid_format?(command_string) }
          &.parse_and_execute(stage, robot, command_string)
      end
    end
  end
end

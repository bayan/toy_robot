# frozen_string_literal: true

require "matrix"
require "set"
require_relative "commands/place"
require_relative "commands/move"
require_relative "commands/left"
require_relative "commands/right"
require_relative "commands/report"

module ToyRobot
  class Simulation
    COMMANDS = [
      Command::Place,
      Command::Report,
      Command::Move,
      Command::Left,
      Command::Right
    ]

    attr_reader :stage, :robot, :obstacles

    def initialize(stage, robot, obstacles = [])
      @stage = stage
      @robot = robot
      @obstacles = Set.new(obstacles)
    end

    def add_obstacle_at(position)
      if stage.valid_position?(position) && robot.position != position
        obstacles.add(position)
      end
    end

    def position_vacant?(position)
      !obstacles.include?(position)
    end

    def process_command(command_string)
      COMMANDS
        .find { |command| command.valid_format?(command_string) }
        &.parse_and_execute(self, command_string)
    end
  end
end

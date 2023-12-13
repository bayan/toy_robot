# frozen_string_literal: true

require "matrix"
require "set"
require_relative "commands/place"
require_relative "commands/move"
require_relative "commands/left"
require_relative "commands/right"
require_relative "commands/report"
require_relative "commands/find_path"

module ToyRobot
  class Simulation
    include TableDirection::Constants

    COMMANDS = [
      Command::Place,
      Command::Report,
      Command::Move,
      Command::Left,
      Command::Right,
      Command::FindPath
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

    def robot_path_to(position)
      return [] if !robot.on_table? || !stage.valid_position?(position)
      return [position] if robot.position == position
      paths = [[robot.position]]
      while !paths.empty?
        next_paths = []
        paths.each do |path|
          last_position = path.last
          adjacents = [
            last_position + NORTH_VECTOR,
            last_position + SOUTH_VECTOR,
            last_position + EAST_VECTOR,
            last_position + WEST_VECTOR
          ]
          adjacents.each do |adjacent|
            new_path = path + [adjacent]
            return new_path if adjacent == position
            next if path.include?(adjacent) || !position_vacant?(adjacent) || !stage.valid_position?(adjacent)
            next_paths.append(new_path)
          end
        end
        paths = next_paths
      end
      return []
    end

    def process_command(command_string)
      COMMANDS
        .find { |command| command.valid_format?(command_string) }
        &.parse_and_execute(self, command_string)
    end
  end
end

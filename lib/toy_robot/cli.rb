# frozen_string_literal: true

require "thor"
require "toy_robot"

module ToyRobot
  class CLI < Thor
    include ToyRobot
    include TableDirection::Constants

    map ["--version", "-v"] => :version
    desc "version", "Display the version."
    def version
      puts "Toy Robot Simulator Version #{VERSION}"
    end

    desc "", "Run the Toy Robot Simulation"
    option :size, type: :numeric, default: 5, banner: "Length and width of the simulated square table."
    def run_simulation
      size = options[:size]
      unless size > 0 && size.instance_of?(Integer)
        raise Thor::MalformattedArgumentError, "Size must be a positive integer."
      end
      stage = Stage.new(0..size, 0..size)
      robot = Robot.new

      simulation = Simulation.new(stage, robot)

      obstacle_position_format = /^(\d+),\s*(\d+)\n$/

      File.open('obstacles.txt', 'r') do |file|
        file.each_line do |line|
          if obstacle_position_format.match?(line)
            x,y = obstacle_position_format.match(line).captures
            simulation.add_obstacle_at(Vector[x,y])
          end
        end
      end

      $stdin.each_line do |line|
        simulation.process_command(line.chomp)
      end
    end

    default_task :run_simulation

    def self.exit_on_failure?
      true
    end

    trap("INT") do
      puts "\nCtrl-C detected. Exiting gracefully."
      exit
    end
  end
end

ToyRobot::CLI.start(ARGV)

# frozen_string_literal: true

require_relative "toy_robot/version"
require_relative "toy_robot/robot"
require_relative "toy_robot/table_direction"
require_relative "toy_robot/table"
require_relative "toy_robot/commands/string_processor"

module ToyRobot
  class Error < StandardError; end
end

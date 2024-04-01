# frozen_string_literal: true

require_relative "toy_robot/version"
require_relative "toy_robot/stage"
require_relative "toy_robot/robot"
require_relative "toy_robot/simulation"
require_relative "toy_robot/table_direction"

module ToyRobot
  class Error < StandardError; end
end

# frozen_string_literal: true

require 'matrix'
require_relative 'multi_dimensional_stage'

module ToyRobot
  class Table < MultiDimensionalStage
    
    def self.build(x_range, y_range)
      super(x_range, y_range)
    end
    
    def x_range
      dimension_ranges[0]
    end
    
    def y_range
      dimension_ranges[1]
    end
    
  end
end

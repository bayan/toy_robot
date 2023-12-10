# frozen_string_literal: true

require 'matrix'

module ToyRobot
  class MultiDimensionalStage < Data.define(:dimension_ranges)
    
    def self.build(*dimension_ranges)
      new(dimension_ranges)
    end
    
    def valid_position?(position)
      correct_number_of_dimensions?(position) && position_within_stage?(position)
    end

    def valid_direction?(direction)
      correct_number_of_dimensions?(direction)
    end
    
    def number_of_dimensions
      dimension_ranges.size
    end

    private

    def correct_number_of_dimensions?(vector)
      vector&.size == number_of_dimensions
    end

    def position_within_stage?(position)
      position.map.with_index do |coord, index|
        dimension_ranges[index].include?(coord)
      end.all?
    end

  end
end

# frozen_string_literal: true

require "test_helper"

class TestStage < Minitest::Test
  def test_is_immutable
    x_range = 0..5
    y_range = 5..10
    stage = Stage.new(x_range, y_range)
    assert_raises(NoMethodError) { stage.dimension_ranges = [1..100, 5..50] }
    assert_equal stage.dimension_ranges, [x_range, y_range]
  end

  def test_can_have_1_dimension
    range = -100..100
    stage = Stage.new(range)
    assert_equal stage.number_of_dimensions, 1
  end

  def test_can_have_two_dimensions
    range = -100..100
    stage = Stage.new(range, range)
    assert_equal stage.number_of_dimensions, 2
  end

  def test_can_have_three_dimensions
    range = -100..100
    stage = Stage.new(range, range, range)
    assert_equal stage.number_of_dimensions, 3
  end

  def test_can_have_many_dimensions
    range = -100..100
    stage = Stage.new(
      range, range, range, range, range, range, range, range
    )
    assert_equal stage.number_of_dimensions, 8
  end

  def test_can_have_different_ranges_per_dimension
    range1 = -5..50
    range2 = 1..10
    range3 = -1000..-990
    stage = Stage.new(range1, range2, range3)
    assert_equal stage.dimension_ranges[0], range1
    assert_equal stage.dimension_ranges[1], range2
    assert_equal stage.dimension_ranges[2], range3
  end

  def test_can_have_range_of_negative_numbers
    range = -80..-2
    stage = Stage.new(range)
    assert_equal stage.dimension_ranges[0], range
    assert stage.dimension_ranges[0].all? { |i| i < 0 }
  end

  def test_can_have_range_of_positive_and_negative_numbers
    range = -40..25
    stage = Stage.new(range)
    assert_equal stage.dimension_ranges[0], range
  end

  def test_can_have_range_of_positive_numbers
    range = 1000..2000
    stage = Stage.new(range)
    assert_equal stage.dimension_ranges[0], range
  end

  def test_range_can_start_at_zero
    range = 0..2000
    stage = Stage.new(range)
    assert_equal stage.dimension_ranges[0].first, 0
  end

  def test_range_can_end_at_zero
    range = -123..0
    stage = Stage.new(range)
    assert_equal stage.dimension_ranges[0].last, 0
  end

  def test_valid_position
    range1 = -5..50
    range2 = 1..10
    range3 = -1000..-990
    stage = Stage.new(range1, range2, range3)
    valid_positions = [
      Vector[-5, 1, -1000],
      Vector[50, 10, -990],
      Vector[-4, 2, -999],
      Vector[49, 9, -991],
      Vector[0, 5, -994]
    ]
    valid_positions.each do |position|
      assert stage.valid_position?(position), "Position #{position} not in #{stage.dimension_ranges}"
    end
  end

  def test_invalid_position
    range1 = -5..50
    range2 = 1..10
    range3 = -1000..-990
    stage = Stage.new(range1, range2, range3)
    valid_positions = [
      Vector[-5, 1, -1000, 2],
      Vector[50, 10],
      Vector[-40, 2, -999],
      Vector[49, -99, -991],
      Vector[0, 5, -1001]
    ]
    valid_positions.each do |position|
      refute stage.valid_position?(position), "Position #{position} in #{stage.dimension_ranges}"
    end
  end

  def test_direction_is_valid_if_number_of_dimensions_matches
    stage = Stage.new(0..5, -20..20, 1..1)
    assert stage.valid_direction?(Vector[1, 2, 3])
    assert stage.valid_direction?(Vector[1, 1, 1])
    assert stage.valid_direction?(Vector[-1, -1, -1])
    assert stage.valid_direction?(Vector[999, 999, 999])
    refute stage.valid_direction?(Vector[])
    refute stage.valid_direction?(Vector[1])
    refute stage.valid_direction?(Vector[1, 1])
    refute stage.valid_direction?(Vector[1, 1, 1, 1])
  end

  def test_tiny_ranges
    range1 = 0..0
    range2 = 1..1
    range3 = -1..-1
    stage = Stage.new(range1, range2, range3)

    assert_equal stage.dimension_ranges[0], range1
    assert_equal stage.dimension_ranges[1], range2
    assert_equal stage.dimension_ranges[2], range3

    assert stage.valid_position?(Vector[0, 1, -1])

    refute stage.valid_position?(Vector[1, 2, -2])
  end

  def huge_ranges
    range1 = 0..1_000_000_000_000
    range2 = -5_000_000_000..5_000_000_000
    range3 = -1_000_000_000_000..0
    stage = Stage.new(range1, range2, range3)
    assert_equal stage.dimension_ranges[0], range1
    assert_equal stage.dimension_ranges[1], range2
    assert_equal stage.dimension_ranges[2], range3

    assert stage.valid_position?(Vector[0, 1, -1])
    assert stage.valid_position?(Vector[0, 0, 0])
    assert stage.valid_position?(Vector[0, -5_000_000_000, -1_000_000_000_000])

    refute stage.valid_position?(Vector[1_000_000_000_001, 0, 0])
    refute stage.valid_position?(Vector[0, -5_000_000_005, 0])
    refute stage.valid_position?(Vector[0, 0, 22])
  end
end

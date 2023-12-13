# frozen_string_literal: true

require "test_helper"

class TestTable < Minitest::Test
  def test_expects_2_ranges
    Table.new(1..100, 2..200)
    assert_raises(ArgumentError) { Table.new }
    assert_raises(ArgumentError) { Table.new(0..10000) }
    assert_raises(ArgumentError) { Table.new(11..12, 99..111, -3..-1) }
  end

  def test_has_x_range
    x_range = 1..100
    y_range = 2..200
    table = Table.new(x_range, y_range)
    assert_equal table.x_range, x_range
  end

  def test_has_y_range
    x_range = 1..100
    y_range = 2..200
    table = Table.new(x_range, y_range)
    assert_equal table.y_range, y_range
  end
end

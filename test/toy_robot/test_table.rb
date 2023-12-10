# frozen_string_literal: true

require "test_helper"

class TestTable < Minitest::Test
  def test_expects_2_ranges
    Table.build(1..100, 2..200)
    assert_raises(ArgumentError) { Table.build }
    assert_raises(ArgumentError) { Table.build(0..10000) }
    assert_raises(ArgumentError) { Table.build(11..12, 99..111, -3..-1) }
  end

  def test_has_x_range
    x_range = 1..100
    y_range = 2..200
    table = Table.build(x_range, y_range)
    assert_equal table.x_range, x_range
  end

  def test_has_y_range
    x_range = 1..100
    y_range = 2..200
    table = Table.build(x_range, y_range)
    assert_equal table.y_range, y_range
  end
end

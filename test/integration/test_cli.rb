# frozen_string_literal: true

require 'test_helper'
require 'open3'

class TestCLI < Minitest::Test
  def test_example_1
    input = File.read('test/examples/example1.txt')
    stdout, stderr, status = Open3.capture3('bundle exec exe/robot_sim', stdin_data: input)
    assert_equal 0, status.exitstatus
    assert_equal "Output: 0,1,NORTH\n", stdout
    assert_equal '', stderr
  end

  def test_example_2
    input = File.read('test/examples/example2.txt')
    stdout, stderr, status = Open3.capture3('bundle exec exe/robot_sim', stdin_data: input)
    assert_equal 0, status.exitstatus
    assert_equal "Output: 0,0,WEST\n", stdout
    assert_equal '', stderr
  end

  def test_example_3
    input = File.read('test/examples/example3.txt')
    stdout, stderr, status = Open3.capture3('bundle exec exe/robot_sim', stdin_data: input)
    assert_equal 0, status.exitstatus
    assert_equal "Output: 3,3,NORTH\n", stdout
    assert_equal '', stderr
  end

  def test_big_example
    stdout, stderr, status = Open3.capture3('gunzip -c test/examples/big_example.txt.gz | bundle exec exe/robot_sim --size 1000000')
    assert_equal 0, status.exitstatus
    assert_equal "Output: 3,3,NORTH\n", stdout
    assert_equal '', stderr
  end

  def test_obstacles_file
    input = <<~EOS
      PLACE 1,2,WEST
      REPORT
    EOS
    stdout, stderr, status = Open3.capture3(
      'bundle exec exe/robot_sim --obstacles-filepath test/examples/obstacles.txt', stdin_data: input
    )
    assert_equal 0, status.exitstatus
    assert_equal '', stdout
    assert_equal '', stderr
  end
end

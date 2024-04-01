require 'test_helper'

class TestCommandsBase < Minitest::Test
  def test_execute_is_an_abstract_method
    stage = Stage.new(0..5)
    robot = Robot.new
    obstacles = []
    simulation = Simulation.new(stage, robot, obstacles)
    assert_raises(NotImplementedError) do
      Command::Base.execute(simulation)
    end
  end
end

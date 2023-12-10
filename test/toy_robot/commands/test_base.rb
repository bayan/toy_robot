require "test_helper"

class TestCommandsBase < Minitest::Test
  def test_execute_is_an_abstract_method
    stage = MultiDimensionalStage.build(0..5)
    robot = Robot.new
    assert_raises(NotImplementedError) do
      Command::Base.execute(stage, robot)
    end
  end
end

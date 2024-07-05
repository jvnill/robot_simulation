module UnitRobot::Command
  class MoveCommand < Base
    POSITION_CHANGE = {
      'NORTH' => [0, 1],
      'EAST'  => [1, 0],
      'SOUTH' => [0, -1],
      'WEST'  => [-1, 0]
    }

    def process
      return if initial_position.nil?

      x_change, y_change = POSITION_CHANGE[initial_position[:direction]]

      @final_position = {
        x: initial_position[:x] + x_change,
        y: initial_position[:y] + y_change,
        direction: initial_position[:direction]
      }
    end
  end
end

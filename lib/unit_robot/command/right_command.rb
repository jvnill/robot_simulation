module UnitRobot::Command
  class RightCommand < Base
    DIRECTIONS = %w[NORTH WEST SOUTH EAST]

    def process
      return if initial_position.nil?

      @final_position = {
        x: initial_position[:x],
        y: initial_position[:y],
        direction: DIRECTIONS[DIRECTIONS.index(initial_position[:direction]) - 1]
      }
    end
  end
end

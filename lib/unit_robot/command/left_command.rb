module UnitRobot::Command
  class LeftCommand < Base
    DIRECTIONS = %w[NORTH EAST SOUTH WEST]

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

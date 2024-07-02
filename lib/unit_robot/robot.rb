module UnitRobot
  class Robot
    def set_position(position)
      @position = position
    end

    def get_position
      position
    end

    private

    attr_accessor :position
  end
end

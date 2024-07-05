module UnitRobot
  class BoardPosition
    attr_accessor :x, :y, :direction

    def set(value)
      @x = value[:x]
      @y = value[:y]
      @direction = value[:direction]
    end

    def get
      return unless x && y && direction

      {
        x: x,
        y: y,
        direction: direction
      }
    end
  end
end

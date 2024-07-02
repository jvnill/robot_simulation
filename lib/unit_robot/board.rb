module UnitRobot
  class Board
    attr_reader :max_length, :max_width

    def initialize(length, width)
      @max_length = length
      @max_width = width
    end

    def position_valid?(x, y)
      x >= 0 &&
      y >= 0 &&
      x < max_width &&
      y < max_length
    end
  end
end

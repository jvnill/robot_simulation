module UnitRobot
  class Mover
    DIRECTIONS = %w[NORTH EAST SOUTH WEST]
    X_DIRECTIONS = %w[EAST WEST]

    def initialize(initial_position, board)
      @position = initial_position.dup
      @board = board
    end

    def process_command(command, new_position = nil)
      if position && command != 'PLACE'
        case command
        when 'LEFT'  then turn_left
        when 'RIGHT' then turn_right
        when 'MOVE'  then move_forward
        end

      elsif command == 'PLACE'
        set_position(new_position[:x], new_position[:y], new_position[:direction])
      end

      position
    end

    private

    attr_reader :board, :position

    def move_forward
      case position[:direction]
      when 'NORTH'
        validate_and_set_position(position.slice(:x, :direction).merge(y: position[:y] + 1))

      when 'EAST'
        validate_and_set_position(position.slice(:y, :direction).merge(x: position[:x] + 1))

      when 'SOUTH'
        validate_and_set_position(position.slice(:x, :direction).merge(y: position[:y] - 1))

      when 'WEST'
        validate_and_set_position(position.slice(:y, :direction).merge(x: position[:x] - 1))
      end
    end

    def set_position(x, y, direction)
      validate_and_set_position(x: x, y: y, direction: direction)
    end

    def turn_left
      position[:direction] = DIRECTIONS[DIRECTIONS.index(position[:direction]) - 1]
    end

    def turn_right
      position[:direction] = DIRECTIONS[(DIRECTIONS.index(position[:direction]) + 1) % 4]
    end

    def validate_and_set_position(position)
      return if position[:x].nil? || position[:y].nil?

      position[:x] = position[:x].to_i
      position[:y] = position[:y].to_i

      if board.position_valid?(position[:x], position[:y])
        @position = position
      end
    end
  end
end

class RobotBoardMovement
  DIRECTIONS = %w[NORTH EAST SOUTH WEST]
  X_DIRECTIONS = %w[EAST WEST]

  attr_reader :position

  def initialize(board)
    @board = board
  end

  def move_forward
    return unless position

    case position[:face]
    when 'NORTH'
      validate_and_set_position(position.slice(:x, :face).merge(y: position[:y] + 1))

    when 'EAST'
      validate_and_set_position(position.slice(:y, :face).merge(x: position[:x] + 1))

    when 'SOUTH'
      validate_and_set_position(position.slice(:x, :face).merge(y: position[:y] - 1))

    when 'WEST'
      validate_and_set_position(position.slice(:y, :face).merge(x: position[:x] - 1))
    end
  end

  def get_position
    return unless position

    "#{position[:x]},#{position[:y]},#{position[:face]}"
  end

  def set_position(x, y, face)
    validate_and_set_position(x: x, y: y, face: face)
  end

  def turn_left
    return unless position

    position[:face] = DIRECTIONS[DIRECTIONS.index(position[:face]) - 1]
  end

  def turn_right
    return unless position

    position[:face] = DIRECTIONS[(DIRECTIONS.index(position[:face]) + 1) % 4]
  end

  private

  attr_reader :robot, :board

  def validate_and_set_position(position)
    return if position[:x].nil? || position[:y].nil?

    position[:x] = position[:x].to_i
    position[:y] = position[:y].to_i

    if board.position_valid?(position[:x], position[:y])
      @position = position
    end
  end
end

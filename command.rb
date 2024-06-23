class Command
  VALID_COMMANDS = %w[MOVE LEFT RIGHT REPORT]
  VALID_PLACE_COMMAND_REGEX = /PLACE\s+(\d+)\s*,\s*(\d+)\s*,\s*(NORTH|EAST|SOUTH|WEST)/

  def initialize(command, robot_board_movement, report_proc)
    @command = command.strip
    @robot_board_movement = robot_board_movement
    @report_proc = report_proc
  end

  def process
    if VALID_COMMANDS.include?(command)
      return send(command.downcase)
    end

    if VALID_PLACE_COMMAND_REGEX =~ command
      return place($1, $2, $3)
    end

    report_proc.call('Invalid Command')
  end

  private

  attr_reader :command, :robot_board_movement, :report_proc

  def left
    robot_board_movement.turn_left
  end

  def move
    robot_board_movement.move_forward
  end

  def place(x, y, direction)
    robot_board_movement.set_position(x, y, direction)
  end

  def report
    report_proc.call(robot_board_movement.get_position)
  end

  def right
    robot_board_movement.turn_right
  end
end

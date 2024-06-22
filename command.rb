class Command
  VALID_COMMANDS = %w[MOVE LEFT RIGHT REPORT]
  VALID_PLACE_COMMAND_REGEX = /PLACE\s+(\d+)\s*,\s*(\d+)\s*,\s*(NORTH|EAST|SOUTH|WEST)/

  def initialize(command, simulation)
    @command = command.chomp.strip
    @simulation = simulation
  end

  def process
    if VALID_COMMANDS.include?(command)
      return send(command.downcase)
    end

    if VALID_PLACE_COMMAND_REGEX =~ command
      return place($1, $2, $3)
    end
  end

  private

  attr_reader :command, :simulation

  def left
    simulation.turn_left
  end

  def move
    simulation.move_forward
  end

  def place(x, y, face)
    simulation.set_position(x, y, face)
  end

  def report
    simulation.report_position
  end

  def right
    simulation.turn_right
  end
end

require './board'
require './command'
require './robot_board_movement'

class Simulation
  BOARD_WIDTH = 5
  BOARD_LENGTH = 5

  def initialize(input: STDIN, output: STDOUT)
    @input = input
    @output = output
  end

  def start
    board = Board.new(BOARD_LENGTH, BOARD_WIDTH)
    robot_board_movement = RobotBoardMovement.new(board)

    loop do
      command = input.gets.chomp

      break if command == 'EXIT'

      Command.new(command, robot_board_movement, proc { |position| output.puts(position) }).process
    end
  end

  private

  attr_reader :input, :output
end

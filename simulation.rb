require './board'
require './command'
require './robot_board_movement'

class Simulation
  BOARD_WIDTH = ENV['ROBOT_SIMULATION_BOARD_WIDTH'] || 5
  BOARD_LENGTH = ENV['ROBOT_SIMULATION_BOARD_LENGTH'] || 5

  def initialize(input: STDIN, output: STDOUT)
    @input = input
    @output = output
  end

  def start
    board = Board.new(BOARD_LENGTH, BOARD_WIDTH)
    robot_board_movement = RobotBoardMovement.new(board)

    output.puts welcome_note

    loop do
      command = input.gets.chomp

      break if command == 'EXIT'

      Command.new(command, robot_board_movement, proc { |position| output.puts position }).process
    end

  rescue
    output.puts "There was an error running that command.  Exiting the simulation."
  end

  private

  attr_reader :input, :output

  def welcome_note
    <<~WELCOME_NOTE
      Welcome to the Robot Simulation Program!

      Here are the available commands
        * PLACE <x>,<y>,<direction> - place the robot on the board
          - x and y are coordinations on the board
          - direction can be one of NORTH, EAST, SOUTH, WEST
        * LEFT - rotate the robot to the left
        * RIGHT - rotate the robot to the right
        * MOVE - move the robot 1 space forward
        * REPORT - report the location of the report
        * EXIT - exit the program

      You can now start entering your commands.  Enjoy!
    WELCOME_NOTE
  end
end

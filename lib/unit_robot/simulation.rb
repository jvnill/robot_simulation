module UnitRobot
  class Simulation
    BOARD_WIDTH = ENV['ROBOT_SIMULATION_BOARD_WIDTH'] || 5
    BOARD_LENGTH = ENV['ROBOT_SIMULATION_BOARD_LENGTH'] || 5

    WELCOME_NOTE = <<~WELCOME_NOTE
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

    def initialize(input: STDIN, output: STDOUT)
      @input = input
      @output = output
    end

    def start
      board = Board.new(BOARD_LENGTH, BOARD_WIDTH)
      robot = Robot.new

      output.puts WELCOME_NOTE

      loop do
        command = input.gets.chomp

        break if command == 'EXIT'

        command_parser = CommandParser.new(command)
        outputter = proc { |text| output.puts text }

        case command_parser.command_type
        when :movement
          mover = Mover.new(robot.get_position.dup, board)
          parsed_command = command_parser.parse
          robot.set_position(mover.process_command(parsed_command[:command], parsed_command[:position]))

        when :report
          position = robot.get_position

          if position
            outputter.call("#{position[:x]},#{position[:y]},#{position[:direction]}")
          else
            outputter.call "Robot is not on the board"
          end

        else
          outputter.call 'Invalid Command'
        end
      end
    end

    private

    attr_reader :input, :output
  end
end

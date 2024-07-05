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
      position = BoardPosition.new

      output.puts WELCOME_NOTE

      loop do
        input_string = input.gets.chomp

        begin
          command = command_class(input_string).new(input_string, position.get.dup)

          command.process

          if command.outputs_text? && command.output_text
            output.puts(command.output_text)
          end

          if command.moves_position?
            final_position = command.final_position

            if final_position && board.position_valid?(final_position[:x], final_position[:y])
              position.set(final_position)
            end
          end

          if command.exits_program?
            break
          end

        rescue
          output.puts "Unknown error. Exiting program."
          break
        end
      end
    end

    private

    attr_reader :input, :output

    # Command classes are based on the command string, eg
    #
    #   PLACE is UnitRobot::Command::Place
    #   MOVE is UnitRobot::Command::Move
    #
    # To add a command, just add the class under lib/unit_robot/command directory
    # and inherit Base class
    def command_class(input_string)
      identifier = input_string.split(' ').shift.downcase

      Object.const_get("UnitRobot::Command::#{identifier[0].upcase}#{identifier[1..-1]}Command")

    rescue NameError
      UnitRobot::Command::ErrorCommand
    end
  end
end

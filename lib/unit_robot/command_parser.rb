module UnitRobot
  class CommandParser
    MOVE_COMMANDS = %w[MOVE LEFT RIGHT]
    REPORT_COMMANDS = %w[REPORT]
    PLACE_COMMAND_REGEX = /PLACE\s+(\d+)\s*,\s*(\d+)\s*,\s*(NORTH|EAST|SOUTH|WEST)/

    def initialize(command)
      @command = command
    end

    def command_type
      case
      when valid_place_command?, valid_move_command?
        :movement

      when valid_report_command?
        :report
      end
    end

    def parse
      if valid_move_command?
        { command: command }

      elsif valid_place_command?
        x, y, direction = command.match(PLACE_COMMAND_REGEX).captures
        {
          command: 'PLACE',
          position: { x: x, y: y, direction: direction }
        }
      end
    end

    private

    attr_reader :command

    def valid_move_command?
      MOVE_COMMANDS.include?(command)
    end

    def valid_report_command?
      REPORT_COMMANDS.include?(command)
    end

    def valid_place_command?
      PLACE_COMMAND_REGEX =~ command
    end
  end
end

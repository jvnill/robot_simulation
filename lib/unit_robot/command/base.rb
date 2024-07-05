module UnitRobot::Command
  class Base
    attr_reader :final_position, :output_text

    def initialize(command_string, initial_position)
      @command_string = command_string
      @initial_position = initial_position
    end

    def process
      raise 'Implement me!'
    end

    def exits_program?
      false
    end

    def moves_position?
      !@final_position.nil?
    end

    def outputs_text?
      !@output_text.nil?
    end

    private

    attr_reader :command_string, :initial_position
  end
end

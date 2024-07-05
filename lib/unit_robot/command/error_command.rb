module UnitRobot::Command
  class ErrorCommand < Base
    def process
      @output_text = 'Invalid command. Ignoring.'
    end
  end
end

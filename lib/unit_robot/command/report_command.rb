module UnitRobot::Command
  class ReportCommand < Base
    def process
      if initial_position
        @output_text = "#{initial_position[:x]},#{initial_position[:y]},#{initial_position[:direction]}"

      else
        @output_text = 'Robot is not on the board'
      end
    end
  end
end

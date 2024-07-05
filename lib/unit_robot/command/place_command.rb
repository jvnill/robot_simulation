module UnitRobot::Command
  class PlaceCommand < Base
    COMMAND_REGEX = /PLACE\s+(\d+)\s*,\s*(\d+)\s*,\s*(NORTH|EAST|SOUTH|WEST)/

    def process
      if COMMAND_REGEX =~ command_string
        @final_position = {
          x: $1.to_i,
          y: $2.to_i,
          direction: $3
        }

      else
        @output_text = 'Invalid Command'
      end
    end
  end
end

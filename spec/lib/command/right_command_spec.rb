RSpec.shared_examples 'turning a robot' do |turn_command, initial_direction, final_direction|
  it "should turn the robot to face #{final_direction} if initially facing #{initial_direction}" do
    command = UnitRobot::Command::RightCommand.new('RIGHT', { x: 2, y: 2, direction: initial_direction })
    command.process

    expect(command.final_position).to eq({ x: 2, y: 2, direction: final_direction })
  end
end

describe UnitRobot::Command::RightCommand do
  context 'turning a robot right' do
    include_examples 'turning a robot', 'RIGHT', 'NORTH', 'EAST'
    include_examples 'turning a robot', 'RIGHT', 'EAST', 'SOUTH'
    include_examples 'turning a robot', 'RIGHT', 'SOUTH', 'WEST'
    include_examples 'turning a robot', 'RIGHT', 'WEST', 'NORTH'
  end
end

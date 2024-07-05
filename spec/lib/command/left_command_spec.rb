RSpec.shared_examples 'turning a robot' do |turn_command, initial_direction, final_direction|
  it "should turn the robot to face #{final_direction} if initially facing #{initial_direction}" do
    command = UnitRobot::Command::LeftCommand.new('LEFT', { x: 2, y: 2, direction: initial_direction })
    command.process

    expect(command.final_position).to eq({ x: 2, y: 2, direction: final_direction })
  end
end

describe UnitRobot::Command::LeftCommand do
  context 'turning a robot left' do
    include_examples 'turning a robot', 'LEFT', 'EAST', 'NORTH'
    include_examples 'turning a robot', 'LEFT', 'NORTH', 'WEST'
    include_examples 'turning a robot', 'LEFT', 'WEST', 'SOUTH'
    include_examples 'turning a robot', 'LEFT', 'SOUTH', 'EAST'
  end
end

RSpec.shared_examples 'moving a robot forward in the middle of the board' do |direction, x_change, y_change|
  it "facing #{direction} should move 1 unit forward" do
    command = UnitRobot::Command::MoveCommand.new('MOVE', { x: 2, y: 2, direction: direction })

    command.process

    expect(command.final_position).to eq({ x: 2 + x_change, y: 2 + y_change, direction: direction })
  end
end

RSpec.shared_examples 'moving a robot forward in the edge of the board' do |initial_x, initial_y, direction, x_change, y_change|
  it "facing #{direction} should move keep robot in the same position" do
    command = UnitRobot::Command::MoveCommand.new('MOVE', { x: 2, y: 2, direction: direction })

    command.process

    expect(command.final_position).to eq({ x: 2 + x_change, y: 2 + y_change, direction: direction })
  end
end

describe UnitRobot::Command::MoveCommand do
  context 'move_forward' do
    include_examples 'moving a robot forward in the middle of the board', 'NORTH', 0, 1
    include_examples 'moving a robot forward in the middle of the board', 'SOUTH', 0, -1
    include_examples 'moving a robot forward in the middle of the board', 'EAST', 1, 0
    include_examples 'moving a robot forward in the middle of the board', 'WEST', -1, 0
    include_examples 'moving a robot forward in the edge of the board', 2, 4, 'NORTH', 0, 1
    include_examples 'moving a robot forward in the edge of the board', 2, 0, 'SOUTH', 0, -1
    include_examples 'moving a robot forward in the edge of the board', 4, 2, 'EAST', 1, 0
    include_examples 'moving a robot forward in the edge of the board', 0, 2, 'WEST', -1, 0
  end
end

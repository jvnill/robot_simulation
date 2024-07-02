RSpec.shared_examples 'moving a robot forward in the middle of the board' do |direction, x_change, y_change|
  it "facing #{direction} should move 1 unit forward" do
    expect(board).to receive(:position_valid?).and_return(true, true)
    mover.process_command('PLACE', { x: 2, y: 2, direction: direction })
    expect(mover.process_command('MOVE')).to eq({ x: 2 + x_change, y: 2 + y_change, direction: direction })
  end
end

RSpec.shared_examples 'moving a robot forward in the edge of the board' do |direction, x, y|
  it "facing #{direction} should move keep robot in the same position" do
    initial_position = { x: x, y: y, direction: direction }

    expect(board).to receive(:position_valid?).and_return(true, false)
    mover.process_command('PLACE', initial_position)
    expect(mover.process_command('MOVE')).to eq(initial_position)
  end
end

RSpec.shared_examples 'turning a robot' do |turn_command, initial_direction, final_direction|
  it "should turn the robot to face #{final_direction} if initially facing #{initial_direction}" do
    expect(board).to receive(:position_valid?).and_return(true)
    mover.process_command('PLACE', { x: 2, y: 2, direction: initial_direction })
    expect(mover.process_command(turn_command)[:direction]).to eq(final_direction)
  end
end

describe UnitRobot::Mover do
  let(:board) { double }
  let(:current_position) { nil }
  let(:mover) { UnitRobot::Mover.new(current_position, board) }

  context 'move_forward' do
    include_examples 'moving a robot forward in the middle of the board', 'NORTH', 0, 1
    include_examples 'moving a robot forward in the middle of the board', 'SOUTH', 0, -1
    include_examples 'moving a robot forward in the middle of the board', 'EAST', 1, 0
    include_examples 'moving a robot forward in the middle of the board', 'WEST', -1, 0
    include_examples 'moving a robot forward in the edge of the board', 'NORTH', 2, 4
    include_examples 'moving a robot forward in the edge of the board', 'SOUTH', 2, 0
    include_examples 'moving a robot forward in the edge of the board', 'EAST', 4, 2
    include_examples 'moving a robot forward in the edge of the board', 'WEST', 0, 2
  end

  context 'set_position' do
    let(:current_position) { { x: 2, y: 2, direction: 'NORTH' } }
    let(:final_position) { { x: 4, y: 4, direction: 'NORTH' } }

    it "should correctly set the position if valid" do
      expect(board).to receive(:position_valid?).and_return(true)
      expect(mover.process_command('PLACE', final_position)).to eq(final_position)
    end

    it "should not save the position if invalid" do
      expect(board).to receive(:position_valid?).and_return(false)
      expect(mover.process_command('PLACE', final_position)).to eq(current_position)
    end
  end

  context 'turning a robot left' do
    include_examples 'turning a robot', 'LEFT', 'EAST', 'NORTH'
    include_examples 'turning a robot', 'LEFT', 'NORTH', 'WEST'
    include_examples 'turning a robot', 'LEFT', 'WEST', 'SOUTH'
    include_examples 'turning a robot', 'LEFT', 'SOUTH', 'EAST'
  end

  context 'turning a robot right' do
    include_examples 'turning a robot', 'RIGHT', 'NORTH', 'EAST'
    include_examples 'turning a robot', 'RIGHT', 'EAST', 'SOUTH'
    include_examples 'turning a robot', 'RIGHT', 'SOUTH', 'WEST'
    include_examples 'turning a robot', 'RIGHT', 'WEST', 'NORTH'
  end
end

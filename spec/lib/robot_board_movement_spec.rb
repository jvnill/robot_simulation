RSpec.shared_examples 'moving a robot forward in the middle of the board' do |direction, x_change, y_change|
  it "facing #{direction} should move 1 unit forward" do
    robot_board_movement.instance_variable_set('@position', { x: 2, y: 2, direction: direction })
    expect(board).to receive(:position_valid?).and_return(true)
    robot_board_movement.move_forward
    expect(robot_board_movement.position).to eq({ x: 2 + x_change, y: 2 + y_change, direction: direction })
  end
end

RSpec.shared_examples 'moving a robot forward in the edge of the board' do |direction, x, y|
  it "facing #{direction} should move keep robot in the same position" do
    robot_board_movement.instance_variable_set('@position', { x: x, y: y, direction: direction })
    expect(board).to receive(:position_valid?).and_return(false)
    robot_board_movement.move_forward
    expect(robot_board_movement.position).to eq({ x: x, y: y, direction: direction })
  end
end

RSpec.shared_examples 'turning a robot' do |turn_command, initial_direction, final_direction|
  it "should turn the robot to face #{final_direction} if initially facing #{initial_direction}" do
    robot_board_movement.instance_variable_set('@position', { x: 2, y: 2, direction: initial_direction })
    robot_board_movement.public_send(turn_command)

    expect(robot_board_movement.position[:direction]).to eq(final_direction)
  end
end

describe UnitRobot::RobotBoardMovement do
  let(:board) { double }
  let(:robot_board_movement) { UnitRobot::RobotBoardMovement.new(board) }

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

  context 'get_position' do
    it "should return the position in the format x,y,direction" do
      robot_board_movement.instance_variable_set('@position', { x: 2, y: 2, direction: 'NORTH' })

      expect(robot_board_movement.get_position).to eq('2,2,NORTH')
    end
  end

  context 'set_position' do
    it "should correctly set the position if valid" do
      robot_board_movement.instance_variable_set('@position', { x: 2, y: 2, direction: 'NORTH' })
      expect(board).to receive(:position_valid?).and_return(true)
      robot_board_movement.set_position(4,4,'NORTH')
      expect(robot_board_movement.position).to eq({ x: 4, y: 4, direction: 'NORTH' })
    end

    it "should not save the position if invalid" do
      robot_board_movement.instance_variable_set('@position', { x: 2, y: 2, direction: 'NORTH' })
      expect(board).to receive(:position_valid?).and_return(false)
      robot_board_movement.set_position(4,4,'NORTH')
      expect(robot_board_movement.position).to eq({ x: 2, y: 2, direction: 'NORTH' })
    end
  end

  context 'turn_left' do
    include_examples 'turning a robot', 'turn_left', 'EAST', 'NORTH'
    include_examples 'turning a robot', 'turn_left', 'NORTH', 'WEST'
    include_examples 'turning a robot', 'turn_left', 'WEST', 'SOUTH'
    include_examples 'turning a robot', 'turn_left', 'SOUTH', 'EAST'
  end

  context 'turn_right' do
    include_examples 'turning a robot', 'turn_right', 'NORTH', 'EAST'
    include_examples 'turning a robot', 'turn_right', 'EAST', 'SOUTH'
    include_examples 'turning a robot', 'turn_right', 'SOUTH', 'WEST'
    include_examples 'turning a robot', 'turn_right', 'WEST', 'NORTH'
  end
end

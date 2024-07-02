describe UnitRobot::Command do
  let(:command_input) { nil }
  let(:robot_board_movement) { double }
  let(:report_proc) { double }
  let(:command) { UnitRobot::Command.new(command_input, robot_board_movement, report_proc) }

  context 'process' do
    context 'valid move/turn/report command' do
      let(:command_input) { 'MOVE' }

      before { expect(command).to receive(:send).with(command_input.downcase).and_return('valid move command') }

      it { expect(command.process).to eq('valid move command') }
    end

    context 'valid place command' do
      let(:command_input) { 'PLACE 0,0,NORTH' }

      before { expect(command).to receive(:place).and_return('valid place command') }

      it { expect(command.process).to eq('valid place command') }
    end

    context 'invalid command' do
      let(:command_input) { 'PLACE' }

      before { expect(report_proc).to receive(:call).with('Invalid Command') }

      it { expect(command.process).to be_nil }
    end
  end

  context 'left' do
    let(:command_input) { 'LEFT' }

    before { expect(robot_board_movement).to receive(:turn_left).and_return('turned left') }

    it { expect(command.process).to eq('turned left') }
  end

  context 'move' do
    let(:command_input) { 'MOVE' }

    before { expect(robot_board_movement).to receive(:move_forward).and_return('moved forward') }

    it { expect(command.process).to eq('moved forward') }
  end

  context 'place' do
    let(:command_input) { 'PLACE 0,0,NORTH' }

    before do
      expect(robot_board_movement).to receive(:set_position).with('0', '0', 'NORTH').and_return('set robot position')
    end

    it { expect(command.process).to eq('set robot position') }
  end

  context 'report' do
    let(:command_input) { 'REPORT' }
    let(:report_proc) { proc { |x| x } }

    before do
      expect(report_proc).to receive(:call).and_call_original
      expect(robot_board_movement).to receive(:get_position).and_return('robot position')
    end

    it { expect(command.process).to eq('robot position') }
  end

  context 'right' do
    let(:command_input) { 'RIGHT' }

    before { expect(robot_board_movement).to receive(:turn_right).and_return('turned right') }

    it { expect(command.process).to eq('turned right') }
  end
end

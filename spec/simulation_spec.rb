require './simulation'
require 'pry'

RSpec.shared_examples 'turning a robot' do |turn_command, initial_direction, final_direction|
  it "should turn the robot to face #{initial_direction} if initially facing #{final_direction}" do
    expect(input).to receive(:gets).and_return("PLACE 0,0,#{initial_direction}\n", "#{turn_command}\n", "REPORT\n", "EXIT\n")
    expect(output).to receive(:puts).with(Simulation::WELCOME_NOTE)
    expect(output).to receive(:puts).with("0,0,#{final_direction}")

    simulation.start
  end
end

RSpec.shared_examples 'moving a robot' do |initial_position, final_position|
  it "should advance the robot 1 unit facing #{initial_position.split(',').pop}" do
    expect(input).to receive(:gets).and_return("PLACE #{initial_position}\n", "MOVE\n", "REPORT\n", "EXIT\n")
    expect(output).to receive(:puts).with(Simulation::WELCOME_NOTE)
    expect(output).to receive(:puts).with(final_position)

    simulation.start
  end
end

describe Simulation do
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  let(:simulation) { Simulation.new(input: input, output: output) }

  context 'PLACE and REPORT command' do
    before do
      allow(input).to receive(:gets).and_return("PLACE 0,0,NORTH\n", "REPORT\n", "EXIT\n")
    end

    it 'should place the robot and report the position' do
      expect(output).to receive(:puts).with(Simulation::WELCOME_NOTE)
      expect(output).to receive(:puts).with('0,0,NORTH')

      simulation.start
    end
  end

  context 'LEFT command' do
    include_examples 'turning a robot', 'LEFT', 'EAST', 'NORTH'
    include_examples 'turning a robot', 'LEFT', 'NORTH', 'WEST'
    include_examples 'turning a robot', 'LEFT', 'WEST', 'SOUTH'
    include_examples 'turning a robot', 'LEFT', 'SOUTH', 'EAST'
  end

  context 'RIGHT command' do
    include_examples 'turning a robot', 'RIGHT', 'NORTH', 'EAST'
    include_examples 'turning a robot', 'RIGHT', 'EAST', 'SOUTH'
    include_examples 'turning a robot', 'RIGHT', 'SOUTH', 'WEST'
    include_examples 'turning a robot', 'RIGHT', 'WEST', 'NORTH'
  end

  context 'MOVE command' do
    context 'and robot is not on the edge' do
      include_examples 'moving a robot', '2,2,NORTH', '2,3,NORTH'
      include_examples 'moving a robot', '2,2,EAST', '3,2,EAST'
      include_examples 'moving a robot', '2,2,SOUTH', '2,1,SOUTH'
      include_examples 'moving a robot', '2,2,WEST', '1,2,WEST'
    end

    context 'robot is about to move off the table' do
      include_examples 'moving a robot', '2,4,NORTH', '2,4,NORTH'
      include_examples 'moving a robot', '4,2,EAST', '4,2,EAST'
      include_examples 'moving a robot', '2,0,SOUTH', '2,0,SOUTH'
      include_examples 'moving a robot', '0,2,WEST', '0,2,WEST'
    end
  end

  context 'invalid command' do
    before do
      allow(input).to receive(:gets).and_return("PLACE 0,0,NOTH\n", "REPORT\n", "EXIT\n")
    end

    it 'should not do anything and output Invalid command' do
      expect(output).to receive(:puts).with(Simulation::WELCOME_NOTE)
      expect(output).to receive(:puts).with('Invalid Command')
      expect(output).to receive(:puts).with(nil)

      simulation.start
    end
  end
end

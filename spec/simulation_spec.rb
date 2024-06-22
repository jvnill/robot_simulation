require './simulation'

describe Simulation do
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  let(:simulation) { Simulation.new(input: input, output: output) }

  before do
    allow(input).to receive(:gets).and_return("PLACE 0,0,NORTH\n", "REPORT\n", "EXIT\n")
  end

  it 'should work with a simple PLACE command' do
    expect(output).to receive(:puts).and_return("0,0,NORTH");

    simulation.start
  end
end

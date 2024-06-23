require './board'

describe Board do
  let(:length) { 5 }
  let(:width) { 5 }
  let(:board) { Board.new(length, width) }

  [
    [0, 0, true],
    [-1, 0, false],
    [0, -1, false]
  ].each do |x, y, expectation|
    it { expect(board.position_valid?(x,y)).to eq(expectation) }
  end

  it { expect(board.position_valid?(length - 1, 0)).to eq(true) }
  it { expect(board.position_valid?(0, width - 1)).to eq(true) }
  it { expect(board.position_valid?(length, 0)).to eq(false) }
  it { expect(board.position_valid?(0, width)).to eq(false) }
end

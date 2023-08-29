require_relative 'board'

describe Board do

  subject(:board) { Board.new }
  describe '#full?' do
    it 'returns true when column is full' do
      column = ['Y', 'R', 'R', 'Y', 'R', 'Y']
      expect(board.full?(column)).to be_truthy
    end

    it "returns false when column contains empty symbols ('O')" do
      column = ['Y', 'R', 'R', 'Y', 'R', 'Y', 'O']
      expect(board.full?(column)).to be_falsey
    end
  end
end
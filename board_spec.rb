require_relative 'board'

describe Board do

  subject(:board) { Board.new }
  describe '#full?' do
    context 'when column is full' do
      before do
        # fills column 4
        board.grid.each { |row| row[3] = 'R' }
      end

      it 'returns true' do
        full_column = 4
        expect(board.full?(full_column)).to be_truthy
      end
    end

    context "when column contains empty symbols ('O')" do
      before do
        # fill only bottom three cells of column 1
        (3..5).each { |index| board.grid[index][1] = 'Y' }
      end
      it 'returns false' do
        valid_column = 2
        expect(board.full?(valid_column)).to be_falsey
      end
    end
  end

  describe '#place_piece' do

    # reminder: place_piece method should iterates in reverse, so the first row it checks [0] is actually the last (bottom most) row [5] (0 - 5 rows, 6 total)

    context 'when player selects an empty column' do
      it 'places the correct symbol in the correct column' do
        symbol = 'R'
        column = 4
        board.place_piece(column, symbol)

        # [5] is the bottom-most row
        expect(board.grid[5][column - 1]).to eq(symbol)
      end
    end

    context 'when player selects an occupied column' do
      before do
        symbol = 'R'
        column = 4
        board.place_piece(column, symbol)
      end

      it 'does not replace the occupied space' do
        new_sym = 'Y'
        column = 4
        board.place_piece(column, new_sym)

        expect(board.grid[5][column - 1]).to eq('R')
      end

      it 'places a new symbol above the occupied space' do
        new_sym = 'Y'
        column = 4
        board.place_piece(column, new_sym)

        expect(board.grid[4][column - 1]).to eq('Y')
      end
    end  
  end
end
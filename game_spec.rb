require_relative 'game'
require_relative 'board'

describe Game do

  subject(:game) { Game.new }
  describe '#play' do
    it 'begins with win_state set to false' do
      game.play
      expect(game.win_state).to eq(false)
    end

    context 'after receiving valid user input' do
      it 'calls place piece function when given valid input' do
        board = instance_double(Board)
        allow(board).to receive(:place_piece)
        game = Game.new(board)
        game.play
        expect(game).to have_receive(:place_piece)
      end

      xit 'switches current player once player move is resolved' do

      end
    end
  end

  describe '#player_input' do
    subject(:game) { described_class.new }
    context 'when receiving two invalid inputs, and then a valid input' do
      before do
        invalid_input = 'one'
        another_invalid_input = '9'
        valid_input = '2'
        allow(game).to receive(:gets).and_return(invalid_input, another_invalid_input, valid_input)
      end

      it 'sends two error messages, and then finishes' do
        error_message = 'invalid input, please choose valid column'
        expect(game).to receive(:puts).with(error_message).twice
        expect(game).not_to receive(:puts).with(error_message)
        game.player_input
      end

      it 'returns the valid input' do
        expect(game.player_input).to eq(2)
        game.player_input
      end
    end

    # is this necessary?
    context 'when receiving valid input' do
      before do
        valid_input = '3'
        allow(game).to receive(:gets).and_return(valid_input)
      end

      it 'does not send error message' do
        error_message = 'invalid input, please choose valid column'
        expect(game).not_to receive(:puts).with(error_message)
        game.player_input
      end
    end
  end

  describe '#player_move' do
    subject(:game) { described_class.new }
    # subject(:board) { Board.new }

    context 'when first chosen column is full, and then available column is chosen' do
      before do
        # full column 4
        game.board.grid.each { |row| row[3] = 'R' }

        #valid column 2
        (3..5).each { |index| game.board.grid[index][1] = 'Y' }
      end
      it 'checks if chosen column is full and returns valid input when valid' do
        expect(game.player_move(4)).to be_nil
        expect(game.player_move(2)).to eq(2)
      end

      it 'sends an error message' do
        error_message = 'column full, please choose valid column'

        expect{ game.player_move(4) }.to output("#{error_message}\n").to_stdout
      end
    end
  end
end
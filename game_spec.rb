require_relative 'game'
require_relative 'board'

describe Game do
  describe '#play' do
    let(:game) { Game.new }
    let(:board) { Board.new }

    context 'when playing a game' do
      before do
        allow(game).to receive(:player_input).and_return(3, 4, 3, 4, 3, 4, 3)
        allow(game).to receive(:check_win).and_return(false, false, false, false, false, false, true)
      end
      it 'calls check_win after every turn' do
        expect(game).to receive(:check_win).exactly(7).times
        game.play
      end

      it 'switches current player after each non winning move' do
        expect(game).to receive(:switch_players).exactly(6).times
        game.play
      end
    end
    
    context 'when the game ends with a winner' do
      before do
        allow(game).to receive(:player_input).and_return(3)
        allow(game).to receive(:check_win).and_return(true)
      end
      it 'changes win_state to true' do
        game.play
        expect(game.win_state).to be true
      end

      it 'does not switch the current player' do
        expect(game).not_to receive(:switch_players)
        game.play
      end

      it 'calls the game_end_win method' do
        expect(game).to receive(:game_end_win)
        game.play
      end
    end

    context 'when the game ends in a draw' do
      before do
        # set board to a tie on R's move
        game.board = board
        game.board.grid = [
          %w[Y Y Y O Y Y Y],
          %w[R R R Y R R R],
          %w[Y Y R R R Y R],
          %w[R R Y Y R R Y],
          %w[Y Y R R Y Y R],
          %w[Y Y R R Y R Y]
        ]
        allow(game).to receive(:player_input).and_return(4)

        # set pieces placed
        game.pieces_placed = 41
      end

      it 'tracks that 42 pieces have been placed' do
        game.play
        expect(game.pieces_placed).to eq(42)
      end

      it 'does not change the win_state to true' do
        game.play
        expect(game.win_state).to be false
      end

      it 'calls the game_end_draw method instead of game_end_win' do
        expect(game).to receive(:game_end_draw)
        expect(game).not_to receive(:game_end_win)
        game.play
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
    let(:game) { Game.new }
    let(:board) { Board.new }

    # these tests still fail!!!
    context 'when first chosen column is full, and then available column is chosen' do
      before do
        game.board = board
        game.board.grid = [
          %w[O O O Y O O O],
          %w[O O O R O O O],
          %w[O O O Y O O O],
          %w[O R O R O O O],
          %w[O R O Y O O O],
          %w[O R O R O O O]
        ]

        allow(game).to receive(:player_input).and_return(4, 2)
        allow(game).to receive(:check_win).and_return(true)
      end
      it 'does not call check_win until available column is chosen' do
        expect(game).to receive(:check_win).once
        game.play
      end

      it 'sends an error message' do
        error_message = 'column full, please choose valid column'
        game.play
        expect { game.player_move(4) }.to output("#{error_message}\n").to_stdout
      end
    end
  end

  describe '#check_win' do
    let(:game) { Game.new }
    let(:board) { Board.new }

    context 'when check_win_rows returns true' do
      before do
        game.board = board
        game.board.grid[0][0] = 'R'
        game.board.grid[0][1] = 'R'
        game.board.grid[0][2] = 'R'
        game.board.grid[0][3] = 'R'
      end
      it 'returns true' do
        expect(game.check_win).to be true
      end
    end

    context 'when check_win_columns returns true' do
      before do
        game.board = board
        board.grid[1][4] = 'Y'
        board.grid[2][4] = 'Y'
        board.grid[3][4] = 'Y'
        board.grid[4][4] = 'Y'
      end
      it 'returns true' do
        expect(game.check_win).to be true
      end
    end

    context 'when check_win_diagonals returns true' do
      before do
        game.board = board
        board.grid[2][5] = 'R'
        board.grid[3][4] = 'R'
        board.grid[4][3] = 'R'
        board.grid[5][2] = 'R'
      end
      it 'returns true' do
        expect(game.check_win).to be true
      end
    end

    context 'when all check_win methods return false' do
      it 'returns false' do
        allow(board).to receive(:check_win_rows).and_return(false)
        allow(board).to receive(:check_win_columns).and_return(false)
        allow(board).to receive(:check_win_diagonals).and_return(false)
        expect(game.check_win).to be false
      end
    end
  end
end
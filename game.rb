require_relative 'board'
require_relative 'player'

class Game
  attr_accessor :win_state, :board, :players, :current_player

  def initialize(win_state: false)
    @win_state = win_state
    @board = Board.new
    @players = [Player.new('R'), Player.new('Y')]
    @current_player = @players.first
  end

  def play
    board.grid[2][5] = 'R'
    board.grid[3][4] = 'R'
    board.grid[4][3] = 'R'
    board.grid[5][2] = 'R'
    if board.check_win_diagonals
      puts 'yea'
    else
      puts 'no'
    end
    
    # current_move = player_move(player_input)
    # @board.place_piece(current_move, @current_player.symbol)
    # @board.print_board

    # check win conditions

    # switch_players
  end

  # gets column number from player
  def player_input
    loop do
      error_message = 'invalid input, please choose valid column'
      column = gets.chomp.to_i
      # use 1 instead of 0 for first number bypasses non-numerical input.to_i being misattributed as 0
      return column if column.between?(1, 7)

      puts error_message
    end
  end

  def player_move(valid_column)

    error_message = 'column full, please choose valid column'
    return valid_column unless @board.full?(valid_column)

    puts error_message
  end

  def switch_players
    @current_player = @players.rotate!.first
  end
end

game = Game.new
game.play



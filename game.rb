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
    # associates chosen (valid) column with an array in an array in @board, which means i have to set up the grid arrays. after a valid column is chosen, the @current_player's symbol is used in a "place_piece" method. do i need to have a new method that updates the symbol? player will have its own class, but the symbol will just be an attribute in the class, so a newly created player will have their specific symbol. the symbol will always stay the same until player's piece is placed. so if place_piece is called and finished, that means the current player will switch. 

    #it will be a board method, so in game it'll get called like @board.place_piece(@current_player, player_move) right?

    # player_move(player_input)
    # place_piece(player_move)
    # return
  end

  # gets number from player
  def player_input
    loop do
      error_message = 'invalid input, please choose valid column'
      column = gets.chomp.to_i
      # use 1 instead of 0 for first number bypasses non-numerical input.to_i being misattributed as 0
      return column if column.between?(1, 3)

      puts error_message
    end
  end

  # uses number received from player_input as @current_player's move
  def player_move(valid_column)

    #valid_column in this is currently the chosen column number from player_input method. when this method checks to see if this column is full, it has to contact the board class with that number, and check against the array of that corresponding column. so it's not doing "full?(3), but full?(column_3's array)"
    error_message = 'column full, please choose valid column'
    return valid_column unless @board.full?(valid_column)

    puts error_message
  end
end

# game = Game.new
# game.play



require_relative 'board'
require_relative 'player'
require 'byebug'

class Game
  attr_reader :win_state, :players, :current_player
  attr_accessor :board

  def initialize(win_state: false)
    @win_state = win_state
    @board = Board.new
    @players = [Player.new('R'), Player.new('Y')]
    @current_player = @players.first
  end

  def play
    loop do
      column = player_input
      player_move(column)
      puts "i'm about to call check win, ready?"
      if check_win
        p "inside the check_win block"
        @win_state = true
        p "suddenly win state is true!!!!!"
        break
      end
      puts "win state is #{@win_state.inspect}"
      # break if @pieces_placed == 30
      puts "calling switch_players now!"
      switch_players
    end
    # @win_state ? game_end_win : game_end_draw
  end

  # gets column number from player
  def player_input
    puts "Calling player_input"
    loop do
      error_message = 'invalid input, please choose valid column'
      column = gets.chomp.to_i
      # use 1 instead of 0 for first number bypasses non-numerical input.to_i being misattributed as 0
      return column if column.between?(1, 7)

      puts error_message

    rescue StandardError => e
      puts "Error in player_input: #{e.message}"
    end
  end

  def player_move(valid_column)
    loop do
      if @board.full?(valid_column)
        puts 'column full, please choose valid column'
        valid_column = player_input
      else
        # @pieces_placed += 1
        return @board.place_piece(valid_column, @current_player.symbol)
      end
    end


  #   # puts "Calling player_move with column: #{valid_column}"
  #   error_message = 'column full, please choose valid column'
  #   return valid_column unless @board.full?(valid_column)

  #   puts error_message

  # rescue StandardError => e
  #   puts "Error in player_move: #{e.message}"
  end

  def check_win
    # byebug
    # check if any of the check_win methods return true
    %i[check_win_rows check_win_columns check_win_diagonals].any? { |name| @board.send(name) }
  end

  def switch_players
    @current_player = @players.rotate!.first
  end
end

# game = Game.new
# game.play


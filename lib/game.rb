# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require 'colorize'

class Game
  attr_reader :win_state, :players, :current_player
  attr_accessor :board, :pieces_placed

  def initialize(pieces_placed = 0, win_state: false)
    @win_state = win_state
    @board = Board.new
    @players = [Player.new('Player 1', 'R'), Player.new('Player 2', 'Y')]
    @current_player = @players.first
    @pieces_placed = pieces_placed
  end

  def play
    board.print_board
    loop do
      puts "#{current_player.name}, choose a column to drop your #{@current_player.symbol.colorize(@current_player.color)}:"

      column = player_input
      player_move(column)
      if check_win
        @win_state = true
        break
      end
      break if @pieces_placed == 42

      switch_players
    end
    @win_state ? game_end_win : game_end_draw
  end

  # gets column number from player
  def player_input
    loop do
      error_message = 'invalid input, please choose valid column (1 - 7)'
      column = gets.chomp.to_i
      # use 1 instead of 0 for first number bypasses non-numerical input.to_i being misattributed as 0
      return column if column.between?(1, 7)

      puts error_message
    end
  end

  def player_move(valid_column)
    loop do
      if @board.full?(valid_column)
        puts 'column full, please choose valid column'
        valid_column = player_input
      else
        @pieces_placed += 1
        return @board.place_piece(valid_column, @current_player.symbol)
      end
    end
  end

  def check_win
    # check if any of the check_win methods return true
    %i[check_win_rows check_win_columns check_win_diagonals].any? { |name| @board.send(name) }
  end

  def switch_players
    @current_player = @players.rotate!.first
  end

  def game_end_win
    puts "#{@current_player.name.colorize(@current_player.color)} wins!\n\n"
  end

  def game_end_draw
    puts "it's a draw!"
  end
end


class Game
  attr_reader :win_state

  def initialize(win_state: false)
    @win_state = win_state
  end

  def play
    return
  end

  def player_input
    loop do
      error_message = 'invalid input, please choose valid column'
      column = gets.chomp.to_i
      # use 1 instead of 0 for first number bypasses non-numerical input.to_i being misattributed as 0
      return column if column.between?(1, 3)

      puts error_message
    end
  end
end

# game = Game.new
# game.play



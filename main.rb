require_relative 'game'
require_relative 'board'
require_relative 'player'

game_initialized = false
while !game_initialized
  begin
    game = Game.new
    game_initialized = true
  rescue NoNameError
    # do nothing, but it will restart the game
  end
end
game.play

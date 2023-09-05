class Player
  attr_reader :symbol, :color

  def initialize(symbol)
    @symbol = symbol
    @color = symbol == 'R' ? :red : :yellow
  end
end
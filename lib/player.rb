class Player
  attr_reader :name, :symbol, :color

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @color = symbol == 'R' ? :red : :yellow
  end
end
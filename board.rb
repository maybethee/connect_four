class Board

  attr_accessor :size

  def initialize(size = 7)
    @size = size
  end

  def full?(column)
    # full? checks if an array (column) contains any symbols representing empty cells column.any? {'O'} or some each loop if i can't do any?, returns true if no empty symbols.
    column.none?('O')
  end
end
class Board

  attr_reader :rows, :columns, :grid

  def initialize(rows = 6, columns = 7)
    @rows = rows
    @columns = columns
    @grid = Array.new(@rows) { Array.new(@columns, 'O') }
  end

  def full?(column)
    # full? checks if an array (column) contains any symbols representing empty cells column.any? {'O'} or some each loop if i can't do any?, returns true if no empty symbols.
    
    #so this should actually do like, grid[column].none? or something? 
    column.none?('O')
  end

  def print_board
    @grid.each_with_index do |row, i|
      puts "#{@rows - i} | #{row.join(' | ')} |"
    end

    puts "    #{(1..@columns).to_a.join('   ')}"
  end

  def place_piece(column, symbol)
    #symbol replaces 'O' on lowest row in corresponding column on grid
    column -= 1

    @grid.reverse_each do |row|
      if row[column] == 'O'
        row[column] = symbol
        break
      end
    end
  end
end
class Board

  attr_reader :rows, :columns, :grid

  def initialize(rows = 6, columns = 7)
    @rows = rows
    @columns = columns
    @grid = Array.new(@rows) { Array.new(@columns, 'O') }
  end

  def full?(column)
    column -= 1

    @grid.reverse_each do |row|
      if row[column] == 'O'
        return false
      end
    end
    true
  end

  def print_board
    @grid.each_with_index do |row, i|
      puts "#{@rows - i} | #{row.join(' | ')} |"
    end

    puts "    #{(1..@columns).to_a.join('   ')}"
  end

  def place_piece(column, symbol)
    # symbol replaces 'O' on lowest row in corresponding column on grid
    column -= 1

    @grid.reverse_each do |row|
      if row[column] == 'O'
        row[column] = symbol
        break
      end
    end
  end

  # def check_win_rows

  # end

  # def check_win_columns

  # end

  def check_win_diagonals
    6.times do |row|
      7.times do |col|
        diagonal1 = (0..3).collect { |i| @grid[row + i][col + i] if row + i < 6 && col + i < 7 }
        diagonal2 = (0..3).collect { |i| @grid[row + i][col - i] if row + i < 6 && col - i >= 0 }
        return true if diagonal1.uniq.size == 1 && %w[R Y].include?(diagonal1.first)
        return true if diagonal2.uniq.size == 1 && %w[R Y].include?(diagonal2.first)
      end
    end

    # no win found
    false
  end
end
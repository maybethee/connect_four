# frozen_string_literal: true

require 'colorize'

class Board

  attr_reader :rows, :columns
  attr_accessor :grid

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
    puts
    @grid.each do |row|
      row_string = row.map do |cell|
        case cell
        when 'R'
          cell.red
        when 'Y'
          cell.yellow
        when 'O'
          cell.light_black
        else
          cell
        end
      end.join(' | ')
      puts "| #{row_string} |"
    end

    puts "  #{(1..@columns).to_a.join('   ')}"
    puts
  end

  def place_piece(column, symbol)
    # symbol replaces 'O' on lowest row in corresponding column on grid
    column -= 1

    @grid.reverse_each do |row|
      next unless row[column] == 'O'

      row[column] = symbol
      print_board
      break
    end
    column
  end

  def check_win_rows
    @grid.each do |row|
      # in each row iterate over 4-long subarrays
      row.each_cons(4) do |consecutive|
        return true if consecutive.uniq.size == 1 && consecutive.first != 'O'
      end
    end
    # no win found
    false
  end

  def check_win_columns
    # transpose columns to rows and reuse the same method for checking rows
    @grid.transpose.each do |column|
      column.each_cons(4) do |consecutive|
        return true if consecutive.uniq.size == 1 && consecutive.first != 'O'
      end
    end
    # no win found
    false
  end

  def check_win_diagonals
    # iterate over rows
    6.times do |row|
      # iterate over columns
      7.times do |col|
        # diagonal1 checks in one direction
        diagonal1 = (0..3).collect { |i| @grid[row + i][col + i] if row + i < 6 && col + i < 7 }
        # diagonal2 checks the other direction
        diagonal2 = (0..3).collect { |i| @grid[row + i][col - i] if row + i < 6 && col - i >= 0 }

        # uses uniq to check matching based on the first character in diagonal
        return true if diagonal1.uniq.size == 1 && %w[R Y].include?(diagonal1.first)
        return true if diagonal2.uniq.size == 1 && %w[R Y].include?(diagonal2.first)
      end
    end
    # no win found
    false
  end
end


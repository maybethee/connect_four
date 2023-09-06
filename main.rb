# frozen_string_literal: true

require_relative './lib/game'
require 'colorize'


def introduction
  red_piece = 'R'
  yellow_piece = 'Y'

  puts "\nWelcome to Connect Four, a completely unique\nand original game that I made up myself!\n\n"
  puts "Since it's such a new game, here are the rules:\n\n"
  puts "This game is for two players to play.\n\n"
  puts 'The goal is to make four in a row in any direction'
  puts "each player takes turns placing one of these two pieces:\n\n"
  puts "#{red_piece.red} (red piece)\n#{yellow_piece.yellow} (yellow piece)\n\non this empty board:"
end

def main_game
  loop do
    game = Game.new
    game.play
    break unless another_game?
  end
end

def another_game?
  loop do
    puts "Do you want to play again? (y/n)"
    input = gets.chomp.downcase
    return true if input == 'y'
    return false if input == 'n'
  end
end

introduction
main_game
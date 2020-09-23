# frozen_string_literal: true

require_relative 'Board.rb'
require_relative 'Knight.rb'

# The main function to send information
class KnightMoves
  def initialize
    start_game
  end

  def start_game
    board = Board.new
    puts board.display_board
    puts "\nPick the row for the starting position of the knight: "
    x1 = gets.chomp.to_i
    until x1 >= 1 && x1 <= 8
      puts "\nInvalid Input! \nPick a new input: "
      x1 = gets.chomp.to_i
    end
    puts "\nPick the column for the starting position of the knight: "
    x2 = gets.chomp.to_i
    until x2 >= 1 && x2 <= 8
      puts "\nInvalid Input! \nPick a new input: "
      x2 = gets.chomp.to_i
    end
    puts "\nPick the row for the ending position of the knight: "
    y1 = gets.chomp.to_i
    until y1 >= 1 && y1 <= 8
      puts "\nInvalid Input! \nPick a new input: "
      y1 = gets.chomp.to_i
    end
    puts "\nPick the column for the ending position of the knight: "
    y2 = gets.chomp.to_i
    until y2 >= 1 && y2 <= 8
      puts "\nInvalid Input! \nPick a new input: "
      y2 = gets.chomp.to_i
    end
    knight_moves([x1, x2], [y1, y2], board)
  end

  def knight_moves(start_position, end_position, board)
    puts "\n----------------------------------\n\n"
    board.show_path([start_position[0], start_position[1]], [end_position[0], end_position[1]])
  end
end

start = KnightMoves.new

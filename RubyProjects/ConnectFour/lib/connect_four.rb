# frozen_string_literal: true

require_relative 'player_interface.rb'
require_relative 'board.rb'

# The base game
class Connect_Four 
  def initialize
    @used_values = []
    @interface = Interface.new
    @board = Board.new
    start_game
  end

  def start_game
    puts "(Red Pieces) Player 1's name: "
    @player_1 = gets.chomp
    puts "\n(Yellow Pieces) Player 2's name: "
    @player_2 = gets.chomp
    while @interface.game_over?(@board.board)
      puts @board.board
      puts "\n(Red) #{@player_1}'s turn"
      puts "Column: "
      response = gets.chomp.to_i
      @used_values.push(response)
      until response >= 1 && response <= 7 && @used_values.count(response) <= 6
        puts "\nInvalid Entry!\nColumn: "
        response = gets.chomp.to_i
        @used_values.push(response)
      end
      @board.each_turn(response, "\u25EF".red)
      puts @board.board
      if @interface.victory?(@board.cell)
        puts "Game Over: #{@player_1} won!"
        @board.highlight_path(@interface.golden_path)
        puts @board.board
        break
      end
      puts "\n(Yellow) #{@player_2}'s turn"
      puts "Column: "
      response = gets.chomp.to_i
      @used_values.push(response)
      until response >= 0 && response <= 7 && @used_values.count(response) <= 6
        puts "\nInvalid Entry!\nColumn: "
        response = gets.chomp.to_i
        @used_values.push(response)
      end
      @board.each_turn(response, "\u25EF".yellow)
      if @interface.victory?(@board.cell)
        puts "Game Over: #{@player_2} won!"
        @board.highlight_path(@interface.golden_path)
        puts @board.board
        break
      end
    end
  end
end

game = Connect_Four.new

# BUGS: FIND A WAY TO ALLOW THE PLAYER TO INPUT COLUMN AGAIN BECAUSE IF IT CAN'T THE SYSTEM JUST MOVES ON TO THEE NEXT PLAYER ON THE NEXT ROUND
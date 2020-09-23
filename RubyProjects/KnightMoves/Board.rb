# frozen_string_literal: true


require_relative 'Knight.rb'
# To add colors for the letters and the chess board
class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def black
    colorize(40)
  end

  def white
    colorize(47)
  end

  def blue
    colorize(36)
  end
end

# To display the board
class Board
  attr_reader :board
  def initialize
    @board = generate_board
  end

  def generate_board
    board = []
    for i in 1..8
      temp = []
      temp.push("#{i} ")
      for j in 1..8
        temp.push('  '.white) if (i + j).even?
        temp.push('  '.black) if (i + j).odd?
      end
      temp.push("\n")
      board.push(temp)
    end
    puts '  1 2 3 4 5 6 7 8'
    board
  end

  def display_board
    @board.join
  end

  def show_path(x, y)
    path = Knight.new([x[0], x[1]], [y[0], y[1]]).find_path
    value = 1
    path.each do |cell|
      for i in 0..7
        for j in 1..8
          if i + 1 == cell[0] && j == cell[1]
            board[i][j] = board[i][j].sub('  ', "#{value.to_s + ' '}".blue)
          end
        end
      end
      value += 1
    end
    puts '  1 2 3 4 5 6 7 8'
    puts display_board
    print_path(path)
  end

  def print_path(path)
    puts "\n\n"
    path.each_with_index do |cell, i|
      print "(#{cell[0]}, #{cell[1]})"
      if i != path.length-1
        print " --> "
      end
    end
    puts "\n"
  end
end

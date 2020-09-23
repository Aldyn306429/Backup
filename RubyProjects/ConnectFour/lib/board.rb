# frozen_string_literal: true

# Colors for the player pieces
class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def yellow
    colorize(33)
  end

  def bg_yellow
    colorize(43)
  end
end

# The board of the game
class Board
  attr_accessor :cell
  attr_accessor :board

  def initialize
    @cell = Array.new([['-', '-', '-', '-', '-', '-', '-'],
      ['-', '-', '-', '-', '-', '-', '-'],
      ['-', '-', '-', '-', '-', '-', '-'],
      ['-', '-', '-', '-', '-', '-', '-'],
      ['-', '-', '-', '-', '-', '-', '-'],
      ['-', '-', '-', '-', '-', '-', '-']])
    make_change
  end

  def make_change
    @board =
      "        1   2   3   4   5   6   7
      | #{@cell[0][0]} | #{@cell[0][1]} | #{@cell[0][2]} | #{@cell[0][3]} | #{@cell[0][4]} | #{@cell[0][5]} | #{@cell[0][6]} |
      | #{@cell[1][0]} | #{@cell[1][1]} | #{@cell[1][2]} | #{@cell[1][3]} | #{@cell[1][4]} | #{@cell[1][5]} | #{@cell[1][6]} |
      | #{@cell[2][0]} | #{@cell[2][1]} | #{@cell[2][2]} | #{@cell[2][3]} | #{@cell[2][4]} | #{@cell[2][5]} | #{@cell[2][6]} |
      | #{@cell[3][0]} | #{@cell[3][1]} | #{@cell[3][2]} | #{@cell[3][3]} | #{@cell[3][4]} | #{@cell[3][5]} | #{@cell[3][6]} |
      | #{@cell[4][0]} | #{@cell[4][1]} | #{@cell[4][2]} | #{@cell[4][3]} | #{@cell[4][4]} | #{@cell[4][5]} | #{@cell[4][6]} |
      | #{@cell[5][0]} | #{@cell[5][1]} | #{@cell[5][2]} | #{@cell[5][3]} | #{@cell[5][4]} | #{@cell[5][5]} | #{@cell[5][6]} |"
  end

  def each_turn(column, icon)
    5.downto(0) do |i|
      if @cell[i][column - 1] == '-'
        @cell[i][column - 1] = icon
        break
      end
    end

    make_change
  end

  def highlight_path(path)
    if @cell[path[0][0]][path[0][1]] == "\u25EF".red
      marker = "\u25EF".red.bg_yellow
    elsif @cell[path[0][0]][path[0][1]] == "\u25EF".yellow
      marker = "\u25EF".yellow.bg_yellow
    end
    path.each do |mark|
      @cell[mark[0]][mark[1]] = marker
    end
    make_change
  end
end

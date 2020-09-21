class Board 
    def initialize
        @board = [[' ', ' ', ' '],[' ', ' ', ' '],[' ', ' ', ' ']]
    end
    def showBoard
        puts "
                Column 

               1   2   3
        
           1   #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]}
        R     ---+---+---
        o  2   #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]}
        w     ---+---+---
           3   #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]}
        "
    end

    def playTurn(row, col, val)
      if @board[row-1][col-1] == ' ' 
        @board[row-1][col-1] = val
        return true
      else
        return false
      end
    end

    def victory?(letter)
      if @board[0][0] == letter && @board[0][0] == @board[0][1] && @board[0][0] == @board[0][2]
        true
      elsif @board[1][0] == letter && @board[1][0] == @board[1][1] && @board[1][0] == @board[1][2]
        true
      elsif @board[2][0] == letter && @board[2][0] == @board[2][1] && @board[2][0] == @board[2][2]
        true
      elsif @board[0][0] == letter && @board[0][0] == @board[1][0] && @board[0][0] == @board[2][0]
        true
      elsif @board[0][1] == letter && @board[0][1] == @board[1][1] && @board[0][1] == @board[2][1]
        true
      elsif @board[0][2] == letter && @board[0][2] == @board[1][2] && @board[0][2] == @board[2][2]
        true
      elsif @board[0][0] == letter && @board[0][0] == @board[1][1] && @board[0][0] == @board[2][2]
        true
      elsif @board[0][2] == letter && @board[0][2] == @board[1][1] && @board[0][2] == @board[2][0]
        true
      else
        false
      end
    end
end

print "(o) Player One Name: "
player1 = gets.chomp
print "(x) Player Two Name: "
player2 = gets.chomp
while true 
  game = Board.new
  game.showBoard
  9.times do |i|
    if i%2==0
      print "\nIt's your turn #{player1}" 
      print "\nRow: "
      row = gets.chomp.to_i
      print "\nColumn: "
      col = gets.chomp.to_i
      if game.playTurn(row, col, 'o') == false
        print "\nThe cell is already taken, please pick another cell"
        print "\nRow: "
        row = gets.chomp.to_i
        print "\nColumn: "
        col = gets.chomp.to_i
      else 
        game.playTurn(row, col, 'o')
      end
      game.showBoard
      if game.victory?('o')
        print "\n#{player1} won the match"
        break
      end
    else 
      print "\nIt's your turn #{player2}" 
      print "\nRow: "
      row = gets.chomp.to_i
      print "\nColumn: "
      col = gets.chomp.to_i
      if game.playTurn(row, col, 'x') == false
        print "\nThe cell is already taken, please pick another cell"
        print "\nRow: "
        row = gets.chomp.to_i
        print "\nColumn: "
        col = gets.chomp.to_i
      else 
        game.playTurn(row, col, 'x')
      end
      game.playTurn(row, col, 'x')
      game.showBoard
      if game.victory?'x'
        print "\n#{player1} won the match"
        break
      end
    end
  end
  print "\nPlay again?[Yes/No]: "
  answer = gets.chomp.downcase
  if answer == 'no' || answer == 'n'
    break
  end
end 
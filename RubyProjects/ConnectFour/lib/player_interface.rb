# frozen_string_literal: true

class Interface
  attr_reader :golden_path
  def game_over?(board)
    return true if victory?(board)

    for i in 0..5
      for j in 0..6
        return false if board[i][j] == '-'
      end
    end

    true
  end

  def victory?(board)
    # Checks for horizontal lines
    for i in 0..5
      for j in 0..3
        temp = board[i][j]
        if temp != '-'
          if temp == board[i][j + 1] && temp == board[i][j + 2] && temp == board[i][j + 3]
            @golden_path = [[i, j], [i, j + 1], [i, j + 2], [i, j + 3]]
            return true
          end
        end
      end
    end

    # Checks for vertical lines
    for i in 0..6
      for j in 0..2
        temp = board[j][i]
        if temp != '-'
          if temp == board[j + 1][i] && temp == board[j + 2][i] && temp == board[j + 3][i]
            @golden_path = [[j, i], [j + 1, i], [j + 2, i], [j + 3, i]]
            return true
          end
        end
      end
    end

    # Checks for diagonal up-down lines
    for i in 0..2
      for j in 0..3
        temp = board[i][j]
        if temp != '-'
          if temp == board[i + 1][j + 1] && temp == board[i + 2][j + 2] && temp == board[i + 3][j + 3]
            @golden_path = [[i, j], [i + 1, j + 1], [i + 2, j + 2], [i + 3, j + 3]]
            return true
          end
        end
      end
    end

    # Checks for diagonal down-up lines
    5.downto(3) do |i|
      for j in 0..3
        temp = board[i][j]
        if temp != '-'
          if temp == board[i - 1][j + 1] && temp == board[i - 2][j + 2] && temp == board[i - 3][j + 3]
            @golden_path = [[i, j], [i - 1, j + 1], [i - 2, j + 2], [i - 3, j + 3]]
            return true
          end
        end
      end
    end
    false
  end
end
